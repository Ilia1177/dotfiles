eval "$(/opt/homebrew/bin/brew shellenv zsh)"

alias eject='diskutil eject'
alias ls='ls --color=auto'
alias httpserve='python3 -m http.server 8000'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gatekeeperOff='sudo spctl --master-disable'
alias gatekeeperOn='sudo spctl --master-enable'
export PI_HOST='4l3a'
alias piconn='ssh ${PI_USER}@${PI_HOST}.local'
alias piconndist='ssh -p 30778 ilia@82.224.121.38'
# alias assist='claude -- model devsteral-small-2:latest'
alias shutdown="osascript -e 'tell application \"System Events\" to shut down'"
alias uno="arduino-cli compile --fqbn arduino:avr:uno && arduino-cli upload -p /dev/cu.usbmodem21101 --fqbn arduino:avr:uno"
alias py="python3"

alias bitchat="bitchat-tui"

alias memory="du -ah / 2>dev/null | sort -rh | head"
alias memoryshow="df -h"
# alias copydisk4="sudo dd if=/dev/disk4 of=~/Documents/backup_risoSC7700.img bs=4m status=progress"
# Git stuff
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '-('$branch')'
  fi
}

# Enable substitution in the prompt.
setopt prompt_subst

# Config for prompt. PS1 synonym.
prompt='%F{green}%2d%f%F{blue}$(git_branch_name)%f>'
# export PATH=$PATH:/Users/ilia/myenv/bin

# active la completion
autoload -Uz compinit && compinit

#connexion a distance pour freeOs
export FREEBOX_PORT_HTTPS=18859
export FREEBOX_PORT_HTTP=22606

#config Ollama
export OLLAMA_NUM_THREADS=8
export OLLAMA_CONTEXT_LENGTH=32768
export OLLAMA_FLASH_ATTENTION=1
export OLLAMA_KV_CACHE_TYPE=q8_0
export OLLAMA_KEEP_ALIVE=30m

#config Colima
alias colimaConf='--arch aarch64 --mount $(VOLUMES_PATH):w --vm-type vz'
export COLIMA=true

# Created by `pipx` on 2026-03-06 19:56:13
export PATH="$PATH:/Users/ilia/.local/bin"
export PATH="$PATH:$(npm config get prefix)/bin"
export PATH="$HOME/.local/bin/scripts:$PATH"

# used for claude code
# export ANTHROPIC_AUTH_TOKEN="ollama"
# export ANTHROPIC_API_KEY=""
# export ANTHROPIC_BASE_URL="http://localhost:11434"

#config Java
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
# export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="$JAVA_HOME/bin:$PATH"
export DYLD_LIBRARY_PATH=/opt/homebrew/lib
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
[ -f ~/.zshrc_private ] && source ~/.zshrc_private

