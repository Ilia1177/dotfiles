eval "$(/opt/homebrew/bin/brew shellenv zsh)"
alias ls='ls --color=auto'
alias mkclass='~/.local/bin/scripts/ocf.sh'
alias ktab='kitty @ launch --type=tab --cwd=current'
alias http-serv='python3 -m http.server 8000'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
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
export PATH=$PATH:/Users/ilia/myenv/bin
#export PATH="/usr/local/opt/inetutils/libexec/gnubin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 					# This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 	# This loads nvm bash_completion

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="/usr/local/opt/openjdk@21/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
autoload -Uz compinit && compinit
