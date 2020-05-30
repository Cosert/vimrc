" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Remap a few keys for Windows behavior
source $VIMRUNTIME/mswin.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

call plug#begin('$VIM/plugged')

Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'scrooloose/syntastic' { 'for': 'Python'}
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'luochen1990/rainbow'
Plug 'kien/ctrlp.vim'
Plug 'Shougo/vimshell'
Plug 'flazz/vim-colorschemes'
Plug 'tomasr/molokai' | Plug 'altercation/solarized'

call plug#end()

filetype plugin indent on

"let g:asyncrun_open = 8 
"let g:rainbow_active = 1
"let g:deoplete#enable_at_startup = 1
let g:airline_theme='molokai'
let g:airline_powerline_fonts = 1
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

if has('gui_running')
    if has("win64")
        au GUIEnter * call libcallnr("vimtweak64.dll", "SetAlpha", 210)
    elseif has("win32")
        au GUIEnter * call libcallnr("vimtweak32.dll", "SetAlpha", 210)
    endif
endif

if has('gui_running') && has("win32")
    if has("win64")
        map <F11> :call libcallnr("gvimfullscreen.dll.x64", "ToggleFullScreen", 0)<CR>
    else
        map <F11> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
    endif
endif

if has("win32")
    colorscheme torte
endif

autocmd BufWritePost $MYVIMRC source $MYVIMRC

set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=l
set guioptions-=b

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
set guifont=Consolas:h17

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



if has('gui_running')
    set lines=40 columns=80
    set guioptions-=T
endif

syntax on
filetype plugin indent on
autocmd BufNewFile,BufRead *.cpp exec "call SetCppFile()"
autocmd BufNewFile,BufRead *.cc exec "call SetCppFile()"
autocmd BufNewFile,BufRead *.c exec "call SetCppFile()"
autocmd BufNewFile,BufRead *.h exec "call SetCppFile()"
autocmd BufNewFile,Bufread *.py exec "call SetPythonFile()"
autocmd BufNewFile,BufRead *.l exec "call Runexec()"
autocmd BufNewFile,BufRead *.md exec "call SetMdFile()"

if has('win32')
    
    set enc=utf-8
    set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
    set langmenu=zh_CN.UTF-8
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
elseif has('unix')
    set guifont=Monospace\ 12
elseif has('mac')
    set guifont=Monaco\ 12
endif

if has('win32') && has('gui_running')
    set termwinkey=<C-_>
    tnoremap <C-V> <C-_>"*
    tnoremap <S-insert> <C-_>"0
    tnoremap <C-A> <C-\><C-N>
    "tnoremap <C-C> <C-\><C-N> <ESC>: close! <CR>
    tnoremap <C-C> <C-C> <CR> exit <CR>
endif

function Runexec()
    exec "call Run()"
    exec "q!"
endfunction

function SetMdFile()
    inoremap // //
    inoremap /tag - 
    inoremap /line <CR><!-- more --><CR>
    inoremap /date -- <ESC>i<ESC>i<ESC>i 
    inoremap /time :: <ESC>i<ESC>i<ESC>i 
    inoremap /link []()<ESC>i<ESC>i<ESC>i
    inoremap /code ``` cpp<CR>```<ESC>O
    inoremap /codec ``` cpp<CR>```<ESC>O
    inoremap /codesh ``` bash<CR>```<ESC>O
    inoremap /psgsp Å@Å@
    inoremap /a1 # 
    inoremap /a2 ## 
    inoremap /a3 ### 
    inoremap /a4 #### 
    inoremap /a5 ##### 
    inoremap /a6 ###### 
    inoremap /a7 ####### 

endfunction

function CodeEditor()
    inoremap ' ''<ESC>i
    inoremap " ""<ESC>i
    inoremap ( ()<ESC>i
    inoremap [ []<ESC>i
    inoremap { { <CR>} <ESC>O
    inoremap } {}<ESC>i
    inoremap ; ; 
    inoremap , , 
    nmap <script> <silent> <F4> :call ToggleQuickfixList()<CR>
    
endfunction

function SetCppFile()
    call CodeEditor()

    set makeprg=g++\ %\ -o\ %<.l\ -g\ -std=c++17\ -O2\ -Wall\ -Wextra\ -Wconversion

    inoremap <F5> <ESC>: call Compile() <CR>
    map <F5> : call Compile() <CR>
    if has('gui_running')
        map <C-F5> : call Compile() <CR> : let @0=expand('%<.l') <CR> : term <CR><C-_>"0.l <CR>
        inoremap <C-F5> <ESC>: call Compile() <CR> : let @0=expand("%<.l") <CR> : term <CR><C-_>"0.l <CR>
        map <F6> : let @0=expand('%<.l') <CR> : term <CR><C-_>"0.l <CR>
        map <C-F6> : call Run() <CR>
    else
        map <C-F5> : call Build_And_Run() <CR>
        inoremap <C-F5> <ESC>: call Build_And_Run() <CR>
        map <F6> : call Run() <CR>
    endif
    
    packadd termdebug
    map <F7> : Termdebug %<.l <CR>
    map <F8> : call FormatCode()<CR>
            
endfunction

function SetPythonFile()
    call CodeEditor()
    inoremap : : <CR>
    
    if has('gui_running')
        map <F5> :w <CR> : let @0=expand('%') <CR> : term <CR> python <C-_>"0 <CR>
        inoremap <F5> <ESC> :w <CR> : let @0=expand('%') <CR> : term <CR> python <C-_>"0 <CR>
    else
        map <F5> :w <CR> :!python % <CR>
        inoremap <F5> <ESC> :w <CR> :!python % <CR>
    endif
    inoremap <C-F5> <ESC> :w<CR> : !python %<CR>
    map <C-F5> :w<CR> : !python %<CR>
    map <F6> <ESC> : call Compile()<CR>
    "map <C-F6> <ESC> : call Run()<CR>

endfunction

function SetGoFile()
    call CodeEditor()
    
endfunction

function Compile()
    
    if &filetype == 'cpp'
        set makeprg=g++\ %\ -o\ %<.l\ -g\ -std=c++17\ -O2\ -Wall\ -Wextra\ -Wconversion
    elseif &filetype == 'c'
        set makeprg=gcc\ %\ -o\ %<.l\ -g\ -O2\ -Wall\ -Wextra\ -Wconversion
    elseif &filetype == 'py'
        set makeprg=pyinstaller\ -F\ %
    endif

    exec "w"
    exec "make"
endfunction

function Run()
    if &filetype == 'cpp' || &filetype == 'c'
        if has('win32')
            exec "! %<.l"
        elseif has('unix')
            exec "!time ./%<.l"
        endif
    elseif &filetype == 'sh'
        exec "!bash %"
    endif
endfunction

function Build_And_Run()
    call Compile()
    
    call Run()
endfunction

func! FormatCode()
    exec "w"
    if &filetype == 'cpp' || &filetype == 'C' || &filetype == 'h'
        exec "!astyle --style=ansi -n %"
        exec "e %"
    endif
endfunc

function! s:GetBufferList() 
  redir =>buflist 
  silent! ls 
  redir END 
  return buflist 
endfunction

function! ToggleQuickfixList()
  for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~ "Quickfix List"'), 'str2nr(matchstr(v:val, "\\d\\+"))') 
    if bufwinnr(bufnum) != -1
      cclocall Run() <CR>
      return
    endif
  endfor
  let winnr = winnr()
  if exists("g:toggle_list_copen_command")
    exec(g:toggle_list_copen_command)
  else
    copen
  endif
  if winnr() != winnr
    wincmd p
  endif
endfunction



