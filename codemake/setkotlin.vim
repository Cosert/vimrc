set autowrite
source $VIMRC/codemake/codemake.vim

inoremap (<TAB> ( <CR>) <ESC>O<LEFT><RIGHT>
inoremap "<TAB> """ <CR>"""<ESC>O<UP><DOWN>

inoremap :int :Int
inoremap :long :Long
inoremap :double :Double
inoremap :dob :Double
inoremap :string :String
inoremap :strr :String
inoremap :byte :Byte
inoremap :bool :Boolean

inoremap .. ..

"inoremap .array .arrayOf()<LEFT>
"inoremap .list .listOf()<LEFT>
"inoremap .sli .listOf()<LEFT>
"inoremap .mulist .mutableListOf()<LEFT>
"inoremap .mli .mutableListOf()<LEFT>

inoremap .to .to()<LEFT><LEFT>
inoremap .tint .toInt()
inoremap .tlong .toLong()
inoremap .tdouble .toDouble()
inoremap .tdob .toDouble()
inoremap .tstring .toString()
inoremap .tstrr .toString()
inoremap .tbyte .toByte()
inoremap .tbool .toBoolean()
inoremap .tlist .toList()
inoremap .tsli .toList()
inoremap .tmulist .toMutablelist()
inoremap .tmli .toMutableList()

inoremap .spli<SPACE> .split(" ")
inoremap .mp{ .map{}<LEFT>
inoremap .mp} .map{}<LEFT>
inoremap .mpit .map{it.}<LEFT>
inoremap .mpint .map{it.toInt()}
inoremap .mplong .map{it.toLong()}
inoremap .mpdouble .map{it.toDouble()}
inoremap .mpdob .map{it.toDouble()}
inoremap .mpstring .map{it.toString()}
inoremap .mpstrr .map{it.toString()}
inoremap .mpbyte .map{it.toByte()}

inoremap ${ ${}<LEFT>
inoremap $} ${}<LEFT>

let g:KtMakeTp=1
if has('unix') 
    nnoremap <F29> :let g:KtMakeTp = !g:KtMakeTp<CR>
endif
nnoremap <F5> :call CompileKt()<CR>
inoremap <F5> <ESC>:call CompileKt()<CR>
nnoremap <F6> :call RunKt()<CR>


function CompileKt()
    if g:KtMakeTp==1
        set makeprg=kotlinc\ -J-XX:+TieredCompilation\ -J-XX:TieredStopAtLevel=1\ %\ -include-runtime\ -d\ %<.jar\ -DLOCAL_TEST
    else
        set makeprg=kotlinc-native\ -g\ %\ -o\ %<\ -opt\ -DLOCAL_TEST
    endif
    
    make
    
    if g:KtMakeTp==0 && has('win32')
        !mv %<.exe %<.l
    elseif g:KtMakeTp==0
        !mv %<.kexe %<.l
    endif
endfunction

function RunKt()
    if g:KtMakeTp==1
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

