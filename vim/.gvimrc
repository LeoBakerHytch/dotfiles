" GUI options
" ===========

" Use a nice font, and increase the leading
set guifont=Deja\ Vu\ Sans\ Mono\ 8
set linespace=2

" Use console dialogs instead of popups for simple choices
set guioptions+=c

" Hide menu tearoffs, toolbar, and menu bar
let &guioptions = substitute(&guioptions, "t", "", "g")
let &guioptions = substitute(&guioptions, "T", "", "g")
let &guioptions = substitute(&guioptions, "m", "", "g")
