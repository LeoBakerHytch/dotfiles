" GUI options
" ===========

" Increase the leading
set linespace=2

" Use console dialogs instead of popups for simple choices
set guioptions+=c

" Hide menu tearoffs, toolbar, and menu bar
let &guioptions = substitute(&guioptions, "t", "", "g")
let &guioptions = substitute(&guioptions, "T", "", "g")
let &guioptions = substitute(&guioptions, "m", "", "g")
