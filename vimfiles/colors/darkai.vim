" Vim color file
"
" Author: Juno Dark <jj@tetraquark.xyz>
" Note: Based on the molokai theme for Vim by
" Tomas Restrepo with elements of zenburn and
" flatland.
"
hi clear

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="darkai"

hi Boolean         guifg=#5F87AF
hi Character       guifg=#FFD7AF
hi Number          guifg=#5F87AF
hi String          guifg=#AFAF87
hi Conditional     guifg=#D75F00               gui=bold
hi Constant        guifg=#5F87AF               gui=bold
hi Cursor          guifg=#000000 guibg=#DADADA
hi Debug           guifg=#FFD7FF               gui=bold
hi Define          guifg=#5FFF5F
hi Delimiter       guifg=#626262
hi DiffAdd                       guibg=#005F87
hi DiffChange      guifg=#D7AFAF guibg=#4E4E4E
hi DiffDelete      guifg=#D70087 guibg=#5F005F
hi DiffText                      guibg=#878787 gui=italic,bold

hi Directory       guifg=#5FAF5F               gui=bold
hi Error           guifg=#5F0000 guibg=#FF8700
hi ErrorMsg        guifg=#FF00AF guibg=#000000 gui=bold
hi Exception       guifg=#5FAF5F               gui=bold
hi Float           guifg=#5F87AF
hi FoldColumn      guifg=#5FAFAF guibg=#000000
hi Folded          guifg=#5FAFAF guibg=#000000
hi Function        guifg=#5FAF5F
hi Identifier      guifg=#FFD75F
hi Ignore          guifg=#808080 guibg=#121212
hi IncSearch       guifg=#D7FFAF guibg=#000000

hi Keyword         guifg=#D75F00               gui=bold
hi Label           guifg=#FFFFAF               gui=none
hi Macro           guifg=#D7FFAF               gui=italic
hi SpecialKey      guifg=#5FD7FF               gui=italic

hi MatchParen      guifg=#FFD75F guibg=#000000 gui=bold
hi ModeMsg         guifg=#FFFFAF
hi MoreMsg         guifg=#FFFFAF
hi Operator        guifg=#D75F00

" complete menu
hi Pmenu           guifg=#D0D0D0 guibg=#080808
hi PmenuSel                      guibg=#808080
hi PmenuSbar                     guibg=#080808
hi PmenuThumb      guifg=#5FD7FF

hi PreCondit       guifg=#5FAF5F               gui=bold
hi PreProc         guifg=#5FAF5F
hi Question        guifg=#5FD7FF
hi Repeat          guifg=#D75F00               gui=bold
hi Search          guifg=#DADADA guibg=#5F8787
" marks column
hi SignColumn      guifg=#5FAF5F guibg=#262626
hi SpecialChar     guifg=#FFD7AF               gui=bold
hi SpecialComment  guifg=#8A8A8A               gui=bold
hi Special         guifg=#5FD7FF guibg=#121212 gui=italic
if has("spell")
    hi SpellBad    guisp=#FF005F gui=undercurl
    hi SpellCap    guisp=#875FAF gui=undercurl
    hi SpellLocal  guisp=#8787FF gui=undercurl
    hi SpellRare   guisp=#E4E4E4 gui=undercurl
endif
hi Statement       guifg=#AF5F5F               gui=none 
hi StatusLine      guifg=#444444 guibg=#DADADA
hi StatusLineNC    guifg=#808080 guibg=#080808
hi StorageClass    guifg=#FFD75F               gui=italic
hi Structure       guifg=#5FAFAF
hi Tag             guifg=#D75F00               gui=italic
hi Title           guifg=#5F87AF
hi Todo            guifg=#5F875F guibg=#121212 gui=bold

hi Typedef         guifg=#5FAFAF
hi Type            guifg=#5FAFAF               gui=none
hi Underlined      guifg=#808080               gui=underline

hi VertSplit       guifg=#5F5F5F guibg=#080808 gui=bold
hi VisualNOS                     guibg=#444444
hi Visual                        guibg=#262626
hi WarningMsg      guifg=#FFFFFF guibg=#444444 gui=bold
hi WildMenu        guifg=#5FD7FF guibg=#000000

hi Normal          guifg=#D0D0D0 guibg=#121212
hi Comment         guifg=#5F5F5F
hi CursorLine                    guibg=#1C1C1C
hi CursorColumn                  guibg=#1C1C1C
hi ColorColumn                   guibg=#1C1C1C
hi LineNr          guifg=#5F5F5F guibg=#080808
hi NonText         guifg=#5F5F5F
hi SpecialKey      guifg=#5F5F5F
"
" Support for 256-color terminal
"
if &t_Co > 255
   hi Normal       ctermfg=252 ctermbg=233
   hi CursorLine               ctermbg=234   cterm=none
   hi Boolean         ctermfg=67
   hi Character       ctermfg=223
   hi Number          ctermfg=67
   hi String          ctermfg=144
   hi Conditional     ctermfg=166               cterm=bold
   hi Constant        ctermfg=67               cterm=bold
   hi Cursor          ctermfg=16  ctermbg=253
   hi Debug           ctermfg=225               cterm=bold
   hi Define          ctermfg=83                cterm=bold
   hi Delimiter       ctermfg=241

   hi DiffAdd                     ctermbg=24
   hi DiffChange      ctermfg=181 ctermbg=239
   hi DiffDelete      ctermfg=162 ctermbg=53
   hi DiffText                    ctermbg=102 cterm=bold

   hi Directory       ctermfg=71               cterm=bold
   hi Error           ctermfg=52 ctermbg=208
   hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold
   hi Exception       ctermfg=71               cterm=bold
   hi Float           ctermfg=67
   hi FoldColumn      ctermfg=73  ctermbg=16
   hi Folded          ctermfg=73  ctermbg=16
   hi Function        ctermfg=71
   hi Identifier      ctermfg=221               cterm=none
   hi Ignore          ctermfg=244 ctermbg=233
   hi IncSearch       ctermfg=193 ctermbg=16

if has("spell")
    hi SpellBad    ctermfg=197 ctermbg=52 
    hi SpellCap    ctermfg=97 cterm=underline
    hi SpellLocal  ctermfg=105 gui=underline
    hi SpellRare   ctermfg=254 gui=underline
endif

   hi Keyword         ctermfg=166               cterm=bold
   hi Label           ctermfg=229               cterm=underline
   hi Macro           ctermfg=193
   hi SpecialKey      ctermfg=81

   hi MatchParen      cterm=NONE,bold
   hi ModeMsg         ctermfg=229
   hi MoreMsg         ctermfg=229
   hi Operator        ctermfg=166

   " complete menu
   hi Pmenu           ctermfg=252  ctermbg=232
   hi PmenuSel                    ctermbg=244
   hi PmenuSbar                   ctermbg=232
   hi PmenuThumb      ctermfg=81

   hi TabLine       ctermbg=233 ctermfg=59 cterm=none
   hi TabLineSel    ctermbg=233 cterm=bold
   hi TabLineFill   ctermbg=233 ctermfg=233

   hi PreCondit       ctermfg=71               cterm=bold
   hi PreProc         ctermfg=71
   hi Question        ctermfg=81
   hi Repeat          ctermfg=166               cterm=bold
   hi Search          ctermfg=253 ctermbg=66

   " marks column
   hi SignColumn      ctermfg=71 ctermbg=235
   hi SpecialChar     ctermfg=223               cterm=bold
   hi SpecialComment  ctermfg=245               cterm=bold
   hi Special         ctermfg=81  ctermbg=233

   " this, return, continue
   hi Statement       ctermfg=131               
   hi StatusLine      ctermfg=238 ctermbg=253
   hi StatusLineNC    ctermfg=244 ctermbg=232
   hi StorageClass    ctermfg=221
   hi Structure       ctermfg=73  cterm=bold
   hi Tag             ctermfg=166
   hi Title           ctermfg=67
   hi Todo            ctermfg=65 ctermbg=233   cterm=bold

   hi Typedef         ctermfg=73
   hi Type            ctermfg=73                
   hi Underlined      ctermfg=244               cterm=underline

   hi VertSplit       ctermfg=59 ctermbg=232   cterm=bold
   hi VisualNOS                   ctermbg=238
   hi Visual                      ctermbg=235
   hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
   hi WildMenu        ctermfg=81  ctermbg=16

   hi Comment         ctermfg=59
   hi CursorColumn                ctermbg=234
   hi ColorColumn                 ctermbg=234
   hi LineNr          ctermfg=59 ctermbg=232
   hi NonText         ctermfg=59
   hi SpecialKey      ctermfg=59

   hi htmlTagName     ctermfg=252 
   hi htmlEndTag      ctermfg=71 cterm=bold

   hi NeomakeErrorSign ctermfg=196
   hi NeomakeWarning   ctermbg=58
   hi NeomakeInfo      ctermbg=23

   hi rustKeyword ctermfg=131
end
