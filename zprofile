if [[ -d "/opt/homebrew" ]]; then
  export BREW_HOME="/opt/homebrew"
elif [[ -d "/home/linuxbrew" ]]; then
  export BREW_HOME="/home/linuxbrew/.linuxbrew"
fi
export PATH="$BREW_HOME/bin:$PATH"
eval "$(brew shellenv)"
