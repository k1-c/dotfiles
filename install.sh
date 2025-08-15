#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on supported OS
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    print_error "This installer only supports Linux"
    exit 1
fi

# Create temporary directory for installation
TEMP_DIR=$(mktemp -d)
REPO_DIR="$TEMP_DIR/dotfiles"

cleanup() {
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

print_status "Downloading dotfiles..."
git clone https://github.com/k1-c/dotfiles.git "$REPO_DIR"
cd "$REPO_DIR"

print_status "Installing proto (version manager)..."
curl -fsSL https://moonrepo.dev/install/proto.sh | bash -s -- --yes

# Add proto to PATH for current session
export PATH="$HOME/.proto/bin:$PATH"

print_status "Installing Deno via proto..."
proto install deno

print_status "Running dotfiles installation via Deno..."
deno run --allow-all lib/install.ts

print_status "Dotfiles installation completed successfully!"
print_warning "Please restart your shell or run 'source ~/.bashrc' (or your shell's rc file) to apply changes"