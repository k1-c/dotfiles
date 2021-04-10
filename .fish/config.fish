alias dev-browser="chromium-browser --disable-web-security --user-data-dir '/tmp/chrome'"
alias ssh-tdpv1="ssh -i ~/.ssh/tdpv1.pem ubuntu@13.113.169.204"
alias ssh-tdpv2="ssh -i ~/.ssh/tdpv2.pem ubuntu@ttt-program-test.atomsolutions.jp"
alias ssh-ttt-api="ssh -i ~/.ssh/ttt-api.pem ubuntu@api.atom-solutions.jp"
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

set -x GOPATH $HOME/.go
set -x PATH /usr/local/go/bin $PATH
set -x GO111MODULE on


## Git Utilities

set PROTECT_BRANCHES 'master|develop'

function remove-merged-branch
    git fetch --prune
    git branch --merged | egrep -v "\*|$PROTECT_BRANCHES" | xargs git branch -d
end