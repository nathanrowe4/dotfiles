syntax on

"---------- Formatting
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set relativenumber
set nowrap
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
autocmd VimResized * wincmd =

"---------- Search
set smartcase
set ignorecase
set hlsearch
set incsearch
set wildmenu
"---------- Files
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set autoread

"---------- Plugins
call plug#begin('~/.vim/plugged')

Plug 'davidhalter/jedi-vim' "Python autocomplete
Plug 'tpope/vim-fugitive' " Git wrapper for vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " command-line fuzzy search
Plug 'junegunn/fzf.vim'
Plug 'RRethy/vim-illuminate' " Plugin to highlight the word under the cursor
Plug 'preservim/nerdtree' "Plugin to show file structure
Plug 'Xuyuanp/nerdtree-git-plugin' "Plugin to show git status of files in nerdtree
Plug 'dense-analysis/ale' "Plugin to lint files for a number of languages
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdcommenter' "Plugin to help with commenting
Plug 'morhetz/gruvbox' "Colour scheme
Plug 'jiangmiao/auto-pairs' "Plugin to help with pairs (brackets, quotes, etc)

call plug#end()

"------Colour Scheme
set background=dark
colorscheme gruvbox

"---------------Mappings ----------------
let mapleader = ","
"--- Line and paragraph navigation
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
noremap K {
noremap J }
noremap H ^
noremap L $
"--- Insert mode navigational keys
imap <Up>    <Nop>
imap <Down>  <Nop>
imap <Left>  <Nop>
imap <Right> <Nop>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
"--- Tab and Shift-Tab indenting
" Note that <tab> and <C-i> are strictly equivalent
nmap >> <Nop>
nmap << <Nop>
vmap >> <Nop>
vmap << <Nop>
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv
"--- Tab navigation
nnoremap <C-l> gt
nnoremap <C-h> gT

"---fzf
nnoremap <leader>b :Buffer<CR>
nnoremap <leader>B :BLines<CR>
nnoremap <leader>L :Lines<CR>

"---NERDTree
nnoremap <leader>f :NERDTreeFocus<CR>
let g:NERDTreeChDirMode = 2
