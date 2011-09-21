" Vim indent file
" Language:		Z80 assembly
" Maintainer:	Leo Baker-Hytch <ltobh88@gmail.com>
" Created:		2011-03-01
" Last Change:	2011-03-01

if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

setlocal indentexpr=GetZ80Indent(v:lnum)

if exists("*GetZ80Indent")
	finish
endif

function! GetZ80Indent(line_num)

	let prev_codeline_num = prevnonblank(a:line_num)
	let prev_codeline = getline(prev_codeline_num)
	let this_codeline = getline(a:line_num)

	let COMMENT	= '^\s*#'
	let LABEL	= '^\s*[A-Za-z_.][A-Za-z0-9_.]*:'

	" Comments go at column 0, or at the indent level of the previous comment
	if this_codeline =~ COMMENT

		if prev_codeline =~ COMMENT
			return indent(prev_codeline_num)
		endif

		return 0

	endif

	" Labels go at column 0
	if this_codeline =~ LABEL
		return 0
	endif

	" Everything else goes at the indent level of the previous (nonblank) line
	return indent(prev_codeline_num)

endfunction
