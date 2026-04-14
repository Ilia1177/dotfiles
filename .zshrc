eval "$(/opt/homebrew/bin/brew shellenv zsh)"
alias eject='diskutil eject'
alias ls='ls --color=auto'
alias http-serv='python3 -m http.server 8000'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gatekeeperOff='sudo spctl --master-disable'
alias gatekeeperOn='sudo spctl --master-enable'
alias assist='claude -- model devsteral-small-2:latest'

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

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 					# This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 	# This loads nvm bash_completion

# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

# export PATH="/usr/local/opt/llvm/bin:$PATH"

autoload -Uz compinit && compinit

export OLLAMA_NUM_THREADS=8

alias colimaConf='--arch aarch64 --mount $(VOLUMES_PATH):w --vm-type vz'
export COLIMA=true

# Created by `pipx` on 2026-03-06 19:56:13
export PATH="$PATH:/Users/ilia/.local/bin"
export PATH="$PATH:$(npm config get prefix)/bin"
export PATH="$HOME/.local/bin/scripts:$PATH"

# used for claude code
export ANTHROPIC_AUTH_TOKEN="ollama"
export ANTHROPIC_API_KEY=""
export ANTHROPIC_BASE_URL="http://localhost:11434"

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="$JAVA_HOME/bin:$PATH"
export DYLD_LIBRARY_PATH=/opt/homebrew/lib

[ -f ~/.zshrc_private ] && source ~/.zshrc_private
