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

### End of Zinit's installer chunk

zinit ice depth=1
zinit light romkatv/powerlevel10k
if [[ -f "$HOME/.p10k.zsh" ]]; then
  source "$HOME/.p10k.zsh"
fi

zinit load zdharma-continuum/history-search-multi-word

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

if [[ -d "/opt/homebrew" ]]; then
  export BREW_HOME="/opt/homebrew"
elif [[ -d "/home/linuxbrew" ]]; then
  export BREW_HOME="/home/linuxbrew/.linuxbrew"
fi
export PATH="$BREW_HOME/bin:$PATH"
eval "$(brew shellenv)"

export PATH="$HOME/bin:$PATH"
export WORKDIR="$HOME/Workspace"

# zoxide
eval "$(zoxide init zsh)"

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
eval $(npm completion)

# Bun
export BUN_HOME="$(asdf where bun)"
export BUN_LOCAL="$HOME/.bun"
if [[ -f "$BUN_LOCAL/_bun" ]]; then
  zinit creinstall -Q $BUN_LOCAL
fi

# Go
export GOPATH="$WORKDIR"
export PATH="$GOPATH/bin:$PATH"

# OCaml / OPAM
export OPAM_LOCAL="$HOME/.opam"
if [[ -f "$OPAM_LOCAL/opam-init/init.zsh" ]]; then
  source "$OPAM_LOCAL/opam-init/init.zsh"
fi

# Rust
export RUST_HOME="$(asdf where rust)"
export RUST_LOCAL="$RUST_LOCAL/.cargo"
export PATH="$RUST_LOCAL/bin:$PATH"

# Java
export JAVA_HOME="$(asdf where java)"
export PATH="$JAVA_HOME/bin:$PATH"

# Ruby
export RUBY_HOME="$(asdf where ruby)"
export PATH="$RUBY_HOME/bin:$PATH"

# Deno
export DENO_HOME="$(asdf where deno)"
export DENO_LOCAL="$HOME/.deno"
export PATH="$DENO_LOCAL/bin:$PATH"

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

alias j="z"
alias ..="cd .."

alias tf="terraform"

if [[ -f ~/.daangn.zsh ]]; then
  source ~/.daangn.zsh
fi
