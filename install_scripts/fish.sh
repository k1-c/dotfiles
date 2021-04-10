#!/bin/sh
SRC_DIR="${HOME}/dotfiles/.fish"
FISH_CONFIG_DIR="${HOME}/.config/fish"

echo "fish.sh started..."

# Replace to symlinks
rm -r "${FISH_CONFIG_DIR}"
ln -s "${SRC_DIR}" "${FISH_CONFIG_DIR}"

echo "fish.sh completed successfully."
