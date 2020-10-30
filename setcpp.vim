set autowrite
source $CODEMAKE/codemake.vim

packadd termdebug

if &filetype == 'c'
	set makeprg=gcc\ %\ -o\ %<.l\ -g\ -std=c11\ -O2\ -pthread\ -Wall\ -Wextra\ -Wconversion\ -DLOCAL_TEST
else
	set makeprg=g++\ %\ -o\ %<.l\ -g\ -std=c++17\ -O3\ -pthread\ -Wall\ -Wextra\ -Wconversion\ -DLOCAL_TEST
endif

nnoremap <F5> :make<CR>
inoremap <F5> <ESC>:make<CR>

if has('nvim')
    if has('unix')
        nnoremap <F6> :term time ./%<.l<CR>i
    else
        nnoremap <F6> :term %<.l<CR>i
    endif
elseif has('gui_running')
    if has('unix')
        nnoremap <F6> :term time ./%<.l<CR>
    else
        nnoremap <F6> :term %<.l<CR>
    endif
    nnoremap <C-F6> :call RunCpp()<CR>
else
    nnoremap <F6> :call RunCpp()<CR>
    nnoremap <C-F6> :call RunCpp()<CR>
endif

function RunCpp()
    if has('win32')
        exec "! %<.l"
    elseif has('unix')
        exec "!time ./%<.l"
    endif
endfunction

nnoremap <F7> : Termdebug %<.l <CR>
"nnoremap <F8> : call FormatCode()<CR>

