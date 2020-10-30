set autowrite
source $CODEMAKE/codemake.vim

inoremap "<CR> """ <CR>"""<ESC>O<Up><Down>
inoremap :int :Int
inoremap :long :Long
inoremap :doub :Double
inoremap :str :String
inoremap :byte :Byte
inoremap :bool :Boolean
inoremap .to .to()<LEFT><LEFT>
inoremap .tint .toInt()
inoremap .tlong .toLong()
inoremap .tdoub .toDouble()
inoremap .tstr .toString()
inoremap .tbyte .toByte()
inoremap .tbool .toBoolean()
inoremap .tli .toList()
inoremap .tmli .toMutableList()

let b:KtMakeTp=1
if has('unix') 
    nnoremap <F29> :let b:KtMakeTp = !b:KtMakeTp<CR>
else 
    nnoremap <C-F5> :let b:KtMakeTp = !b:KtMakeTp<CR>
endif
nnoremap <F5> :call CompileKt()<CR>
inoremap <F5> <ESC>:call CompileKt()<CR>
nnoremap <F6> :call RunKt()<CR>


function CompileKt()
    if b:KtMakeTp==1
        set makeprg=kotlinc\ -J-XX:+TieredCompilation\ -J-XX:TieredStopAtLevel=1\ %\ -include-runtime\ -d\ %<.jar\ -DLOCAL_TEST
    else
        set makeprg=kotlinc-native\ -g\ %\ -o\ %<\ -opt\ -DLOCAL_TEST
    endif
    
    make
    
    if b:KtMakeTp==0 && has('win32')
        !mv %<.exe %<.l
    elseif b:KtMakeTp==0
        !mv %<.kexe %<.l
    endif
endfunction

function RunKt()
    if b:KtMakeTp==1
        if has('unix')
            if has('gui_running') || has('nvim')
                exec "term time java -Xms128m -Xmx1280m -Xss64m -XX:+UseSerialGC -jar %<.jar"
            else
                exec "!time java -Xms128m -Xmx1280m -Xss64m -XX:+UseSerialGC -jar %<.jar"
            endif
        else
            if has('gui_running') || has('nvim')
                exec "term java -Xms128m -Xmx1280m -Xss64m -XX:+UseSerialGC -jar %<.jar"
            else
                exec "!java -Xms128m -Xmx1280m -Xss64m -XX:+UseSerialGC -jar %<.jar"
            endif
        endif
    else
        if has('unix')
            if has('gui_running') || has('nvim')
                exec "term time ./%<.l"
            else
                exec "!time ./%<.l"
            endif
        else
            if has('gui_running') || has('nvim')
                exec "term %<.l"
            else
                exec "! %<.l"
            endif
        endif
    endif
    if has('nvim')
        call feedkeys("i")
    endif
endfunction

