set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Bundle 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'

Plugin 'vim-scripts/indentpython.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Solarized'

"Plugin 'tpope/vim-fugitive'
Plugin 'ctrlpvim/ctrlp.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"Setup Vundle End

set backspace=2
set number
set relativenumber
set incsearch
set showcmd
set hlsearch
syntax enable
set autoindent
set ignorecase
set smartcase

autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

" If doing a diff. Upon writing changes to file, automatically update the
" differences
autocmd BufWritePost * if &diff == 1 | diffupdate | endif

filetype plugin indent on
set tabstop=4 softtabstop=4 expandtab shiftwidth=4 smarttab

set viminfo='100,<1000,s100,h

"if !empty($CONEMUBUILD)
    set encoding=utf-8
    set termencoding=utf-8
    "set t_Co=256
    "let &t_AB="\e[48;5;%dm"
    "let &t_AF="\e[38;5;%dm"
    "set bs=indent,eol,start
"endif


""" No Plugins
"" Fuzzy file search
set path+=**
set wildmenu

" {{{ Fixing netrw (provided file search plugin)
let g:netrw_banner = 0
let g:netrw_browse_split = 4    " open in prior window.
let g:netrw_altv = 1        " open splits to right.
let g:netrw_liststyle = 3   " tree view.
" }}}

" Update jump keybindings {{{
nnoremap <Alt-Left> <Ctrl-o>
nnoremap <Alt-Right> <Ctrl-i>
" }}}

" Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Allow modified buffers to be hidden.
set hidden

" Utils {{{
silent function! WINDOWS()
    return (has('win16') || has('win32') || has('win64'))
endfunction
" }}}


" {{{ Plugins
" YouCompleteMe {{{
nnoremap <F12> :YcmCompleter GoToDefinition <CR>
nnoremap <S-F12> :YcmCompleter GoToReferences <CR>
let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_python_binary_path = "C:\\codebase\\randomProjs\\cpython\\PCbuild\\win32\\py_d.exe"
" let g:ycm_server_python_interpreter = "C:/Users/paverma/AppData/Local/Continuum/Miniconda3/envs/matrix/python.exe"
" let g:ycm_python_binary_path = "C:\\Users\\paverma\\AppData\\Local\\Continuum\\Miniconda3\\envs\\matrix\\python.exe"
" }}}

" {{{ Airline
let g:airline_powerline_fonts = 1
" Install powerline/fonts separately
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#whitespace#enabled = 0
set laststatus=2
set timeoutlen=1000 ttimeoutlen=0
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_theme="light"

" }}}

" CtrlP {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'

let g:ctrlp_match_window = 'bottom,order:ttb'
if WINDOWS()
    let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
elseif executable('ag')
    let s:ctrlp_fallback = 'ag %s -l --nocolor --hidden -g ""'
else
    let s:ctrlp_fallback = 'find %s -type f'
endif

let g:ctrlp_user_command = {
            \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': s:ctrlp_fallback
            \ }
" }}}

" Syntastic {{{
let g:syntastic_python_checkers = ['pylint']
" }}}

" }}}

""" Shortcut for now, also need to fix the conda environment thing too.
let g:syntastic_python_pylint_args = '--rcfile=C:\codebase\MatrixInfra\src\python\pylint.rc'
