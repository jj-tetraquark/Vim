"================================================================================
" General Stuff:
"================================================================================

"autoread when file is changed
set autoread

"filetype plugin
filetype plugin on
filetype indent on
"Make the pop up menu a resasonble height
set pumheight=15

set hidden

set nocompatible

"Get rid of the menus
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=l

"Stop vim from leaving temp files everywhere
set backupdir=~/.vimtmp
set directory=~/.vimtmp
set undofile
set undodir=~/.vimtmp

"================================================================================
" UI:
"================================================================================

"wildmenu
set wildmenu

"always show current position
set ruler

"ignore case while searching
set ignorecase
set smartcase
"incremental search
set incsearch

"map highlight clear to double-Esc
map <Esc><Esc> :nohl<CR>

"Easy window movement
map <c-l> <c-w>l
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map - <C-W><
map + <C-W>>

set showcmd

"regex
set magic

"show matching brackets
set showmatch

"line numbers
set relativenumber
set number

"Highlight the cursor line
set cursorline

vnoremap <leader>y "+y
vnoremap <leader>p "+p

nnoremap <leader>p "+p

"C++11 is cool yo
let c_no_curly_error=1

"================================================================================
" Folding:
"================================================================================
"Set maximum numner of nested folds to 5
set foldnestmax=5
"Minimum number of lines folded
set foldminlines=4

"folding method to indent then manual
augroup vimrc
  au BufReadPre * setlocal foldmethod=syntax
  au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=manual | endif
augroup END
set nofoldenable "don't fold on open

"Set opening and closing folds to F9
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf
nnoremap <C-F9> zR
nnoremap <M-F9> zM

"tmux
map [20;5~ <C-F9>

"Map recording to m instead of q
nnoremap m q

"================================================================================
" Colours And Fonts:
"================================================================================
"
"Enable syntax highlighting
syntax on
" For .less files
au BufNewFile,BufRead *.less set filetype=less

"Enable html snippets in asp
au BufNewFile,BufRead *.asp set filetype=aspvbs.html
"Enable html snippets in python
autocmd FileType html set ft=htmldjango.html " For SnipMate


set encoding=utf8

set t_Co=256
"let g:zenburn_high_Contrast=1
"colors zenburn
"colors molokai
colors darkai


"================================================================================
" Tabs And Shiz:
"================================================================================

set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

" And the other kind of tabs
nnoremap <C-t>  :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>i
nnoremap <Tab> :tabnext<CR>
nnoremap ` :tabprev<CR>
nnoremap tc :tabclose<CR>

set autoindent "Auto indent
"set wrap "Wrap line
set nowrap

"Tabulate C++ declarations
nnoremap <leader>= :Tabularize /\S\+;<CR>

"================================================================================
" Misc Mapping:
"================================================================================

"Fat-finger syndrome
command! Cn cn
command! Cp cp
command! W w

"strip trailing whitespace on save
autocmd FileType c,cpp,javascript,python autocmd BufWritePre <buffer> :%s/\s\+$//e

nnoremap <silent><F8> :call QuickFixToggle()<CR>

let g:quickfix_is_open = 0
function! QuickFixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
    else
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

map <C-F5> :tab split<CR>:exec("make")<Bar> cw<CR>

"================================================================================
" Plugins:
"================================================================================

let g:python_host_prog = '/home/jj/.vimgit/Vim/neovim-venv/bin/python2'
let g:python3_host_prog = '/home/jj/.vimgit/Vim/neovim-venv3/bin/python3'

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!mkdir -p ~/.vim/autoload'
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.local/share/nvim/plugged')

"--------------------------------------------------------------------------------

"NERD Tree:
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeTabsToggle'] }
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' }
"Bind NERDTree file explorer to q
nnoremap q :NERDTreeTabsToggle<CR>

"--------------------------------------------------------------------------------
"Sumblime style multiple-cursors
Plug 'terryma/vim-multiple-cursors'
 
"--------------------------------------------------------------------------------
"Avim Alternate Files Quickly:
Plug 'vim-scripts/a.vim', { 'for' : ['c', 'cpp'] }
" make h<->hpp work
let g:alternateExtensions_hpp='c,cpp,h'
let g:alternateExtensions_h='c,cpp,cxx,cc,CC,hpp'
" stop auto-creating files if they don't exist
let g:alternateNoDefaultAlternate = 1
let g:alternateRelativeFiles = 1 " make files relative to cwd
let g:alternateSearchPath = "sfr:../source,sfr:../src,sfr:../include,sfr:../inc,sfr:../,sfr:src/"

"--------------------------------------------------------------------------------
"CtrlP Fuzzy Search:
Plug 'kien/ctrlp.vim'
 
"--------------------------------------------------------------------------------
"MakeShift:
Plug 'johnsyweb/vim-makeshift'

"--------------------------------------------------------------------------------
"Rtags:
Plug 'lyuts/vim-rtags', { 'for': ['c', 'cpp'] }
let g:rtagsAutoLaunchRdm = 1

let g:rtagsConfigured = 0
function! ConfigureRtags(force)
    if(!g:rtagsConfigured || a:force)
        if exists('g:rtagsRcCmd') 
            let compilation_database = system('find -name compile_commands.json') 
            if !empty(compilation_database)
                " configure rtags server
                silent exec ':!rc -J '.compilation_database
                " configure deoplete-clang
                let g:build_dir = systemlist('dirname '.compilation_database)[0]
                if empty(glob(".clang"))
                    let l:clang_conf = 'compilation_database = \"'.g:build_dir.'\"'
                    silent exec ':!echo '.l:clang_conf.' > .clang'
                    call plug#load('deoplete.nvim')
                endif
            else
                echom "Couldn't find a compile_commands.json compilation database"
            endif
        else
            echom "vim-rtags is not running"
        endif
    endif
    let g:rtagsConfigured = 1 
endfunction

" Use rtags to follow but fall back to ctags if not indexed
function! FollowTag()
    redir => l:output
    call rtags#SymbolInfo()
    redir END
    if l:output =~ '^Not indexed'
        exec "tag ".expand("<cword>")
    else
        call rtags#JumpTo(g:SAME_WINDOW)
    endif
endfunction

autocmd FileType cpp nnoremap <c-]> :call FollowTag()<CR>


"--------------------------------------------------------------------------------
"OmniSharp:
Plug 'OmniSharp/omnisharp-vim', { 'for' : 'cs', 'do' : 'UpdateRemotePlugins' }
let g:OmniSharp_server_stdio = 1
"let g:OmniSharp_want_snippet = 1
let g:OmniSharp_selector_ui = 'ctrlp'
"let g:OmniSharp_highlight_types = 2
set completeopt-=preview

augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> <c-]> :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
augroup END


"--------------------------------------------------------------------------------
"Neomake:
Plug 'neomake/neomake'

let g:neomake_cpp_enabled_makers = ['gcc']
let g:neomake_cpp_gcc_args = ['-std=c++11', '-Wall', '-Wextra', '-fsyntax-only']

autocmd! BufWritePost * Neomake

"--------------------------------------------------------------------------------
"NeoComplete:
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neoinclude.vim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-clang', { 'for' : ['cpp', 'c'], 'do' : ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi', { 'for' : 'python', 'do' : ':UpdateRemotePlugins' }



let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"TODO - Make this work in macos 'locate libclang.dylib'
"let libclang=system('find /usr/lib -name libclang.so*')
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang-3.8.so.1'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'


"--------------------------------------------------------------------------------
"NeoSnippet:
Plug 'Shougo/neosnippet'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" load regualr snippets
let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/snippets/'

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Conceal the markers
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

""--------------------------------------------------------------------------------
""UltiSnips:
"Plug 'SirVer/ultisnips'

"--------------------------------------------------------------------------------
"Git Wrapper:
Plug 'tpope/vim-fugitive'
 
"--------------------------------------------------------------------------------
"Background Tasks:
Plug 'tpope/vim-dispatch'

"--------------------------------------------------------------------------------
"Comment Stuff:
Plug 'tpope/vim-commentary'
 
"--------------------------------------------------------------------------------
"Airline:
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
 
set laststatus=2 "always on
let g:airline_theme="zenburn"

"Install powerline fonts if this doesn't work right
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_inactive_collapse=1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.linenr = ''

"--------------------------------------------------------------------------------
"Tabulation:
Plug 'godlygeek/tabular'

"--------------------------------------------------------------------------------
"LaTeX:
Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for' : 'tex' }
 
"================================================================================
call plug#end()

au BufNewFile,BufRead *.cpp,*.h,*.hpp,*.c call ConfigureRtags(0)

"autocmd FileType cs call deoplete#enable_logging('DEBUG', 'deoplete.log')
"#call deoplete#custom#option('sources', { 
"#    \ '_' : ['file', 'buffer'],
"#    \ 'cs': ['omni'] })

filetype on



"================================================================================
" CTAGS:
"================================================================================

" configure tags - add additional tags here or comment out not-used ones
au BufNewFile,BufRead *.cpp,*.h,*.hpp,*.c set tags+=~/.vim/tags/cpp
au BufNewFile,BufRead *.cpp,*.h,*.hpp,*.c set tags+=~/.vim/tags/qt4
au BufNewFile,BufRead *.py set tags+=~/.vim/tags/python
" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --exclude=*/venv/* --sort=yes --c++-kinds=+p --python-kinds=-i --fields=+iaS --extras=+q --languages=-javascript,tex .<CR>
"Find tags
map <F12> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

map <S-F12> :exec("grep! -R \'\\b".expand("<cword>")."\\b\' ./ --include=\*.{cpp,h,c,hpp}")<Bar> cw<CR> 

"tmux bindings
map [24;2~ <S-F12>
map [24;5~ <C-F12>
map [23;5~ <C-F11>

nnoremap } :pop<CR>

nnoremap <leader>] :ptag<CR>

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

"================================================================================
" ROS:
"================================================================================ 
if !empty(glob(".catkin_workspace"))
    let rosversion=systemlist('rosversion -d')[0]
    let g:neomake_cpp_ros_maker = {
    \ 'exe' : 'g++',
    \ 'args' : ['-Wall', '-Wpedantic', '-Wextra', '-fsyntax-only', '-I/opt/ros/'.rosversion.'/include']
    \}
    let compilation_database = system('find -name compile_commands.json') 
    let build_dir = systemlist('dirname '.compilation_database)[0]
    let g:neomake_cpp_clangcheck_maker = {
    \ 'exe' : 'clang-check',
    \ 'args' : ['-p', build_dir ]
    \}
    let g:neomake_cpp_enabled_makers = ['clangcheck']
    set makeprg=catkin_make\ -DCMAKE_EXPORT_COMPILE_COMMANDS=1
endif


