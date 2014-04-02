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

let g:colors_name="sumatra"

" Highlight groups

hi Normal       guifg=#D0D1D5       guibg=#202C31
hi NonText      guifg=#435C67       guibg=#1C272B
hi Cursor       guifg=#202C31       guibg=#B0D1DF
hi Search       guifg=#D26D6C       guibg=#202C31       gui=reverse
hi IncSearch    guifg=#D2BA6C       guibg=#202C31       gui=reverse
hi Visual       guifg=#73C79D       guibg=#202C31       gui=reverse
hi MatchParen                       guibg=#333F45       gui=bold

hi LineNr       guifg=#C9CBCF                           gui=none
hi CursorLine                       guibg=#333F45
hi CursorLineNr guifg=#C9CBCF       guibg=#333F45       gui=none
hi CursorColumn                     guibg=#333F45

hi ModeMsg      guifg=#73C79D                           gui=bold
hi MoreMsg      guifg=#73C79D                           gui=bold
hi Question     guifg=#73C79D                           gui=bold
hi ErrorMsg     guifg=#D26D6C       guibg=#202C31       gui=reverse
hi WarningMsg   guifg=#D2BA6C       guibg=#202C31       gui=reverse

hi StatusLine   guifg=#C9CBCF       guibg=#364247       gui=none
hi StatusLineNC guifg=#6F8089       guibg=#333F45       gui=none
hi WildMenu     guifg=#73C79D       guibg=#202C31       gui=reverse

hi Pmenu                            guibg=#2E393F
hi Pmenusel     guifg=#202C31       guibg=#73C79D
hi PmenuSbar                        guibg=#4A565D
hi PmenuThumb                       guibg=#7B888F

hi VertSplit    guifg=#6F8089       guibg=#333F45       gui=none
hi Folded       guifg=#839BA6       guibg=#1C272B
hi FoldColumn   guifg=#839BA6       guibg=#1C272B

hi SpecialKey   guifg=#73C79D

hi DiffAdd      guifg=#E9EBF0       guibg=#5F9785
hi DiffChange   guifg=#DBDDE1       guibg=#425B7C
hi DiffDelete   guifg=#DBDDE1       guibg=#914F52
hi DiffText     guifg=#F0F3F7       guibg=#425B7C       gui=bold

hi SpellBad     guisp=#D26D6C
hi SpellCap     guisp=#70B4D3
hi SpellLocal   guisp=#8E93C9
hi SpellRare    guisp=#AEA6C3

hi Directory    guifg=#69C8C8


" Syntax highlighting groups

hi Comment      guifg=#7FA1B7                           gui=none
hi Constant     guifg=#73C79D                           gui=none
hi Identifier   guifg=#D77474                           gui=none
hi Statement    guifg=#6EC3C3                           gui=none
hi PreProc      guifg=#8EA6C9                           gui=none
hi Type         guifg=#C6BDA5                           gui=none
hi Special      guifg=#AEA6C3                           gui=none

hi Ignore       guifg=#758288
hi Todo         guifg=#72AFD6       guibg=#202C31       gui=bold
hi Error        guifg=#D26D6C       guibg=#202C31       gui=reverse

hi Title        guifg=#CD7271                           gui=none
hi Underlined   guifg=#C9CBCF                           gui=underline

hi link         htmlTag             Type
hi link         htmlEndTag          Type
hi link         htmlTagName         Type
hi link         htmlSpecialTagName  Type
hi link         cssBraces           Normal

hi htmlBold     gui=bold
hi htmlItalic   gui=italic
hi htmlLink     gui=underline


" Color terminal definitions

hi SpecialKey   ctermfg=darkgreen
hi NonText      cterm=bold ctermfg=darkblue
hi Directory    ctermfg=darkcyan
hi ErrorMsg     cterm=bold ctermfg=7 ctermbg=1
hi IncSearch    cterm=none ctermfg=yellow ctermbg=green
hi Search       cterm=none ctermfg=grey ctermbg=blue
hi MoreMsg      ctermfg=darkgreen
hi ModeMsg      cterm=none ctermfg=brown
hi LineNr       ctermfg=3
hi Question     ctermfg=green
hi StatusLine   cterm=bold,reverse
hi StatusLineNC cterm=reverse
hi VertSplit    cterm=reverse
hi Title        ctermfg=5
hi Visual       cterm=reverse
hi VisualNOS    cterm=bold,underline
hi WarningMsg   ctermfg=1
hi WildMenu     ctermfg=0 ctermbg=3
hi Folded       ctermfg=darkgrey ctermbg=none
hi FoldColumn   ctermfg=darkgrey ctermbg=none
hi DiffAdd      ctermbg=4
hi DiffChange   ctermbg=5
hi DiffDelete   cterm=bold ctermfg=4 ctermbg=6
hi DiffText     cterm=bold ctermbg=1


" Syntax highlighting groups

hi Comment      ctermfg=darkcyan
hi Constant     ctermfg=brown
hi Special      ctermfg=5
hi Identifier   ctermfg=6
hi Statement    ctermfg=3
hi PreProc      ctermfg=5
hi Type         ctermfg=2
hi Underlined   cterm=underline ctermfg=5
hi Ignore       cterm=bold ctermfg=7
hi Ignore       ctermfg=darkgrey
hi Error        cterm=bold ctermfg=7 ctermbg=1
