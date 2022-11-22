# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit wait lucid for \
      zdharma-continuum/history-search-multi-word \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
  blockf \
      zsh-users/zsh-completions \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions

if [[ -f "$HOME/.p10k.zsh" ]]; then
  source "$HOME/.p10k.zsh"
fi

if [[ -d "/opt/homebrew" ]]; then
  export BREW_HOME="/opt/homebrew"
elif [[ -d "/home/linuxbrew" ]]; then
  export BREW_HOME="/home/linuxbrew/.linuxbrew"
fi
export PATH="$BREW_HOME/bin:$PATH"
eval $(brew shellenv)

export PATH="$HOME/bin:$PATH"
export WORKDIR="$HOME/Workspace"

# autojump
source "$(brew --prefix autojump)/etc/profile.d/autojump.sh"

# fzf
if [[ -f "$HOME/.fzf.zsh" ]]; then
  source "$HOME/.fzf.zsh"
fi
export FZF_DEFAULT_COMMAND="fd - type f"

# asdf
export ASDF_HOME="$(brew --prefix asdf)"
source "$ASDF_HOME/libexec/asdf.sh"

# NodeJS
export NODE_HOME="$(asdf where nodejs)"
export PATH="$(npm -g bin):$PATH"
# export PATH="$(yarn global bin):$PATH"
# export PATH="$(pnpm -g bin):$PATH"

# Go
export GOPATH="$WORKDIR"
export PATH="$GOPATH/bin:$PATH"

# OCaml / OPAM
export OPAM_HOME="$HOME"
if [[ -r "$HOME/.opam/opam-init/init.zsh" ]]; then
  source "$HOME/.opam/opam-init/init.zsh"
fi

# Rust
export RUST_HOME="$(asdf where rust)"
source "$RUST_HOME/env"
#export PATH="$RUST_HOME/bin:$PATH"

# Cargo
export CARGO_HOME="$HOME/.cargo"
export PATH="$CARGO_HOME/bin:$PATH"

# Java
source $HOME/.asdf/plugins/java/set-java-home.zsh
export PATH="$JAVA_HOME/bin:$PATH"

# Ruby
export RUBY_HOME="$(asdf where ruby)"
export PATH="$RUBY_HOME/bin:$PATH"

# Deno
export DENO_HOME="$(asdf where deno)"
export PATH="$DENO_HOME/.deno/bin:$PATH"

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

export VIMRC="$HOME/.config/nvim/init.vim"
alias vimrc="$EDITOR $VIMRC"

export TMUXRC="$HOME/.tmux.conf"
alias tmuxrc="$EDITOR $TMUXRC"

export TERMRC="$HOME/.config/alacritty/alacritty.yml"
alias termrc="$EDITOR $TERMRC"

export IMERC="$HOME/.config/kime/config.yaml"
alias imerc="$EDITOR $IMERC"

alias ..="cd .."

alias tf="terraform"

if [[ -f ~/.daangn.zsh ]]; then
  source ~/.daangn.zsh
fi
