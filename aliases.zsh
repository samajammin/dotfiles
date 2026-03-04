# General
alias o="open"

# Safety flags
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -i"

# Git
alias gs='git status'
alias gb='git branch --sort=committerdate'
alias glpp='git log --pretty=oneline'
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