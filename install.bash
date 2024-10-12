#!/usr/bin/env bash

SOURCE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DATA="${XDG_DATA_HOME:-${HOME}/.local/share}"
mkdir -p "$DATA"

CONFIG="${XDG_CONFIG_HOME:=$HOME/.config}"
mkdir -p "$CONFIG"

function refresh_zsh() {
  local flag="$1"

  echo "refresing env ..."
  echo
  if [[ "$flag" == "verbose" ]]; then
    source "$HOME/.zshrc"
  else
    source "$HOME/.zshrc" &> /dev/null
  fi
}

function link() {
  local SRC="$SOURCE_DIR/$1"
  local DEST="$2"

  echo -n "installing $1 ... "
  if [[ ! -e "$DEST" ]]; then
    ln -sf "$SRC" "$DEST"
    echo "is done"
    echo "$SRC → $DEST"
  else
    echo "is skipped"
  fi
  echo
}

function install_common_dependencies() {
  if [[ -x "$(command -v apt)" ]]; then
    sudo apt update && apt install \
      build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev \
      cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
  fi
}

function install_or_update_zinit() {
  local ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/source"
  if [[ ! -d "$(dirname "$ZINIT_HOME")" ]]; then
    echo "installing zinit to $ZINIT_HOME ..."
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
  else
    echo "updating zinit ..."
    git -C "$ZINIT_HOME" pull
  fi
  echo
}

function install_or_update_homebrew() {
  if [[ ! -x "$(command -v brew)" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ -f "$HOME/linuxbrew/.linuxbrew/bin/brew" ]]; then
      eval "$("$HOME/linuxbrew/.linuxbrew/bin/brew shellenv")"
      ln -sf "$HOME/linuxbrew/.linuxbrew" "/opt/homebrew"
    fi
  else
    echo "homebrew is ready. skipping"
  fi
}

function install_or_update_cargo() {
  if [[ ! -x "$(command -v rustup)" ]]; then
    curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh
  else
    rustup self update
  fi

  if [[ ! -x "$(command -v cargo)" ]]; then
    rustup install stable
    rustup default stable
  fi
}

link "bin" "$HOME/bin"
link "xprofile" "$HOME/.xprofile"
link "zprofile" "$HOME/.zprofile"
link "zshrc" "$HOME/.zshrc"
link "p10k.zsh" "$HOME/.p10k.zsh"
link "zshrc-macos" "$HOME/.zshrc-macos"
link "gitconfig" "$HOME/.gitconfig"
link "yarnrc" "$HOME/.yarnrc"

link "config/environment.d" "$CONFIG/environment.d"
link "config/fontconfig" "$CONFIG/fontconfig"
link "config/kime" "$CONFIG/kime"
link "config/mise" "$CONFIG/mise"
link "config/alacritty" "$CONFIG/alacritty"
link "config/zellij" "$CONFIG/zellij"
link "config/nvim" "$CONFIG/nvim"

FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
cp $SOURCE_DIR/fonts/* "$FONT_DIR"

install_common_dependencies

install_or_update_zinit; refresh_zsh

install_or_update_homebrew; refresh_zsh
brew bundle --file "$SOURCE_DIR/Brewfile"

mise install

install_or_update_cargo

refresh_zsh verbose
