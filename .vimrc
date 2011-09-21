" Use Vim settings (rather than Vi)
set nocompatible

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

" Set backup and swap directories
set	writebackup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

" Set tab width
set tabstop=4
set shiftwidth=4

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start whichwrap+=<,>,[,]

set nobackup		" Don't use a backup
set history=50		" Keep 50 lines of command line history
set ruler			" Show the cursor position all the time
set showcmd			" Display incomplete commands
set incsearch		" Do incremental searching

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set guifont=Liberation\ Mono\ 8
"set guifont=Consolas\ 9
"set guifont=Consolas:h9
let g:colors_name="ruby"

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

" GUI options

" Remove menu tearoffs
let &guioptions = substitute(&guioptions, "t", "", "g")

" Hide toolbar
let &guioptions = substitute(&guioptions, "T", "", "g")

" Hide menu bar
let &guioptions = substitute(&guioptions, "m", "", "g")

" Always show tab bar
set showtabline=2

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

" Switch on highlighting of syntax and last search when terminal has colour
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

" Java options

let java_highlight_java_lang_ids=1

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

" Only do this part when compiled with support for autocommands
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for z80 source
  au BufWinEnter,BufRead,BufNewFile *.s  set filetype=z80
  augroup END

else

	" Always set auto-indenting on
    set autoindent

endif " has("autocmd")

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
" Mappings
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

" Editing

" Make <CTRL>-C behave exactly as <Escape>
noremap <C-C> <Esc>
lnoremap <C-C> <Esc>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo, so
" that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Don't use Ex mode, use Q for formatting
map Q gq

" Insert line above current
noremap gO O<Esc>
noremap go o<Esc>

" Insert class header (author (self) and version (current date))
noremap <F5> O/**<CR><CR><CR>@author Leo Baker-Hytch<CR>@version<C-O>:r!date<CR><Esc>kJo/<Esc>4kA<Space>

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

" Toggling

" Toggle expanding tabs to spaces, default off
noremap <F3> :set invexpandtab<CR>
set noexpandtab

" <CTRL>-S toggles search highlighting
noremap <silent><C-S> :set invhlsearch<CR>

" <CTRL>-L toggles line numbers
noremap <silent><C-N> :set invnumber<CR>

" Toggle menu bar
noremap <silent><F1> :set guioptions+=m<CR>
noremap <silent><F2> :set guioptions-=m<CR>

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

" Tabs / buffers

" Map \cd and \lcd to change to the directory of the current file
nmap <silent> <Leader>cd :cd %:p:h<CR>
nmap <silent> <Leader>lcd :lcd %:p:h<CR>


" Better buffer switching (see plugin/BufSel.vim)
cabbr b Bs

" Switch tabs
noremap <silent><C-Tab> :tabn<CR>
noremap <silent><C-S-Tab> :tabp<CR>

" Move a tab with <C-S-Left> and <C-S-Right>
noremap <silent><C-H> :tabp<CR>
noremap <silent><C-L> :tabn<CR>
noremap <silent><C-Left> :execute TabLeft()<CR>
noremap <silent><C-Right> :execute TabRight()<CR>

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

" GUI

" Alt-Space calls System menu
if has ("gui")
	noremap <M-Space> :simalt ~<CR>
	inoremap <M-Space> <C-O>:simalt ~<CR>
	cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
" Functions
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
