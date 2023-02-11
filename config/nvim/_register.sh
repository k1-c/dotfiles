#!/bin/bash
if [ ! -d ${HOME}/.config/nvim ]; then mkdir -p ${HOME}/.config/nvim; fi
ln -s -f ${PWD}/tools/nvim/init.vim ${HOME}/.config/nvim/init.vim
ln -s -f ${PWD}/tools/nvim/coc-config.json ${HOME}/.config/nvim/coc-config.json