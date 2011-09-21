" http://djcraven5.blogspot.com/2006/10/faster-buffer-switches-in-vim_21.html

function! BufSel(pattern)
    let buflist = []
    let bufcount = bufnr("$")
    let currbufnr = 1

    while currbufnr <= bufcount
        if(buflisted(currbufnr))
            let currbufname = bufname(currbufnr)
            if (exists("g:BufSel_Case_Sensitive") == 0 || g:BufSel_Case_Sensitive == 0)
                let curmatch = tolower(currbufname)
                let patmatch = tolower(a:pattern)
            else
                let curmatch = currbufname
                let patmatch = a:pattern
            endif
            if(match(curmatch, patmatch) > -1)
                call add(buflist, currbufnr)
            endif
        endif
        let currbufnr = currbufnr + 1
    endwhile
    if(len(buflist) > 1)
        for bufnum in buflist
            echo bufnum . ":      ". bufname(bufnum)
        endfor
        let desiredbufnr = input("Enter buffer number: ")
        if(strlen(desiredbufnr) != 0)
            exe ":bu ". desiredbufnr
        endif
    elseif (len(buflist) == 1)
        exe ":bu " . get(buflist,0)
    else
        echo "No matching buffers"
    endif
endfunction
command! -nargs=1 -complete=buffer Bs :call BufSel("<args>")
