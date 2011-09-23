" Vim color file
" Maintainer:	Leo Baker-Hytch <l.bakerhytch@gmail.com>
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
	hi clear
	if exists("syntax_on")
	syntax reset
	endif
endif

let g:colors_name="ruby"

" Highlight groups

hi Normal		guifg=grey80		guibg=#182533
hi NonText		guifg=LightBlue		guibg=#172330
hi FoldColumn	guifg=LightBlue		guibg=#172330
hi Cursor		guifg=#182533		guibg=#BCE2FF

hi Search		guifg=#182533		guibg=#8AA6C1		gui=none
hi IncSearch	guifg=#182533		guibg=#99B8D0		gui=none
hi Visual		guifg=#ACCDEC		guibg=#2C435E		gui=none
hi MatchParen	guifg=#ACCDEC		guibg=#2C435E		gui=none

hi ModeMsg		guifg=#F9BB08
hi MoreMsg		guifg=#F9BB08
hi Question		guifg=#F9BB08
hi LineNr		guifg=#8C9DBC

hi VertSplit	guifg=grey50 		guibg=#c2bfa5		gui=none
hi Folded		guifg=gold			guibg=grey30
hi SpecialKey	guifg=yellowgreen
hi StatusLine	guifg=black			guibg=#c2bfa5 		gui=none
hi StatusLineNC	guifg=grey50		guibg=#c2bfa5 		gui=none
hi Title		guifg=indianred
hi WarningMsg	guifg=salmon

" Syntax highlighting groups
"
" Comment:		Blue
" Constant:		Green
" Identifier:	Red
" Statement:	Orange
" PreProc:		Pink
" Type:			Yellow
" Special:		Straw
" Error:		Red background

hi Comment		guifg=#5898DD
hi Constant		guifg=#20CC20
hi Identifier	guifg=#CC3B3C		gui=bold
hi Statement	guifg=#DD5503
hi PreProc		guifg=#DD4099		gui=bold
hi Type			guifg=#F9BB00		gui=bold
hi Special		guifg=#E69D50
hi Ignore		guifg=grey40
hi Todo			guifg=#EEEEFF		guibg=#182533		gui=bold
hi Error		guifg=grey80		guibg=#DD2B2C

"hi Underlined

" Unchanged

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
