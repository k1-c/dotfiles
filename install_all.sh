#!/bin/sh
SRC_DIR="${HOME}/dotfiles/install_scripts/*"

# All install script files execute
for file in $SRC_DIR;
do
  bash "${file}"
done
