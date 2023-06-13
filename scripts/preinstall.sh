sudo apt update

### Lang Env

# Ruby (rbenv)
sudo apt-get install -y rbenv

# Python (pyenv)
curl https://pyenv.run | bash

# Node (Volta)
sudo curl https://get.volta.sh | bash

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Deno
cargo install deno --locked

### Tools

# Git
sudo apt-get install -y git

# Docker
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# gh cli: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

# Docker Compose
sudo apt-get install -y docker-compose

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

# ni https://github.com/antfu/ni
sudo npm i -g @antfu/ni

# icons-in-terminal: https://github.com/sebastiencs/icons-in-terminal
mkdir -p $HOME/tmp
git clone https://github.com/sebastiencs/icons-in-terminal.git $HOME/tmp/icons-in-terminal
bash $HOME/tmp/icons-in-terminal/install-autodetect.sh

# fzf https://github.com/junegunn/fzf
sudo apt-get install -y fzf

# repgrep https://github.com/BurntSushi/ripgrep
sudo apt-get install -y ripgrep
