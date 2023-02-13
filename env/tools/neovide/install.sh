#!/bin/bash

# Install necessary dependencies
sudo apt install -y curl \
    gnupg ca-certificates git \
    gcc-multilib g++-multilib cmake libssl-dev pkg-config \
    libfreetype6-dev libasound2-dev libexpat1-dev libxcb-composite0-dev \
    libbz2-dev libsndio-dev freeglut3-dev libxmu-dev libxi-dev libfontconfig1-dev \
    libxcursor-dev

# Install Rust if not installed
if !(type cargo >/dev/null 2>&1); then
    curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh
fi

# Fetch and build
cargo install --git https://github.com/neovide/neovide
