# General
alias o="open"

# alias grep="grep --color"
# alias egrep="egrep --color"
# alias less="less -Xr"

# alias tailf="tail -f"
# alias l="ls"
# alias la="ls -a"
# alias ll="ls -lah"
# alias ls="ls -G"
# alias o="open"
# alias desk="cd ~/Desktop/"
# alias ~="cd ~/"
# alias ..="cd ../"
# alias ...="cd ../../"
# alias server="open http://localhost:8000 && python -m SimpleHTTPServer"
# alias filecount="ls -l | grep -v ^l | wc -l"

# Secure your moviments and commands
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -i"

# Git
alias gs='git status'
alias gb='git branch --sort=committerdate'
alias glpp='git log --pretty=oneline'
# alias gl='git pull'
# alias gc='git commit -v'
# alias ga='git add'
# alias gaa='git add --all'
# alias gmt='git mergetool'
# alias gx='gitx'
# alias gg='gitg'
# alias gp='git push'
# alias grh='git reset HEAD'
# alias gcopr='git co-pr'

alias fetch='git fetch && git checkout'
alias prune-branches='git branch --merged | egrep -v "(^\*|master|main|develop|dev)" | xargs git branch -d && git remote prune origin'
alias uncommit='git reset --soft HEAD^'
alias recommit='git commit --amend --no-edit'

# Hardhat
alias hh="npx hardhat"

# Docker
alias d="docker"
alias dc="docker-compose"
alias dm="docker-machine"

# Kubernetes
alias k=kubectl

# Others
alias flush="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"

# Function to get aws secret
function awssecret {
  if [[ "$1" == "" ]]
  then
    echo "awssecret <secret-name> <key>"
    return
  fi

  aws secretsmanager get-secret-value --secret-id $1 | jq '.SecretString | fromjson' | jq -r .$2
}