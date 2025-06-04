#!/usr/bin/env bash

set -eo pipefail

SOURCE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

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
  local DIST_NAME="$(lsb_release -sc 2>/dev/null)"
  local INSTALL_DIR="/etc/apt/sources.list.d"

  find "ubuntu/sources.d" -maxdepth 1 -type f -name "*.sources" | while read -r file; do
    echo "Preparing $file"
    sudo ln -sf "$(realpath "$file")" "$INSTALL_DIR/$(basename "$file")"
  done

  if [[ -d "ubuntu/sources.d/$DIST_NAME" ]]; then
    find "ubuntu/sources.d/$DIST_NAME" -type f -name "*.sources" | while read -r file; do
      echo "Preparing $file"
      sudo ln -sf "$(realpath "$file")" "$INSTALL_DIR/$(basename "$file")"
    done
  fi

  sudo apt update
  sudo apt upgrade -y

  sudo apt install -y \
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
    alacritty

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
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Will update homebrew itself
  brew update
}

function install_or_update_cargo() {
  source "$HOME/.cargo/env" &> /dev/null |:

  if [[ ! -x "$(command -v rustup)" ]]; then
    curl -fsSL "https://sh.rustup.rs" | bash
  else
    rustup self update
  fi

  if [[ ! -x "$(command -v cargo)" ]]; then
    rustup install stable
    rustup default stable
  fi

  if [[ ! -x "$(command -v cargo-binstall)" ]]; then
    curl -fsSL "https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh" | bash
  else
    cargo binstall cargo-binstall --no-confirm --force
  fi

  cargo binstall cargo-update --no-confirm --force
  cargo binstall cargo-run-bin --no-confirm --force
  cargo binstall cargo-nextest --no-confirm --force
  cargo binstall cargo-bloat --no-confirm --force
}

function install_or_update_alacritty() {
  if [[ "$(uname)" == "Darwin" ]]; then
    echo "skip installing Alacritty, may be managed by Homebrew"

  elif [[ "$(lsb_release -si)" == "Ubuntu" ]]; then
    echo "skip installing Alacritty, may be managed by APT"

  else
    local ALACRITTY_HOME="$DATA/alacritty"

    if [[ ! -d "$ALACRITTY_HOME" ]]; then
      echo "download Alacritty to $ALACRITTY_HOME..."

      mkdir -p "$(dirname "$ALACRITTY_HOME")"
      git clone "https://github.com/alacritty/alacritty.git" "$ALACRITTY_HOME"

      pushd "$ALACRITTY_HOME" || exit
      cargo build --release
      sudo ln -sf "$(pwd)/target/release/alacritty" "/usr/local/bin/"
      sudo ln -sf "$(pwd)/extra/logo/alacritty-term.svg" "/usr/share/pixmaps//Alacritty.svg"
      sudo desktop-file-install "extra/linux/Alacritty.desktop"
      sudo update-desktop-database "$DATA/applications"
      popd || exit
    else
      pushd "$ALACRITTY_HOME" || exit

      local BEFORE_HASH
      BEFORE_HASH="$(git rev-parse HEAD)"

      git pull

      local AFTER_HASH
      AFTER_HASH="$(git rev-parse HEAD)"

      if [[ "$BEFORE_HASH" != "$AFTER_HASH" ]]; then
        echo "update detected, rebuilding Alacritty..."
        cargo build --release
      fi
      popd || exit
    fi
  fi
}

if [[ "$(uname)" == "Darwin" ]]; then
  include "macos/sysctl.conf" "/etc/sysctl.conf"

elif [[ "$(lsb_release -si)" == "Ubuntu" ]]; then
  link "ubuntu/sysctl.conf"                    "/etc/sysctl.d/99-local.conf"
  link "ubuntu/limits.d/99-nofile-limits.conf" "/etc/security/limits.d/99-nofile-limits.conf"

  install_apt_dependencies
fi

install_or_update_homebrew
brew bundle --upgrade --file "$SOURCE_DIR/Brewfile"

# Rustup may detect the rust installed by Homebrew
RUSTUP_INIT_SKIP_PATH_CHECK=yes \
  install_or_update_cargo
# May require Rust environment
install_or_update_alacritty

install_or_update_zinit

link "bin" "$HOME/bin"
link "fonts" "$HOME/.fonts"
link "gitconfig" "$HOME/.gitconfig"

link "p10k.zsh" "$HOME/.p10k.zsh"
link "zshrc" "$HOME/.zshrc"
link "zshrc-macos" "$HOME/.zshrc-macos"

link "config/mise" "$CONFIG/mise"
link "config/alacritty" "$CONFIG/alacritty"
link "config/zellij" "$CONFIG/zellij"
link "config/nvim" "$CONFIG/nvim"
link "config/mcphub" "$CONFIG/mcphub"

mise install
