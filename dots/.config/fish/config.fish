# Mac
if test (identify_os) = "mac"
  set -x PATH /opt/homebrew/bin $PATH
end
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
set -Ux PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

## Git Utilities

set PROTECT_BRANCHES 'main|master|develop'

function remove-merged-branch
    git fetch --prune
    git branch --merged | egrep -v "\*|$PROTECT_BRANCHES" | xargs git branch -d
end

# pyenv init
# if command -v pyenv 1>/dev/null 2>&1
#   pyenv init - | source
# end

# rbenv
set -x PATH $HOME/.rbenv/bin $PATH
status --is-interactive; and source (rbenv init -|psub)

# phpenv
set -x PHPENV_ROOT $HOME/.phpenv
if test -d "$HOME/.phpenv"
  set -x PATH $HOME/.phpenv/bin $PATH
  status --is-interactive; and source (phpenv init -|psub)
end

# eb cli
set -x PATH $HOME/.ebcli-virtual-env/executables $PATH
