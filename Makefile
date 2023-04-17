SHELL=/bin/bash

.PHONY: config
config:
	bash ./config/_register.sh


.PHONY: vscode
vscode:
	bash ./scripts/install_vscode_extension.sh

.PHONY: fonts
fonts:
	bash ./scripts/install_nerd_fonts.sh

.PHONY: preinstall
preinstall:
	bash ./scripts/preinstall.sh
