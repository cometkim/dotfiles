#!/usr/bin/env bash

set -eo pipefail

SOURCE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SOURCE_DIR"

if [[ -r /etc/os-release ]]; then
  source /etc/os-release
  OS_ID="${ID:-}"
  OS_CODENAME="${VERSION_CODENAME:-}"
fi

DATA="${XDG_DATA_HOME:-${HOME}/.local/share}"
mkdir -p "$DATA"

CONFIG="${XDG_CONFIG_HOME:=$HOME/.config}"
mkdir -p "$CONFIG"

WORKDIR="$HOME/Workspace"
mkdir -p "$WORKDIR/src"
mkdir -p "$WORKDIR/tmp"

function do_prefix() {
  case "$1" in
    "$HOME"/*|"$HOME") echo -n "" ;;
    *) echo -n "sudo" ;;
  esac
}

function link() {
  local SRC="$SOURCE_DIR/$1"
  local DEST="$2"

  local DO
  DO="$(do_prefix "$DEST")"

  echo -n "installing $1 ... "
  if ! $DO test -e "$DEST"; then
    $DO ln -sf "$SRC" "$DEST"
    echo "is done"
    echo "$SRC → $DEST"
  else
    echo "is skipped"
  fi
  echo
}

function include() {
  local SRC="$SOURCE_DIR/$1"
  local DEST="$2"

  local DO
  DO="$(do_prefix "$DEST")"

  $DO touch "$DEST"
  echo "ensuring $2 to include $1 ... "
  while IFS= read -r line; do
    [[ -z "$line" || "$line" =~ ^# ]] && continue

    if ! $DO grep -Fxq "$line" "$DEST"; then
      echo "$line" | $DO tee -a "$DEST" > /dev/null
    fi
  done < "$SRC"
}

function install_apt_dependencies() {
  local INSTALL_DIR="/etc/apt/sources.list.d"
  local -a ADDITIONAL_PACKAGES=()

  local file
  while IFS= read -r file; do
    echo "Preparing $file"
    sudo ln -sf "$(realpath "$file")" "$INSTALL_DIR/$(basename "$file")"
    ADDITIONAL_PACKAGES+=("$(basename "$file" .sources)")
  done < <(find "ubuntu/sources.d" -maxdepth 1 -type f -name "*.sources")

  if [[ -d "ubuntu/sources.d/$OS_CODENAME" ]]; then
    while IFS= read -r file; do
      echo "Preparing $file"
      sudo ln -sf "$(realpath "$file")" "$INSTALL_DIR/$(basename "$file")"
      ADDITIONAL_PACKAGES+=("$(basename "$file" .sources)")
    done < <(find "ubuntu/sources.d/$OS_CODENAME" -type f -name "*.sources")
  fi

  sudo apt update
  sudo apt upgrade -y

  sudo apt install -y \
    curl \
    git \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    libsqlite3-dev \
    libbz2-dev \
    libfreetype6-dev \
    libfontconfig1-dev \
    libxcb-xfixes0-dev \
    libxkbcommon-dev \
    build-essential \
    cmake \
    g++ \
    pkg-config \
    python3 \
    wget \
    alacritty \
    zsh \
    "${ADDITIONAL_PACKAGES[@]}"

  sudo apt autoremove -y
}

function install_or_update_zinit() {
  local ZINIT_HOME="$DATA/zinit/source"
  if [[ ! -d "$ZINIT_HOME" ]]; then
    echo "installing zinit to $ZINIT_HOME..."
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone "https://github.com/zdharma-continuum/zinit.git" "$ZINIT_HOME"
  else
    echo "updating zinit..."
    git -C "$ZINIT_HOME" pull
  fi
  echo
}

function install_or_update_homebrew() {
  if [[ ! -x "$(command -v brew)" ]]; then
    echo "installing Homebrew ..."
    curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh" | bash
    if [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
      sudo ln -sf "/home/linuxbrew/.linuxbrew" "/opt/homebrew"
    fi
  fi
  eval "$(/opt/homebrew/bin/brew shellenv bash)"

  # Will update homebrew itself
  brew update
}

function install_or_update_cargo() {
  if [[ ! -x "$(command -v rustup)" ]]; then
    curl -fsSL "https://sh.rustup.rs" \
      | bash -s -- -y --default-toolchain stable --no-modify-path
  else
    rustup self update
  fi

  source "$HOME/.cargo/env" &> /dev/null || :

  if [[ ! -x "$(command -v cargo)" ]]; then
    rustup install stable
    rustup default stable
  fi
}

function set_default_terminal() {
  local TERMINAL="$(command -v alacritty)"

  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$TERMINAL" 50
  sudo update-alternatives --set x-terminal-emulator "$TERMINAL"

  if command -v gsettings > /dev/null \
    && [[ -n "$DBUS_SESSION_BUS_ADDRESS" ]] \
    && gsettings writable org.gnome.settings-daemon.plugins.media-keys custom-keybindings > /dev/null 2>&1 \
    && gsettings list-relocatable-schemas 2> /dev/null | grep -qx "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"; then
    local KB="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$KB']"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KB name 'Terminal'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KB command 'alacritty'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KB binding '<Primary><Alt>t'
  else
    echo "skip rebinding Ctrl+Alt+T (no GNOME/D-Bus session)"
  fi
}

if [[ "$(uname)" == "Darwin" ]]; then
  include "macos/sysctl.conf" "/etc/sysctl.conf"

elif [[ "$OS_ID" == "ubuntu" ]]; then
  link "ubuntu/sysctl.conf"                    "/etc/sysctl.d/99-local.conf"
  link "ubuntu/limits.d/99-nofile-limits.conf" "/etc/security/limits.d/99-nofile-limits.conf"

  install_apt_dependencies

  sudo chsh -s /usr/bin/zsh "$USER"
  set_default_terminal
fi

install_or_update_homebrew
brew bundle --upgrade --file "$SOURCE_DIR/Brewfile"

# Rustup may detect the rust installed by Homebrew
RUSTUP_INIT_SKIP_PATH_CHECK=yes \
  install_or_update_cargo

install_or_update_zinit

link "bin"       "$HOME/bin"
link "fonts"     "$HOME/.fonts"
link "gitconfig" "$HOME/.gitconfig"

link "p10k.zsh"    "$HOME/.p10k.zsh"
link "zshrc"       "$HOME/.zshrc"
link "zshrc-macos" "$HOME/.zshrc-macos"

link "config/mise"       "$CONFIG/mise"
link "config/alacritty"  "$CONFIG/alacritty"
link "config/ghostty"    "$CONFIG/ghostty"
link "config/zellij"     "$CONFIG/zellij"
link "config/nvim"       "$CONFIG/nvim"
link "config/television" "$CONFIG/television"
link "config/claude"     "$HOME/.claude"
link "config/opencode"   "$CONFIG/opencode"
link "config/AGENTS.md"  "$CONFIG/AGENTS.md"

mise install
