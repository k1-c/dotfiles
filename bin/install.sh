#!/bin/sh

readonly project_root=$(cd $(dirname $0) && cd .. && pwd)
readonly src_path="${project_root%/}/config"

function register() {
  origin="$1"
  target="$2"
  # file exists and not symlink
  if [ -f "${target}" ] && [ ! -h "${target}" ]; then rm "${target}"; fi
  # if it's a symlink, remove old file and place new symlink
  if [ -h "${target}" ]; then rm "${target}"; fi
  ln -s "${origin}" "${target}"
  echo "Replace and link ${target} to ${origin}"
}

# Install zsh
sudo apt-get update && sudo apt-get install zsh -y

# Zsh config
register ${src_path}/fish/config.fish ${HOME}/.config/fish/config.fish
source .zshrc

# This file will be the entry point
curl -fsSL https://moonrepo.dev/install/proto.sh | zsh -s -- --yes
