REPO_DIR=$HOME/.nerd-fonts

if [ -e $REPO_DIR ]; then
  echo "nerd-fonts already installed."
  exit 0
fi

echo "nerd-fonts install started..."
git clone git@github.com:ryanoasis/nerd-fonts.git $REPO_DIR

bash $REPO_DIR/install.sh Hack
