# Debug to disable CORS Policy
alias dev-browser="chromium-browser --disable-web-security --user-data-dir '/tmp/chrome'"
# Docker
alias dc="docker-compose"
# Python
alias p="python"
# Swich current branch by peco
alias gco="git branch -a --sort=-authordate | grep -v -e '->' -e '*' | perl -pe 's/^\h+//g' | perl -pe 's#^remotes/origin/##' | perl -nle 'print if !$c{$_}++' | peco | xargs git checkout"
# Switch GitHub Repositories
alias gr="cd (ghq root)/(ghq list | peco)"
# vim less
alias less="/usr/share/vim/vim81/macros/less.sh"

## Golang

set -x GOPATH $HOME/.go
set -x PATH /usr/local/go/bin $HOME/.go/bin $PATH
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

# direnv
direnv hook fish | source

# rbenv
set -x PATH $HOME/.rbenv/bin $PATH
status --is-interactive; and source (rbenv init -|psub)

# eb cli
set -x PATH $HOME/.ebcli-virtual-env/executables $PATH

