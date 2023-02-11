SHELL=/bin/bash

.PHONY: all
all:
	@nvim
	@neovide
	@shellspec
	@vscode

.PHONY: nvim
nvim:
	if [ ! -d ${HOME}/.config/nvim ]; then mkdir -p ${HOME}/.config/nvim; fi
	ln -s -f ${PWD}/tools/nvim/init.vim ${HOME}/.config/nvim/init.vim
	ln -s -f ${PWD}/tools/nvim/coc-config.json ${HOME}/.config/nvim/coc-config.json

.PHONY: neovide
neovide:
	sh neovide/install_neovide.sh
	if [ ! -d ${HOME}/.config/fish/features/ ]; then mkdir -p ${HOME}/.config/fish/features; fi

.PHONY: shellspec
shellspec:
	sh shellspec/install.sh

.PHONY: vscode
	if [ ! -d ${HOME}/.config/Code/User/ ]; then mkdir -p ${HOME}/.config/Code/User; fi
	ln -s -f ${PWD}/vscode/User/extensions ${HOME}/.config/Code/User/extensions
	ln -s -f ${PWD}/vscode/User/keybindings.json ${HOME}/.config/Code/User/keybindings.json
	ln -s -f ${PWD}/vscode/User/settings.json ${HOME}/.config/Code/User/settings.json


