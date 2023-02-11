local vim = vim
local keymap = vim.api.nvim_set_keymap

-- Fishだと使えないプラグインがあるのでZshに変更しておく
vim.opt.shell = "/bin/zsh"
local $SHELL = "/bin/zsh"

-- Plugins
require("jetpack").startup(function(use)
  use {'neoclide/coc.nvim',  'branch' = 'release' }
  use {'junegunn/fzf',  'build' = './install --all', 'merged' = 0 }
  use 'sheerun/vim-polyglot'
  use 'pantharshit00/vim-prisma'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-theme'
  use 'airblade/vim-gitgutter'
  use {'kyoz/purify', 'rtp' = 'vim'}
  use 'rcarriga/nvim-notify'
  use 'bluz71/vim-moonfly-colors'
  use 'beikome/cosme.vim'
  use 'phaazon/hop.nvim'
end)

-- color scheme
vim.api.nvim_command [[colorscheme cosme]]

-- 背景色を透過する
vim.cmd 'autocmd ColorScheme * highlight Normal ctermbg=none'
vim.cmd 'autocmd ColorScheme * highlight NonText ctermbg=none'
vim.cmd 'autocmd ColorScheme * highlight LineNr ctermbg=none'
vim.cmd 'autocmd ColorScheme * highlight Folded ctermbg=none'
vim.cmd 'autocmd ColorScheme * highlight EndOfBuffer ctermbg=none'

-- setting
-- Leaderを<space>に設定
vim.g.mapleader = " "

-- 文字コードをUFT-8に設定
vim.opt.fenc = "utf-8"
-- バックアップファイルを作らない
vim.opt.nobackup = true
-- スワップファイルを作らない
vim.opt.noswapfile = true
-- 編集中のファイルが変更されたら自動で読み直す
vim.opt.autoread = true
-- バッファが編集中でもその他のファイルを開けるように
vim.opt.hidden = true
-- 入力中のコマンドをステータスに表示する
vim.opt.showcmd = true
-- 折り返さない
vim.opt.nowrap = true
-- 通常のyank / pasteでClipboardを有効にする
vim.opt.clipboard:append "unnamedplus"

-- 見た目系
-- 行番号を表示
vim.opt.number = true
-- 現在の行を強調表示
vim.opt.cursorline = true
-- 現在の行を強調表示（縦）
vim.opt.cursorcolumn = true
-- 行末の1文字先までカーソルを移動できるように
vim.opt.virtualedit = "onemore"
-- インデントはスマートインデント
vim.opt.smartindent = true
-- 括弧入力時の対応する括弧を表示
vim.opt.showmatch = true
-- ステータスラインを常に表示
vim.opt.laststatus = 2
-- コマンドラインの補完
vim.opt.wildmode = "list:longest"
-- 折り返し時に表示行単位での移動できるようにする
keymap("n", "j", "gj", {noremap = true})
keymap("n", "k", "gk", {noremap = true})

-- シンタックスハイライトの有効化
-- syntax enable

-- Tab系
vim.opt.list = "listchars=tab:\▸\-"
-- Tab文字を半角スペースにする
vim.opt.expandtab = true
-- 行頭以外のTab文字の表示幅（スペースいくつ分）
vim.opt.tabstop = 2
-- 行頭でのTab文字の表示幅
vim.opt.shiftwidth = 2

-- 検索系
-- 検索文字列が小文字の場合は大文字小文字を区別なく検索する
vim.opt.ignorecase = true
-- 検索文字列に大文字が含まれている場合は区別して検索する
vim.opt.smartcase = true
-- 検索文字列入力時に順次対象文字列にヒットさせる
vim.opt.incsearch = true
-- 検索時に最後まで行ったら最初に戻る
vim.opt.wrapscan = true
-- 検索語をハイライト表示
vim.opt.hlsearch = true
-- ESC連打でハイライト解除
keymap("n", "<esc><esc>", ":nohlsearch<CR><esc>")

-- マウス系
vim.opt.mouse = "a"

-- Disable Allow Keys
keymap("n", "<Up>", "<Nop>")
keymap("n", "<Down>", "<Nop>")
keymap("n", "<Left>", "<Nop>")
keymap("n", "<Right>", "<Nop>")

-- Allow jj to escape insert mode
keymap("i", "<silent> jj", "<esc>")

-- Hで行頭, Lで行末へ
keymap("n", "H", "^")
keymap("n", "L", "$")

-- Ctrl + hjkl でウィンドウ間を移動
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- :Format でフォーマッタ実行
vim.cmd("command! -nargs=0 Format :call CocAction('format')")
-- <leader> + iでも実行
keymap("n", "<leader>i", ":Format<CR>", {noremap: true})

-- :LintfixでESLintの自動修正
vim.cmd("command! -nargs=0 Lintfix :call CocCommand eslint.executeAutofix")

-- coc-fzf-preview
keymap("n", "<Leader>f", "[fzf-p]")
keymap("x", "<Leader>f", "[fzf-p]")

keymap("n", "<silent> [fzf-p]p",     ":<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>")
keymap("n", "<silent> [fzf-p]gs",    ":<C-u>CocCommand fzf-preview.GitStatus<CR>")
keymap("n", "<silent> [fzf-p]ga",    ":<C-u>CocCommand fzf-preview.GitActions<CR>")
keymap("n", "<silent> [fzf-p]b",     ":<C-u>CocCommand fzf-preview.Buffers<CR>")
keymap("n", "<silent> [fzf-p]B",     ":<C-u>CocCommand fzf-preview.AllBuffers<CR>")
keymap("n", "<silent> [fzf-p]o",     ":<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>")
keymap("n", "<silent> [fzf-p]<C-o>", ":<C-u>CocCommand fzf-preview.Jumps<CR>")
keymap("n", "<silent> [fzf-p]g;",    ":<C-u>CocCommand fzf-preview.Changes<CR>")
keymap("n", "[fzf-p]gr",             ":<C-u>CocCommand fzf-preview.ProjectGrep<Space>")
keymap("n", "<silent> [fzf-p]t",     ":<C-u>CocCommand fzf-preview.BufferTags<CR>")
keymap("n", "<silent> [fzf-p]q",     ":<C-u>CocCommand fzf-preview.QuickFix<CR>")
keymap("n", "<silent> [fzf-p]l",     ":<C-u>CocCommand fzf-preview.LocationList<CR>")

-- coc-explorer
keymap("n", "<Leader>e", "<Cmd>CocCommand explorer<CR>")

-- coc-list files
keymap("n", "<Leader>p", ":CocList files<CR>")

-- coc-pair
-- 改行時にカーソル位置を調整する
keymap('i', '<silent><expr>', '<cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"', {noremap = true})

-- coc show documentation on hover
keymap("n", "<silent> K", ":call ShowDocumentation()<CR>", {noremap = true})

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
