" Vim color file
" Maintainer:	Hans Fugal <hans@fugal.net>
" Last Change:	$Date: 2003/07/24 00:57:11 $
" Last Change:	$Date: 2003/07/24 00:57:11 $
" URL:			http://hans.fugal.net/vim/colors/desert.vim
" Version:		$Id: desert.vim,v 1.7 2003/07/24 00:57:11 fugalh Exp $

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
if version > 580
	" No guarantees for Vim 5.8 and below, but stops it complaining
	hi clear
	if exists("syntax_on")
	syntax reset
	endif
endif
let g:colors_name="andromeda"

" Highlight groups

hi Normal		guifg=grey80		guibg=grey15

hi Cursor		guifg=slategrey		guibg=khaki
hi VertSplit	guifg=grey50 		guibg=#c2bfa5		gui=none
hi Folded		guifg=gold			guibg=grey30
hi FoldColumn	guifg=tan			guibg=grey30
hi IncSearch	guifg=slategrey		guibg=khaki
hi ModeMsg		guifg=goldenrod
hi MoreMsg		guifg=SeaGreen
hi NonText		guifg=LightBlue		guibg=#2A2A2A
hi Question		guifg=springgreen
hi Search		guifg=wheat			guibg=peru
hi SpecialKey	guifg=yellowgreen
hi StatusLine	guifg=black			guibg=#c2bfa5 		gui=none
hi StatusLineNC	guifg=grey50		guibg=#c2bfa5 		gui=none
hi Title		guifg=indianred
hi Visual		guifg=khaki			guibg=olivedrab 	gui=none
hi WarningMsg	guifg=salmon
hi LineNr		guifg=indianred

" Syntax highlighting groups

hi Comment		guifg=#4499DD
hi Constant		guifg=#00CC44
hi Identifier	guifg=#EE4040		gui=bold
hi Statement	guifg=#DD5500
hi PreProc		guifg=#EE40AA		gui=bold
hi Type			guifg=#DDC000
hi Special		guifg=#E3A869
hi Ignore		guifg=grey40
hi Todo			guifg=#EEC900		guibg=#CC1100		gui=bold
"hi Underlined
"hi Error

" Unchanged

"hi LineNr
"hi VisualNOS
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip


" Color terminal definitions

hi SpecialKey	ctermfg=darkgreen
hi NonText		cterm=bold ctermfg=darkblue
hi Directory	ctermfg=darkcyan
hi ErrorMsg		cterm=bold ctermfg=7 ctermbg=1
hi IncSearch	cterm=none ctermfg=yellow ctermbg=green
hi Search		cterm=none ctermfg=grey ctermbg=blue
hi MoreMsg		ctermfg=darkgreen
hi ModeMsg		cterm=none ctermfg=brown
hi LineNr		ctermfg=3
hi Question		ctermfg=green
hi StatusLine	cterm=bold,reverse
hi StatusLineNC cterm=reverse
hi VertSplit	cterm=reverse
hi Title		ctermfg=5
hi Visual		cterm=reverse
hi VisualNOS	cterm=bold,underline
hi WarningMsg	ctermfg=1
hi WildMenu		ctermfg=0 ctermbg=3
hi Folded		ctermfg=darkgrey ctermbg=none
hi FoldColumn	ctermfg=darkgrey ctermbg=none
hi DiffAdd		ctermbg=4
hi DiffChange	ctermbg=5
hi DiffDelete	cterm=bold ctermfg=4 ctermbg=6
hi DiffText		cterm=bold ctermbg=1

" Syntax highlighting groups

hi Comment		ctermfg=darkcyan
hi Constant		ctermfg=brown
hi Special		ctermfg=5
hi Identifier	ctermfg=6
hi Statement	ctermfg=3
hi PreProc		ctermfg=5
hi Type			ctermfg=2
hi Underlined	cterm=underline ctermfg=5
hi Ignore		cterm=bold ctermfg=7
hi Ignore		ctermfg=darkgrey
hi Error		cterm=bold ctermfg=7 ctermbg=1
