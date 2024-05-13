# Set Nerd Fonts
set -g theme_nerd_fonts yes

# Debug to disable CORS Policy
alias dev-browser="chromium-browser --disable-web-security --user-data-dir '/tmp/chrome'"

# Docker
alias dc="docker compose"
alias docker-compose="docker compose"

# Python
alias p="python"

# Swich current branch by peco
alias gco="git branch -a --sort=-authordate | grep -v -e '->' -e '*' | perl -pe 's/^\h+//g' | perl -pe 's#^remotes/origin/##' | perl -nle 'print if !$c{$_}++' | peco | xargs git checkout"

# Switch GitHub Repositories
alias j="cd (ghq root)/(ghq list | peco)"

# use pbcopy on linux
alias pbcopy="xsel --clipboard --input"

# NeoVim
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias vimdiff="nvim -d"

# Exa
alias ll="exa -l -g --icons"
alias lla="ll -a"

## Golang
set -x GOPATH $HOME/.go
set -x PATH /usr/local/go/bin $HOME/.go/bin $PATH
set -x GO111MODULE on

## Python (pyenv)
set -Ux PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
# status is-login; and pyenv init --path | source
# status is-interactive; and pyenv init - | source
pyenv init - | source

## Rust
set -x PATH $HOME/.cargo/bin $PATH

## Git Utilities
set PROTECT_BRANCHES 'main|master|develop'

function remove-merged-branch
    git fetch --prune
    git branch --merged | egrep -v "\*|$PROTECT_BRANCHES" | xargs git branch -d
end

function gsw
    git branch --sort=-authordate |
    grep -v -e '->' -e '*' |
    perl -pe 's/^\h+//g' |
    perl -pe 's#^remotes/origin/##' |
    perl -nle 'print if !$c{$_}++' |
    peco |
    xargs git switch
end

## rbenv
set -x PATH $HOME/.rbenv/bin $PATH
status --is-interactive; and source (rbenv init -|psub)

## phpenv
set -x PHPENV_ROOT $HOME/.phpenv
if test -d "$HOME/.phpenv"
  set -x PATH $HOME/.phpenv/bin $PATH
  status --is-interactive; and source (phpenv init -|psub)
end

## eb cli
set -x PATH $HOME/.ebcli-virtual-env/executables $PATH

## Read Local Configurations
if [ -e $HOME/.config/fish/config.local.fish ]; then
  source ~/.config/fish/config.local.fish
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.fish.inc' ]; . '/opt/google-cloud-sdk/path.fish.inc'; end

# Config Alias
alias vimconf="vim ~/.config/nvim/init.vim"
alias tmuxconf="vim ~/.tmux.conf"
alias shconf="vim ~/.config/fish/config.fish"

# Personal Scripts PATH
set -x PATH "$HOME/dev/scripts" $PATH

# Volta
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
set -gx VOLTA_FEATURE_PNPM 1

# Neovide
alias vide="neovide"

# proto
set -gx PROTO_HOME "$HOME/.proto"
# Global Package PATH
set -gx PATH "$PROTO_HOME/tools/node/21.7.1/bin" $PATH
set -gx PATH "$PROTO_HOME/shims:$PROTO_HOME/bin" $PATH
set -gx PATH "$HOME/.local/bin" $PATH
