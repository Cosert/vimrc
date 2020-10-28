packadd termdebug
source code-editor.vim
	
if &filetype == 'c'
	set makeprg=gcc\ %\ -o\ %<.l\ -g\ -std=c11\ -O2\ -pthread\ -Wall\ -Wextra\ -Wconversion
else
	set makeprg=g++\ %\ -o\ %<.l\ -g\ -std=c++17\ -O3\ -pthread\ -Wall\ -Wextra\ -Wconversion
endif

nnoremap <F5>:make<CR>
inoremap <F5> <ESC>:make<CR>
if has('gui_running')
    nnoremap <F6> : let @0=expand('%<.l') <CR> : term <CR><C-_>"0.l <CR>
    nnoremap <C-F6> : call RunCpp() <CR>
else
    nnoremap <F6> : call RunCpp() <CR>
    nnoremap <C-F6> : call RunCpp() <CR>
endif

function RunCpp()
    if has('win32')
        exec("! %<.l")
    elseif has('unix')
        exec("!time ./%<.l")
        
    endif
endfunction

nnoremap <F7> : Termdebug %<.l <CR>
nnoremap <F8> : call FormatCode()<CR>

function! FormatCode()
    exec "w"
    exec "!astyle --style=ansi -n %"
    exec "e %"
endfunction

