if [[ -d "/opt/homebrew" ]]; then
  eval "/opt/homebrew/bin/brew shellenv"
elif [[ -d "/home/linuxbrew" ]]; then
  eval "/home/linuxbrew/.linuxbrew/bin/brew shellenv"
fi

if [[ -d "~/.orbstack" ]]; then
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi
