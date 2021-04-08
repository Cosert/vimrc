" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Remap a few keys for Windows behavior
source $VIMRUNTIME/mswin.vim

syntax on

call plug#begin('$VIM/plugged')

Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'scrooloose/syntastic' { 'for': 'Python'}
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'https://github.com/udalov/kotlin-vim.git'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'luochen1990/rainbow'
Plug 'kien/ctrlp.vim'
Plug 'Shougo/vimshell'
Plug 'flazz/vim-colorschemes'
Plug 'tomasr/molokai' | Plug 'altercation/solarized'

call plug#end()

filetype plugin indent on

let g:rainbow_active = 1

"NerdTree 
let NERDTreeQuitOnOpen = 0
let NERDChristmasTree=1
map <leader>f :NERDTreeToggle<CR>
let NERDTreeMinimalUI=1
let NERDTreeWinSize=25

"Ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe

autocmd BufWritePost $MYVIMRC source $MYVIMRC

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set mouse=a		" Enable mouse usage (all modes)
set noundofile
set nobackup
set nocompatible
set smartindent
set nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set cin
set autoindent
"set cursorline
set gcr+=a:blinkon0

if has('gui_running')
    if has('win32')
        set guifont=Consolas:h17
        set enc=utf-8
        set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
        set langmenu=zh_CN.UTF-8
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
    elseif has('unix')
        set guifont=Consolas\ 16
    elseif has('mac')
        set guifont=Monaco\ 12
    endif

    if has("win64")
        au GUIEnter * call libcallnr("vimtweak64.dll", "SetAlpha", 210)
        map <F11> :call libcallnr("gvimfullscreen.dll.x64", "ToggleFullScreen", 0)<CR>
    elseif has("win32")
        au GUIEnter * call libcallnr("vimtweak32.dll", "SetAlpha", 210)
        map <F11> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
    endif

    colorscheme torte

    set lines=40 columns=80
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=l
    set guioptions-=b
endif

noremap j gj
noremap gj j
noremap gk k
noremap k gk
noremap x i
inoremap <C-K> <C-O>gk
inoremap <C-J> <C-O>gj
inoremap <C-H> <Left>
inoremap <C-L> <Right>
tnoremap <C-K> <C-O>gk
tnoremap <C-J> <C-O>gj
tnoremap <C-H> <Left>
tnoremap <C-L> <Right>
inoremap <C-O> <BS>
tnoremap <C-O> <BS>
inoremap <C-Q> <C-O>
tnoremap <C-Q> <C-O>

if has('nvim') && has('win32')
    let $VIMRC='~\AppData'
elseif has('nvim')
    let $VIMRC='~/.config/nvim'
elseif has('win32')
    let $VIMRC=$VIM
else
    let $VIMRC='/usr/share/vim'
endif

autocmd BufNewFile,BufRead *.c source $VIMRC/codemake/setc.vim
autocmd BufNewFile,BufRead *.cc source $VIMRC/codemake/setc.vim
autocmd BufNewFile,BufRead *.cpp source $VIMRC/codemake/setc.vim
autocmd BufNewFile,BufRead *.py source $VIMRC/codemake/setpython.vim
autocmd BufNewFile,BufRead *.kt source $VIMRC/codemake/setkotlin.vim

