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
set termguicolors

"Stop vim from leaving temp files everywhere
set backupdir=~/.vimtmp
set directory=~/.vimtmp
set undofile
set undodir=~/.vimtmp

let g:loaded_netrw = 1 "disable builtin file explorer
let g:loaded_netrwPlugin = 1

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

"Don't hide things
set conceallevel=0

vnoremap <leader>y "+y
vnoremap <leader>p "+p

nnoremap <leader>p "+p

"C++11 is cool yo
let c_no_curly_error=1

"disable all mouse support
set mouse=

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
nnoremap <S-Tab> :tabprev<CR>
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

let g:python3_host_prog = '$HOME/.vimgit/Vim/nvim-python3/bin/python3'

" Load vim-plug
echo glob("~/.vim/autoload/plug.vim")
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!mkdir -p ~/.vim/autoload'
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.local/share/nvim/plugged')

"--------------------------------------------------------------------------------

"Matchit:
Plug 'https://github.com/adelarsq/vim-matchit'

"Nvim Tree:
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

function! NvimTreeToggleAll()
   let current_tab = tabpagenr()
   if g:nvim_tree_open
      tabdo NvimTreeClose
      let g:nvim_tree_open = 0
   else
      tabdo NvimTreeOpen
      let g:nvim_tree_open = 1
   endif
   execute 'tabnext' current_tab
endfunction
let g:nvim_tree_open = 0
if isdirectory(argv(0))
   let g:nvim_tree_open = 1
endif

"Bind nvim-tree file explorer to q
nnoremap q :call NvimTreeToggleAll()<CR>

"--------------------------------------------------------------------------------
"Sumblime style multiple-cursors
Plug 'mg979/vim-visual-multi'
 
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
Plug 'ctrlpvim/ctrlp.vim'
 
"--------------------------------------------------------------------------------
"MakeShift:
Plug 'johnsyweb/vim-makeshift'

"--------------------------------------------------------------------------------
"Neomake:
Plug 'neomake/neomake'

let g:neomake_cpp_enabled_makers = ['gcc']
let g:neomake_cpp_gcc_args = ['-std=c++14', '-Wall', '-Wextra', '-fsyntax-only']

autocmd! BufWritePost * Neomake

"Mason:
Plug 'mason-org/mason.nvim'

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

"--------------------------------------------------------------------------------
"Tagbar:
Plug 'preservim/tagbar'
nnoremap ] :TagbarToggle<CR>
 
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

call plug#end()

set completeopt=menuone,noselect,popup

lua << EOF
    local function nvim_tree_on_attach(bufnr)
        local api = require "nvim-tree.api"
        local function opts(desc)
            return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end


        api.map.on_attach.default(bufnr)
        vim.keymap.set("n", "<Tab>", "<cmd>tabnext<cr>", opts("next tab"))
        vim.keymap.set("n", "<C-t>", "<cmd>tabnew<cr>", opts("new tab"))
        vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
    end
        
    require("nvim-tree").setup({
        open_on_tab=true,
        on_attach=nvim_tree_on_attach
    })
    require("mason").setup()

    -- configure language servers
    -- Python
    vim.lsp.config('ruff', {
        cmd = {'ruff', 'server'},
        filetypes = {'python'},
        root_markers = {'pyprojects.toml', 'ruff.toml', '.ruff.toml', '.git'},
    })
    vim.lsp.config('pyright', { 
        cmd = {'pyright-langserver', '--stdio'},
        filetypes = {'python'},
        root_markers = {
            'pyrightconfig.json',
            'pyproject.toml',
            'setup.py',
            'setup.cfg',
            'requirements.txt',
            'Pipfile',
            '.git'
        },
        settings = {
            python = {
                pythonPath = vim.fn.exepath('python'),
                analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = 'openFilesOnly',
                    diagnosticSeverityOverrides = {
                        reportAssignmentType = "information",
                        reportRedeclaration = "information",
                        reportIncompatibleMethodOverride = "warning",
                        reportArgumentType = "warning",
                    },
                },
            },
        },
    })

    -- javascript
    vim.lsp.config('quick-lint-js', {
        cmd = {'quick-lint-js', '--lsp-server'},
        filetypes = {'javascript', 'typescript'},
        root_markers = {'package.json', 'jsconfig.json', '.git'}
    })

    -- C++
    vim.lsp.config('clangd', {
        cmd = {'clangd'},
        filetypes = {'c', 'cpp', 'cuda'},
        root_markers = {
            '.clangd',
            '.clang-tidy',
            '.clang-format',
            'compile_commands.json',
            'compile_flags.txt',
            'configure.ac',
            '.git',
        },
        single_file_support = true,
    })

    vim.lsp.enable('ruff')
    vim.lsp.enable('pyright')
    vim.lsp.enable('quick-lint-js')
    vim.lsp.enable('clangd')

    -- Enable native LSP completion 
    vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client:supports_method('textDocument/completion') then
                vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
            end
        end
    })
    vim.keymap.set('i', '<Tab>',   function() return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>' end,   { expr = true })
    vim.keymap.set('i', '<S-Tab>', function() return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>' end, { expr = true })
    vim.keymap.set('i', '<CR>',    function() return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>' end,    { expr = true })


    -- show warnings inline
    vim.diagnostic.config({
        virtual_text = {
            severity = {
                min = vim.diagnostic.severity.ERROR,
            }
        },
        signs = true,
        underline = false
    })

    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

    vim.api.nvim_create_autocmd('CursorHold', {
        callback = function()
            local has_float = false
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_win_get_config(win).relative ~= '' then
                    has_float = true
                    break
                end
            end
            if not has_float then
                vim.diagnostic.open_float(nil, { focus = false })
            end
        end
    })
    vim.opt.updatetime = 1000

    local diagnostics_visible = true
    vim.keymap.set('n', '<leader>d', function()
        if diagnostics_visible then
            vim.diagnostic.hide(nil, 0)
            diagnostics_visible = false
            print('Diagnostics hidden')
        else
            vim.diagnostic.show(nil, 0)
            diagnostics_visible = true
            print('Diagnostics shown')
        end
    end)

EOF

filetype on

autocmd QuickFixCmdPost grep copen
nnoremap <S-F12> :grep! -r '\b<C-R>=expand("<cword>")<CR>\b' ./ --exclude=tags<CR>
