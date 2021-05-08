alias dev-browser="chromium-browser --disable-web-security --user-data-dir '/tmp/chrome'"
alias dc="docker-compose"
alias p="python"
alias pm="python manage.py"
alias pmr="python manage.py runserver"
alias g="git"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit -m"
alias gco="git checkout"
alias st="git status"
alias stt="git status -uno"
alias push="git push"
alias pull="git pull"

## Golang

set -x GOPATH $HOME/.go
set -x PATH /usr/local/go/bin $PATH
set -x GO111MODULE on

## Python (pyenv)
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH

## Git Utilities

set PROTECT_BRANCHES 'master|develop'

function remove-merged-branch
    git fetch --prune
    git branch --merged | egrep -v "\*|$PROTECT_BRANCHES" | xargs git branch -d
end

# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end
