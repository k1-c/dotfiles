#!/bin/bash

# tmux: https://github.com/tmux/tmux
sudo apt-get install -y tmux

# exa: https://github.com/ogham/exa
sudo apt-get install -y exa

# peco: https://github.com/peco/peco
sudo apt-get install -y peco

# ghq: https://github.com/x-motemen/ghq
go install github.com/x-motemen/ghq@latest

# xdotools and compiz to resize window to custom size using shortcuts
sudo apt-get install -y xdotools compiz
