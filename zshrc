## Common
export WORKDIR="$HOME/Workspace"

if [[ -d "/opt/homebrew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d "/home/linuxbrew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Auto-start Zellij
export ZELLIJ_AUTO_EXIT="true"
eval "$(zellij setup --generate-auto-start zsh)"

# p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/source"
source "$ZINIT_SOURCE/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
zinit ice depth=1
zinit light romkatv/powerlevel10k
if [[ -f "$HOME/.p10k.zsh" ]]; then
  source "$HOME/.p10k.zsh"
fi
zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# zoxide
eval "$(zoxide init zsh)"

# curl (Cloudflare patch for HTTP/3 support)
export PATH="$(brew --prefix cloudflare/cloudflare/curl)/bin:$PATH"

# fzf
if [[ -f "$HOME/.fzf.zsh" ]]; then
  source "$HOME/.fzf.zsh"
fi
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

# mise
eval "$(mise activate zsh)"

# Classic GOPATH
export GOPATH="$WORKDIR"
export PATH="$GOPATH/bin:$PATH"

# OCaml / OPAM
OPAM_HOME="$HOME/.opam"
if [[ -f "$OPAM_HOME/opam-init/init.zsh" ]]; then
  source "$OPAM_HOME/opam-init/init.zsh"
fi
export DUNE_CACHE="enabled"

# Rust / Cargo
export RUSTUP_HOME="$HOME/.rustup"
export CARGO_HOME="$HOME/.cargo"
export PATH="$CARGO_HOME/bin:$PATH"

# PNPM (for global bins)
export PNPM_HOME="$HOME/.pnpm"
export PATH="$PNPM_HOME:$PATH"

# Docker Client
if [[ -d "~/.orbstack" ]]; then
  # Use OrbStack on MacOS
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
elif [[ -d "$HOME/.rd" ]]; then
  # Rancher Desktop on Linux
  export PATH="$HOME/.rd/bin:$PATH"
fi

# Personal config
export EDITOR="nvim"
export VISUAL="nvim"

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a previously found event.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file.
setopt HIST_VERIFY            # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY         # append to history file
setopt HIST_NO_STORE          # Don't store history commands

alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"

alias l="lsd"
alias ls="lsd"
alias lsa="lsd -a"
alias ll="lsd -l"
alias lla="lsd -la"
alias lt="lsd --tree"

export ZSHRC="$HOME/.zshrc"
alias zshrc="$EDITOR $ZSHRC"

export VIMRC="$HOME/.config/nvim/init.lua"
alias vimrc="$EDITOR $VIMRC"

export TERMRC="$HOME/.config/alacritty/alacritty.yml"
alias termrc="$EDITOR $TERMRC"

alias cd="z"
alias j="z"
alias ..="z .."

alias asdf="mise"

alias tf="terraform"

# Local bins
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

if [[ "$(uname -o)" == "Darwin" ]]; then
  source "$HOME/.zshrc-macos"
fi

# Work profile
if [[ -f "$HOME/.zshrc-work" ]]; then
  source "$HOME/.zshrc-work"
fi

# Credentials
if [[ -f "$HOME/.zshrc-credentials" ]]; then
  source "$HOME/.zshrc-credentials"
fi

# So many telemetries...
export BINSTALL_DISABLE_TELEMETRY="true"
export GATSBY_TELEMETRY_DISABLED="1"
export NEXT_TELEMETRY_DISABLED="1"
export REDWOOD_DISABLE_TELEMETRY="1"
