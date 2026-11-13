# ============================================================
# Platform detection
# ============================================================

case "$OSTYPE" in
  darwin*)
    PLATFORM="macos"
    ;;
  linux*)
    PLATFORM="linux"
    ;;
  *)
    PLATFORM="unknown"
    ;;
esac

# ============================================================
# Homebrew (macOS / Linux)
# ============================================================

if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv zsh)"
fi

# ============================================================
# General aliases
# ============================================================

alias httpserve='python3 -m http.server 8000'
alias dotfiles='git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias py='python3'
alias bitchat='bitchat-tui'

# ls colors
if [[ "$PLATFORM" == "macos" ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi

# Disk usage
alias memory='du -ah / 2>/dev/null | sort -rh | head'
alias memoryshow='df -h'

# ============================================================
# Platform-specific aliases
# ============================================================

if [[ "$PLATFORM" == "macos" ]]; then
  alias eject='diskutil eject'
  alias gatekeeperOff='sudo spctl --master-disable'
  alias gatekeeperOn='sudo spctl --master-enable'
  alias shutdown="osascript -e 'tell application \"System Events\" to shut down'"

elif [[ "$PLATFORM" == "linux" ]]; then
  alias eject='eject'
  alias shutdown='sudo poweroff'
fi

# ============================================================
# Raspberry Pi / SSH
# ============================================================

export PI_HOST='4l3a'
export PI_USER="${PI_USER:-ilia}"

alias piconn='ssh ${PI_USER}@${PI_HOST}.local'
alias piconndist='ssh -p 30778 ilia@82.224.121.38'

# ============================================================
# Arduino
# ============================================================

# Override UNO_PORT if your device changes.
if [[ "$PLATFORM" == "macos" ]]; then
  export UNO_PORT="${UNO_PORT:-/dev/cu.usbmodem21101}"
else
  export UNO_PORT="${UNO_PORT:-/dev/ttyACM0}"
fi

uno() {
  arduino-cli compile --fqbn arduino:avr:uno &&
    arduino-cli upload -p "$UNO_PORT" --fqbn arduino:avr:uno
}

# ============================================================
# Git prompt
# ============================================================

git_branch_name() {
  local branch
  branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null)

  if [[ -n "$branch" ]]; then
    echo "-($branch)"
  fi
}

setopt prompt_subst
prompt='%F{green}%2d%f%F{blue}$(git_branch_name)%f>'

# ============================================================
# Zsh completion
# ============================================================

autoload -Uz compinit
compinit

# ============================================================
# Freebox
# ============================================================

export FREEBOX_PORT_HTTPS=18859
export FREEBOX_PORT_HTTP=22606

# ============================================================
# Ollama
# ============================================================

export OLLAMA_NUM_THREADS=8
export OLLAMA_CONTEXT_LENGTH=32768
export OLLAMA_FLASH_ATTENTION=1
export OLLAMA_KV_CACHE_TYPE=q8_0
export OLLAMA_KEEP_ALIVE=30m

# ============================================================
# Colima (macOS)
# ============================================================

if [[ "$PLATFORM" == "macos" ]]; then
  alias colimaConf='--arch aarch64 --mount $(VOLUMES_PATH):w --vm-type vz'
  export COLIMA=true
fi

# ============================================================
# PATH
# ============================================================

# pipx / user-installed executables
export PATH="$HOME/.local/bin:$PATH"

# Personal scripts
export PATH="$HOME/.local/bin/scripts:$PATH"

# npm global binaries
if command -v npm >/dev/null 2>&1; then
  NPM_PREFIX="$(npm config get prefix 2>/dev/null)"
  if [[ -n "$NPM_PREFIX" ]]; then
    export PATH="$NPM_PREFIX/bin:$PATH"
  fi
fi

# ============================================================
# Java
# ============================================================

if [[ "$PLATFORM" == "macos" ]]; then
  if command -v /usr/libexec/java_home >/dev/null 2>&1; then
    export JAVA_HOME=$(/usr/libexec/java_home -v 21 2>/dev/null)
  fi

elif [[ "$PLATFORM" == "linux" ]]; then
  if command -v javac >/dev/null 2>&1; then
    export JAVA_HOME="$(dirname "$(dirname "$(readlink -f "$(command -v javac)")")")"
  fi
fi

if [[ -n "$JAVA_HOME" && -d "$JAVA_HOME" ]]; then
  export PATH="$JAVA_HOME/bin:$PATH"
fi

# macOS dynamic libraries
if [[ "$PLATFORM" == "macos" ]]; then
  export DYLD_LIBRARY_PATH="/opt/homebrew/lib${DYLD_LIBRARY_PATH:+:$DYLD_LIBRARY_PATH}"
fi

# ============================================================
# pyenv
# ============================================================

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# ============================================================
# Private configuration
# ============================================================

[[ -f "$HOME/.zshrc_private" ]] && source "$HOME/.zshrc_private"

