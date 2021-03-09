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
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit wait lucid for \
      zdharma/history-search-multi-word \
  atinit"zicompinit; zicdreplay" \
      light zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      light zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      light zsh-users/zsh-completions

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && source /usr/local/etc/profile.d/autojump.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd - type f"

# asdf
source "$(brew --prefix asdf)/asdf.sh"

export PATH="$HOME/bin:$PATH"
export WORKDIR="$HOME/Workspace"

# NodeJS
export NODE_HOME="$(asdf where nodejs)"
export PATH="$(npm -g bin):$PATH"
export PATH="$(yarn global bin):$PATH"
export PATH="$(pnpm -g bin):$PATH"

# Go
export GOPATH="$WORKDIR"
export PATH="$GOPATH/bin:$PATH"

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

alias zshrc="$EDITOR ~/.zshrc"
alias vimrc="$EDITOR ~/.config/nvim/init.vim"
alias tmuxrc="$EDITOR ~/.tmux.conf.local"
alias alacrittyrc="$EDITOR ~/.config/alacritty/alacritty.yml"

alias ..="cd .."

alias tf="terraform"
