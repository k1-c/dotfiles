SHELL=/bin/bash

.PHONY: config
config:
	bash ./config/_register.sh

.PHONY: rust
rust:
	bash ./env/rust/install.sh

.PHONY: neovide
neovide:
	bash ./env/tools/neovide/install.sh

.PHONY: shellspec
shellspec:
	bash ./env/tools/shellspec/install.sh

.PHONY: tools
tools:
	@neovide
	@shellspec
