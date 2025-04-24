## Common
export WORKDIR="$HOME/Workspace"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Auto-start Zellij
export ZELLIJ_AUTO_EXIT="true"
eval "$(zellij setup --generate-auto-start zsh)"

# p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source "$HOME/.local/share/zinit/source/zinit.zsh"
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
export FZF_DEFAULT_COMMAND="fd - type f"

# mise
eval "$(mise activate zsh)"

# pnpm for NPM package installation
export PATH="$HOME/.pnpm:$PATH"

# Classic GOPATH
export GOPATH="$WORKDIR"
export PATH="$GOPATH/bin:$PATH"

# OCaml / OPAM
OPAM_HOME="$HOME/.opam"
if [[ -f "$OPAM_HOME/opam-init/init.zsh" ]]; then
  source "$OPAM_HOME/opam-init/init.zsh"
fi

# Rust / Cargo
export RUSTUP_HOME="$HOME/.rustup"
export CARGO_HOME="$HOME/.cargo"
export PATH="$CARGO_HOME/bin:$PATH"

# PNPM (for global bins)
export PNPM_HOME="$HOME/.pnpm"
export PATH="$PNPM_HOME:$PATH"

# Rancher Desktop
if [[ -d "$HOME/.rd" ]]; then
  export PATH="$HOME/.rd/bin:$PATH"
fi

# Personal config
export EDITOR="nvim"
export VISUAL="nvim"

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

export TMUXRC="$HOME/.tmux.conf"
alias tmuxrc="$EDITOR $TMUXRC"

export TERMRC="$HOME/.config/alacritty/alacritty.yml"
alias termrc="$EDITOR $TERMRC"

export IMERC="$HOME/.config/kime/config.yaml"
alias imerc="$EDITOR $IMERC"

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

# So many telemetries...
export BINSTALL_DISABLE_TELEMETRY="true"
export GATSBY_TELEMETRY_DISABLED="1"
export NEXT_TELEMETRY_DISABLED="1"
export REDWOOD_DISABLE_TELEMETRY="1"
