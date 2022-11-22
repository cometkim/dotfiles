#!/usr/bin/env zsh

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

function install_or_update_zinit() {
  local ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
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
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  else
    echo "homebrew is ready. skipping"
  fi
}

function install_or_update_asdf_plugins() {
  local plugins=(
    "bun"
    "deno"
    "golang"
    "grain"
    "java"
    "nodejs"
    "ocaml"
    "python"
    "ruby"
    "rust"
    "terraform"
  )
  for plugin in "${plugins[@]}"; do
    asdf plugin add "$plugin"
  done
  asdf plugin add pbkit "https://github.com/pbkit/asdf-pbkit.git"
  asdf install java openjdk-19
  asdf install
  echo
}

link "bin" "$HOME/bin"
link "zprofile" "$HOME/.zprofile"
link "p10k.zsh" "$HOME/.p10k.zsh"
link "zshrc" "$HOME/.zshrc"
link "gitconfig" "$HOME/.gitconfig"
link "tool-versions" "$HOME/.tool-versions"
link "tmux/.tmux.conf" "$HOME/.tmux.conf"
link "tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"

link "config/nvim" "$CONFIG/nvim"
link "config/kime" "$CONFIG/kime"
link "config/alacritty" "$CONFIG/alacritty"
link "config/coc" "$CONFIG/coc"
link "config/oni2" "$CONFIG/oni2"

install_or_update_zinit; refresh_zsh
install_or_update_homebrew; refresh_zsh

brew bundle --file "$SOURCE_DIR/Brewfile"

install_or_update_asdf_plugins

refresh_zsh verbose
