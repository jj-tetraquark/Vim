" Vim color file
"
" Author: Jonathan Dark <jonny@jonnydark.com>
"
" Note: Based on the molokai theme by Tomas Restrepo
" And the Flatland Dark theme for Sublime Text 2 by Joel Fillmore
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

let s:molokai_original = 0

hi Boolean         guifg=#AE81FF
hi Character       guifg=#F0DFAF
hi Number          guifg=#AE81FF
hi String          guifg=#F0DFAF
hi Conditional     guifg=#FF9933               gui=bold
hi Constant        guifg=#AE81FF               gui=bold
hi Cursor          guifg=#000000 guibg=#F8F8F0
hi Debug           guifg=#BCA3A3               gui=bold
hi Define          guifg=#66D9EF
hi Delimiter       guifg=#8F8F8F
hi DiffAdd                       guibg=#13354A
hi DiffChange      guifg=#89807D guibg=#4C4745
hi DiffDelete      guifg=#960050 guibg=#1E0010
hi DiffText                      guibg=#4C4745 gui=italic,bold

hi Directory       guifg=#A6E22E               gui=bold
hi Error           guifg=#960050 guibg=#1E0010
hi ErrorMsg        guifg=#FF9933 guibg=#232526 gui=bold
hi Exception       guifg=#A6E22E               gui=bold
hi Float           guifg=#AE81FF
hi FoldColumn      guifg=#465457 guibg=#000000
hi Folded          guifg=#465457 guibg=#000000
hi Function        guifg=#A6E22E
hi Identifier      guifg=#FD971F
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#C4BE89 guibg=#000000

hi Keyword         guifg=#FF9933               gui=bold
hi Label           guifg=#F0DFAF               gui=none
hi Macro           guifg=#C4BE89               gui=italic
hi SpecialKey      guifg=#66D9EF               gui=italic

hi MatchParen      guifg=#000000 guibg=#FD971F gui=bold
hi ModeMsg         guifg=#F0DFAF
hi MoreMsg         guifg=#F0DFAF
hi Operator        guifg=#FF9933

" complete menu
hi Pmenu           guifg=#66D9EF guibg=#000000
hi PmenuSel                      guibg=#808080
hi PmenuSbar                     guibg=#080808
hi PmenuThumb      guifg=#66D9EF

hi PreCondit       guifg=#A6E22E               gui=bold
hi PreProc         guifg=#A6E22E
hi Question        guifg=#66D9EF
hi Repeat          guifg=#FF9933               gui=bold
hi Search          guifg=#FFFFFF guibg=#455354
" marks column
hi SignColumn      guifg=#A6E22E guibg=#232526
hi SpecialChar     guifg=#FF9933               gui=bold
hi SpecialComment  guifg=#465457               gui=bold
hi Special         guifg=#66D9EF guibg=bg      gui=italic
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
hi Statement       guifg=#FF9933               gui=bold
hi StatusLine      guifg=#455354 guibg=fg
hi StatusLineNC    guifg=#808080 guibg=#080808
hi StorageClass    guifg=#FD971F               gui=italic
hi Structure       guifg=#66D9EF
hi Tag             guifg=#FF9933               gui=italic
hi Title           guifg=#ef5939
hi Todo            guifg=#FFFFFF guibg=bg      gui=bold

hi Typedef         guifg=#66D9EF
hi Type            guifg=#66D9EF               gui=none
hi Underlined      guifg=#808080               gui=underline

hi VertSplit       guifg=#808080 guibg=#080808 gui=bold
hi VisualNOS                     guibg=#403D3D
hi Visual                        guibg=#403D3D
hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=bold
hi WildMenu        guifg=#66D9EF guibg=#000000

hi Normal          guifg=#F8F8F2 guibg=#1B1D1E
hi Comment         guifg=#465457
hi CursorLine                    guibg=#293739
hi CursorColumn                  guibg=#293739
hi ColorColumn                   guibg=#232526
hi LineNr          guifg=#465457 guibg=#232526
hi NonText         guifg=#465457
hi SpecialKey      guifg=#465457
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

   hi Keyword         ctermfg=166               cterm=bold
   hi Label           ctermfg=229               cterm=underline
   hi Macro           ctermfg=193
   hi SpecialKey      ctermfg=81

   hi MatchParen      ctermfg=16  ctermbg=221 cterm=bold
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
   hi Title           ctermfg=166
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
end
