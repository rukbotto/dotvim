set nocompatible
filetype off

set rtp+=~/.dotvim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'wincent/Command-T'
Plugin 'tpope/vim-surround'
Plugin 'SirVer/ultisnips.git'
Plugin 'bling/vim-airline.git'
Plugin 'othree/html5.vim.git'
Plugin 'mattn/emmet-vim.git'
Plugin 'nelstrom/vim-qargs.git'
Plugin 'plasticboy/vim-markdown'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'digitaltoad/vim-pug'
Plugin 'tpope/vim-commentary'
Plugin 'jdonaldson/vaxe'
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
Plugin 'tomasr/molokai'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'ludovicchabant/vim-lawrencium'
Plugin 'majutsushi/tagbar'

call vundle#end()

syntax on
filetype plugin indent on

" Enable matchit macro
runtime macros/matchit.vim

" Set colorscheme
colorscheme molokai

" Insert spaces instead of tabs when indenting text
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Autoindent text
set autoindent

" Set encoding to utf-8
set encoding=utf-8

" highlight the current line
set cursorline

" Display info at the bottom of each window
set ruler

" Display line numbers
set number

" Colorize screen past 80 character limit
let &colorcolumn=join(range(80,999),",")

" Set the colorcolumn color to dark grey
highlight ColorColumn ctermbg=DarkGray

" Wrap long lines
set wrap
set linebreak

" Setting textwidth to 80 characters
set textwidth=80

" Highlight all search matches as we type
set hlsearch
set incsearch

" Use a popup menu for displaying completions
set completeopt=menu

" All windows will have a status line
set laststatus=2

" Cursor will be 8 lines away from top/down edges when scrolling
set scrolloff=8

" Line numbers are relative to the current line
set relativenumber

" Use special unicode chars for displaying hidden tab chars, trail spaces and
" whitespace
set list listchars=tab:‣\ ,trail:∙,extends:»,precedes:«

" Leader and local leader remappings
let mapleader=","
let maplocalleader="\\"

" =============================================================================
" Normal mode mappings
" =============================================================================

" Open .vimrc in the current buffer
noremap <Leader>rc :edit $MYVIMRC<CR>

" Open .vimrc.local in the current buffer
noremap <Leader>lrc :edit $MYVIMRC.local<CR>

" Open .gvimrc in the current buffer
noremap <Leader>grc :edit $MYGVIMRC<CR>

" Execute the string subtitution command
nnoremap <Leader>s :%substitute//

" Open tagbar window
nnoremap tag :TagbarOpen fjc<CR>

" Disable arrow keys in normal mode
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>

" Search for a pattern in current buffer
nnoremap / /\v

" =============================================================================
" Insert mode mappings
" =============================================================================

" Disable arrow keys in insert mode
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" =============================================================================
" Visual mode mappings
" =============================================================================

" Search for a pattern in current buffer
vnoremap / /\v

" Search the current word in current buffer
xnoremap * :<C-u> call <SID>SearchVisualSelection()<CR>/<C-r>=@/<CR><CR>

" =============================================================================
" Function for selecting a word in visual mode
" =============================================================================

function! s:SearchVisualSelection()
    let l:temp = @s
    normal! gv"sy
    let @/ = '\V' . substitute(escape(@s, '\/'), '\n', '\\n', "g")
    let @s = l:temp
endfunction

" =============================================================================
" Netrw settings
" =============================================================================

let g:netrw_liststyle = 3

" =============================================================================
" UltiSnips settings
" =============================================================================

let g:UltiSnipsExpandTrigger = "<C-h>"

" =============================================================================
" Airline settings
" =============================================================================

let g:airline_left_sep = '|'
let g:airline_right_sep = '|'
let g:airline_theme = "molokai"

" =============================================================================
" Command-T settings
" =============================================================================

let g:CommandTWildIgnore = &wildignore
            \ . ",*.pyc,*.swp,*.swo,*.swm,*.swn,node_modules,bin,_site,"
            \ . ",output*,out"
let g:CommandTMaxFiles = 50000

" =============================================================================
" Markdown settings
" =============================================================================

let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_disabled = 1

" =============================================================================
" Jinja settings
" =============================================================================

let g:htmljinja_disable_detection = 1

" =============================================================================
" Molokai colorscheme settings
" =============================================================================

let g:rehash256 = 1

" =============================================================================
" Vaxe settings
" =============================================================================

let g:vaxe_enable_airline_defaults = 0

" =============================================================================
" Source local vimrc file
" =============================================================================

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" =============================================================================
" Autocommands
" =============================================================================

if has("autocmd")
    if !exists("autocommands_loaded")
        let autocommands_loaded = 1

        autocmd FileType css set omnifunc=csscomplete#CompleteCSS
        autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python set omnifunc=pythoncomplete#Complete

        " Setting autowrite on
        autocmd FileType haxe set autowrite

        " Text is not wrapped
        autocmd FileType
                    \ html,htmldjango,htmljinja,phtml,pug,xml
                    \ setlocal nowrap

        " Hidding color column
        autocmd FileType
                    \ html,htmldjango,htmljinja,phtml,pug,xml,markdown
                    \ setlocal colorcolumn=""

        " Settting indentation to 2 columns
        autocmd FileType css,javascript,less,pug,scss,yaml setlocal tabstop=2
        autocmd FileType
                    \ css,javascript,less,pug,scss,yaml
                    \ setlocal shiftwidth=2
        autocmd FileType
                    \ css,javascript,less,pug,scss,yaml
                    \ setlocal softtabstop=2
    endif
endif
