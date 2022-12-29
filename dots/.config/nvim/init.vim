if&compatible
  set nocompatible
endif

" Fishだと使えないプラグインがあるのでZshに変更しておく
set shell=/bin/zsh
let $SHELL = "/bin/zsh"

" Plugins
call jetpack#begin()
call jetpack#add('neoclide/coc.nvim', { 'branch': 'release' })
call jetpack#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
call jetpack#add('sheerun/vim-polyglot')
call jetpack#add('pantharshit00/vim-prisma')
call jetpack#add('vim-airline/vim-airline')
call jetpack#add('vim-airline/vim-airline-theme')
call jetpack#add('airblade/vim-gitgutter')
call jetpack#add('kyoz/purify', { 'rtp': 'vim' })
call jetpack#add('rcarriga/nvim-notify')
call jetpack#add('bluz71/vim-moonfly-colors')
call jetpack#add('beikome/cosme.vim')
call jetpack#end()

" color scheme
syntax on
colorscheme cosme

" 背景色を透過する
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none

" setting
" Leaderを<space>に設定
let mapleader = "\<space>"

"文字コードをUFT-8に設定
" set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" 折り返さない
set nowrap
" 通常のyank / pasteでClipboardを有効にする
if has('mac')
  set clipboard=+unnamed
elseif has('unix')
  set clipboard+=unnamedplus
endif

" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
" set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable

" Tab系
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" マウス系
set mouse=a

" Disable Allow Keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Allow jj to escape insert mode
inoremap <silent> jj <ESC>

" Hで行頭, Lで行末へ
nmap H ^
nmap L $

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" :Format でフォーマッタ実行
command! -nargs=0 Format :call CocAction('format')
" <leader> + iでも実行
nnoremap <leader>i :Format<CR>

" :LintfixでESLintの自動修正
command! -nargs=0 Lintfix :call CocCommand eslint.executeAutofix

" tab settings
if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "そのファイルタイプにあわせたインデントを利用する
  filetype indent on
  " これらのftではインデントを無効に
  "autocmd FileType php filetype indent off

  autocmd FileType markdown        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType apache          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType aspvbs          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType c               setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cpp             setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cs              setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css             setlocal sw=2 sts=2 ts=2 et
  autocmd FileType diff            setlocal sw=4 sts=4 ts=4 et
  autocmd FileType go              setlocal sw=2 sts=2 ts=2 et
  autocmd FileType eruby           setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html            setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java            setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType json            setlocal sw=2 sts=2 ts=2 et
  autocmd FileType typescript      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType typescriptreact setlocal sw=2 sts=2 ts=2 et
  autocmd FileType vue             setlocal sw=2 sts=2 ts=2 et
  autocmd FileType perl            setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php             setlocal sw=2 sts=2 ts=2 et
  autocmd FileType python          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby            setlocal sw=2 sts=2 ts=2 et
  autocmd FileType haml            setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sh              setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sql             setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vb              setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vim             setlocal sw=2 sts=2 ts=2 et
  autocmd FileType wsh             setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xhtml           setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xml             setlocal sw=4 sts=4 ts=4 et
  autocmd FileType yaml            setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh             setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala           setlocal sw=2 sts=2 ts=2 et
  autocmd FileType snippet         setlocal sw=4 sts=4 ts=4 et
endif

" coc-fzf-preview
nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]
" coc-fzf-preview project_mru alias
nmap <Leader>p <Cmd>CocCommand fzf-preview.FromResources buffer project_mru<CR>

nnoremap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>

" coc-explorer
nmap <Leader>e <Cmd>CocCommand explorer<CR>

" coc-pair
" 改行時にカーソル位置を調整する
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

