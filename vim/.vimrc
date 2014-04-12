" Use Vim settings (rather than Vi)
set nocompatible

" Backup and swap
" ===============

" See :help backup
set nobackup
set backupdir=~/.vim-backup
set directory=~/.vim-swap


" Tabbing
" =======

set tabstop=8       " Number of spaces displayed for each <Tab> in the file
set shiftwidth=4    " Number of spaces used by autoindent and '>'
set softtabstop=4   " Number of spaces used by <Tab> and <BS>
set shiftround      " Use multiple of shiftwidth when indenting with '>'


" Interface
" =========

set history=5000    " Number of lines of history to keep
set undolevels=5000 " Number of undo levels to keep
set ruler           " Show the cursor position all the time
set showcmd         " Display incomplete commands
set incsearch       " Highlight matches as search is entered
set hlsearch        " Highlight matches for last search
set ignorecase	    " Ignore case when searching
set smartcase       " ...but only if the search string is all lowercase
set wildmenu        " Use popup suggestions on <Tab> in command line

" Filetypes to be ignored by wildmenu
set wildignore=*.pyc,*.class,*.bak


" Cursor
" ======

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Allow arrow keys to move over start/end of line
set whichwrap+=<,>,[,]


" Mouse
" =====

" In many terminal emulators the mouse works just fine, so enable it
if has('mouse')
  set mouse=a
endif


" Colour
" ======

colorscheme sumatra

" Switch on highlighting of syntax when terminal has colour
if &t_Co > 2 || has("gui_running")
    syntax on
endif


" Filetype detection
" ==================

if has("autocmd")

    " Enable file type detection and language-dependent indenting and settings
    filetype plugin indent on

    augroup vimrc
    au!

    " Jump to last known cursor position when editing a file
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

    augroup END

endif


" Mappings
" ========

" Alternative to <Esc>
noremap <C-C> <Esc>


" Use Q for formatting (not Ex mode)
map Q gq


" Use spacebar as leader
let mapleader=" "


" Save or close the current file
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>


" Insert an empty line
nnoremap <leader>O O<Esc>
nnoremap <leader>o o<Esc>


" Clear search string
nnoremap <silent><leader>/ :call ClearSearchString()<CR>


" Toggling commands
nnoremap <silent><leader>h :set invhlsearch<CR>
nnoremap <silent><leader>n :set invnumber<CR>
nnoremap <silent><leader>r :set invrelativenumber<CR>
nnoremap <silent><leader>$ :set invwrap<CR>
nnoremap <silent><leader><Tab> :set invexpandtab<CR>:set expandtab?<CR>


" Switch tabs
nnoremap <silent><C-Tab> :tabn<CR>
nnoremap <silent><C-S-Tab> :tabp<CR>
nnoremap <silent><C-L> :tabn<CR>
nnoremap <silent><C-H> :tabp<CR>


" Move tabs
nnoremap <silent><C-S-L> :execute MoveTabRight()<CR>
nnoremap <silent><C-S-H> :execute MoveTabLeft()<CR>


" Change to the directory of the current file
" (globally or for current buffer only, respectively)
nnoremap <silent><leader>cc :cd %:p:h<CR>
nnoremap <silent><leader>cl :lcd %:p:h<CR>


" Functions
" =========

function! ClearSearchString()
    let @/ = ""
endfunction


" Custom commands
" ===============

" Diff the current buffer against the file from which it was loaded
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif
