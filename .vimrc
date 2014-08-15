"--------------------------
"General Stuff
"-------------------------

"autoread when file is changed
set autoread

"filetype plugin
filetype plugin on
filetype indent on
"omnicomplete
set omnifunc=syntaxcomplete#Complete
let g:superTabDefaultCompletionType = "<c-n>"
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

"------------
"UI
"------------

"wildmenu
set wildmenu

"always show current position
set ruler

"ignore case while searching
set ignorecase
set smartcase

"map highlight clear to double-Esc
map <Esc><Esc> :nohl<CR>

"Easy window movement
map <c-l> <c-w>l<c-w>_
map <c-h> <c-w>h<c-w>_
map <c-j> <c-w>j<c-w>_
map <c-k> <c-w>k<c-w>_
map - <C-W><
map + <C-W>>


"regex
set magic

"show matching brackets
set showmatch

"line numbers
"set number
set relativenumber

"Highlight the cursor line
set cursorline

"--------------
"Plugin config
"--------------

"Bind NERDTree file explorer to q
nnoremap q :NERDTreeTabsToggle<CR>

"C++11 is cool yo
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_cpp_config_file = 'syntastic_conf'
let c_no_curly_error=1

"------------------------
"Folding
"------------------------
"Set maximum numner of nested folds to 5
set foldnestmax=5
"Minimum number of lines folded
set foldminlines=4

"folding method to indent then manual
augroup vimrc
  au BufReadPre * setlocal foldmethod=syntax
  au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=manual | endif
augroup END

"Set opening and closing folds to F9
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf
nnoremap <C-F9> zR
nnoremap <M-F9> zM

"Map recording to z instead of q
nnoremap z q

"---------------------
"Colours and fonts
"---------------------
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

"Airline config
set laststatus=2 "always on
let g:airline_theme="jellybeans"
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

"--------------------
"Tabs and shiz
"--------------------

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

"--------------------
" Misc mapping
"--------------------
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

"--------------------
"VUNDLE
"--------------------
" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"let Vundle manage Vundle
Bundle 'gmarik/vundle'

"My Bundles:

"Snipmate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"

"NERD Tree
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'

"The Silver Searcher
Bundle 'rking/ag.vim'

"Sumblime style multiple-cursors
Bundle 'terryma/vim-multiple-cursors'

"Supertab
Bundle 'ervandew/supertab'

"OmniCppComplete
Bundle 'vim-scripts/OmniCppComplete'

"a.vim Alternate Files quickly
Bundle 'vim-scripts/a.vim'

"Ctrl-P fuzzy finding
Bundle 'kien/ctrlp.vim'

"EasyTags
"Bundle 'xolox/vim-misc'
"Bundle 'xolox/vim-easytags'

"Syntastic Syntax checking
Bundle 'scrooloose/syntastic'

"MakeShift auto build detection
Bundle 'johnsyweb/vim-makeshift'

"Git wrapper
Bundle 'tpope/vim-fugitive'

"Air-line
Bundle 'bling/vim-airline'

"Hex highlighing
"undle 'skammer/vim-css-color'


"CoffeeScript
"Bundle 'kchmck/vim-coffee-script'

filetype on



"--------
"CTAGS
"--------

" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/qt4
" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --exclude=*/venv/* --sort=yes --c++-kinds=+p --python-kinds=-i --fields=+iaS --extra=+q --languages=-javascript,tex .<CR>
"Find tags
map <F12> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <S-F12> :tab split<CR>:exec("grep -R \'\\b".expand("<cword>")."\\b\' ./ --include=\*.{cpp,h,c,hpp}")<Bar> cw<CR>

" Load syntastic conf
map<C-F11> :! find -name '*.h' -printf '\%h\n' <bar> sort -u <bar> awk '{print "-I" $0}' > syntastic_conf<CR> :let g:syntastic_cpp_config_file = 'syntastic_conf'<CR>


" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
