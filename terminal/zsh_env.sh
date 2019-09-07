#!/bin/zsh

DEVELOPMENT_PATH=${DEVELOPMENT_PATH} || "/Users/rhys/Workspace"
SCRIPT=$(realpath $0)
THIS_SCRIPTS_PATH=`dirname $SCRIPT`
COMMANDS_PATH="$THIS_SCRIPTS_PATH/commands"

# Add commonly used folders to $PATH
if [[ $PATH != *"$COMMANDS_PATH"* ]]; then
  export PATH="$PATH:$COMMANDS_PATH"
fi

# Specify default editor. Possible values: vim, nano, ed etc.
export EDITOR=nano

# File search functions
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

# Create a folder and move into it in one command
function mkcd() { mkdir -p "$@" && cd "$_"; }

# Create file and open in atom
function touch-atom { touch "$@" && atom "$_"; }

# Search history
function search-history { history | grep "$@" }

# Amend last git commit
function git-amend { git commit -m "$@" --amend }

# Kubernetes follow pods logs with matching label tag arg
function ku-follow-logs {
  kubectl logs -l $@ -f
}

# Kubernetes quick context switch
function ku-change-context {
  CONTEXT=${1:-docker-desktop}
  NAMESPACE=${2:-default}
  echo "Setting up context..."
  kubectl config set-context $CONTEXT --namespace=$NAMESPACE
  echo "Switching to context..."
  kubectl config use-context $CONTEXT
  echo "Now using following context and namepace..."
  kubectl config current-context
  SET_NAMESPACE="$(kubectl config view --minify --output 'jsonpath={..namespace}')"
  echo $SET_NAMESPACE

  if [[ $SET_NAMESPACE == 'production' ]]; then
    echo "==============WARNING=============="
    echo "============PRODUCTION============="
    echo "=============NAMESPACE============="
  fi
}

# Command aliases
alias g='git'
alias c='clear'
alias ku="kubectl"
alias ku-watch-pods="kubectl get pods -w"
alias ku-context-local="ku-change-context docker-desktop"

# Folder aliases
alias playground="~/Playground"
alias scripts="~/scripts-and-dev-tools"
alias logs="/Users/rhys-murray/scripts-and-dev-tools/logs"
alias ll="ls -lhA"

# File aliases
alias cli-commands="atom ~/scripts-and-dev-tools/bash_commands/zsh_env.sh"
alias survival-guide="atom ~/Documents/survival-guide.md"

# Yaml lint ignore line length
alias yamllint-relaxed='yamllint -d "{extends: relaxed, rules: {line-length: disable}}"'

# Workaround for starting blank line when opening new terminal tab
clear

# Remind self of kubernetes context
echo Context when terminal opened: $(kubectl config current-context)
