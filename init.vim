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

set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=l
set guioptions-=b

noremap j gj
noremap gj j
noremap gk k
noremap k gk
noremap x i
inoremap <C-K> <Up>
inoremap <C-J> <Down>
inoremap <C-H> <Left>
inoremap <C-L> <Right>
tnoremap <C-K> <Up>
tnoremap <C-J> <Down>
tnoremap <C-H> <Left>
tnoremap <C-L> <Right>
inoremap <C-O> <BS>
tnoremap <C-O> <BS>

let $CODEMAKE = '$HOME/.config/nvim' "Change it to where your repo locates or create links of sources to the folder

autocmd BufNewFile,BufRead *.c source $CODEMAKE/setcpp.vim
autocmd BufNewFile,BufRead *.cc source $CODEMAKE/setcpp.vim
autocmd BufNewFile,BufRead *.cpp source $CODEMAKE/setcpp.vim
autocmd BufNewFile,BufRead *.py source $CODEMAKE/setpython.vim
autocmd BufNewFile,BufRead *.kt source $CODEMAKE/setkotlin.vim

