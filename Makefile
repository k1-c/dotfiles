SHELL=/bin/bash

.PHONY: all
all:
	@config
	@env
	@tools

.PHONY: config
config:
	bash ./config/_register.sh

.PHONY: rust
rust:
	bash ./env/rust/install.sh

.PHONY: neovim
neovide:
	bash ./env/tools/neovim/install.sh

.PHONY: neovide
neovide:
	bash ./env/tools/neovide/install.sh

.PHONY: shellspec
shellspec:
	bash ./env/tools/shellspec/install.sh

.PHONY: vscode
	bash ./scripts/install_vscode_extension.sh

.PHONY: fonts
	bash ./scripts/install_nerd_fonts.sh

.PHONY: tools
tools:
	@neovide
	@shellspec

.PHONY: env
env:
	@rust
