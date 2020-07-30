syntax on

"hello
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set hlsearch

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox' " Colour scheme
Plug 'tpope/vim-fugitive' " Git wrapper for vim
Plug 'octol/vim-cpp-enhanced-highlight' " Better C++ Syntax Highlighting
Plug 'Valloric/YouCompleteMe' " YouCompleteMe
"Plug 'kien/ctrlp.vim'
Plug 'itchyny/lightline.vim' " statusline/tabline plugin for Vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " command-line fuzzy search
Plug 'junegunn/fzf.vim'

call plug#end()

set bg=dark
colorscheme gruvbox

" Configuring status line
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

let mapleader = " "
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
