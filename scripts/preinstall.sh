### Lang Env

# Ruby (rbenv)
sudo apt-get install -y rbenv

# Python (pyenv)
curl https://pyenv.run | bash

# Node (Volta)
sudo curl https://get.volta.sh | bash

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


### Tools

# Deno
cargo install deno --locked

# Neovim
sudo apt-get install -y neovim

# enable clipboard on neovim
sudo apt-get install -y xclip

# tmux: https://github.com/tmux/tmux
sudo apt-get install -y tmux

# exa: https://github.com/ogham/exa
sudo apt-get install -y exa

# peco: https://github.com/peco/peco
sudo apt-get install -y peco

# ghq: https://github.com/x-motemen/ghq
go install github.com/x-motemen/ghq@latest

# xdotools and compiz to resize window to custom size using shortcuts
sudo apt-get install -y xdotool compiz
