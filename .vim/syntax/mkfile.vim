syn case ignore

set isk=a-z,A-Z,48-57,',.,_

syn sync fromstart

" Variable declaration
syn match mkDeclaration /[^=]\+\s*=/me=e-1

" Variable use
syn match mkVariable /\$[A-Za-z0-9_]\+/

" Variable value
syn match mkValue /=.*/ms=s+1 contains=mkVariable

" Special %
syn match mkSpecial /%/

" Rule
syn match mkRule /[^:]\+:/me=e-1 contains=mkSpecial

" Dependencies
syn match mkDeps /:.*/ms=s+1 contains=mkSpecial,mkVariable

" Comments
syn match mkComment /#.*$/


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_mkfile_syntax_inits")
if version < 508
let did_mkfile_syntax_inits = 1
command -nargs=+ HiLink hi link <args>
else
command -nargs=+ HiLink hi def link <args>
endif

HiLink mkComment		Comment
HiLink mkDeclaration	Constant
HiLink mkDeps			Type
HiLink mkRule			Identifier
HiLink mkSpecial		Constant
HiLink mkValue			Special
HiLink mkVariable		Constant

delcommand HiLink
endif

let b:current_syntax = "mkfile"
