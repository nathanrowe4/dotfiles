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
set wildmode=longest,list,full
set wildmenu
set wildignore=*.o,*~
"---------- Files
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set autoread

set encoding=utf-8

"---------- Plugins
call plug#begin('~/.vim/plugged')

Plug 'valloric/youcompleteme'                           " Plugin to autocomplete code
Plug 'tpope/vim-fugitive'                               " Plugin git wrapper
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " Fuzzy search
Plug 'junegunn/fzf.vim'
Plug 'RRethy/vim-illuminate'                            " Plugin to highlight the word under the cursor
Plug 'dense-analysis/ale'                               " Plugin to lint files for a number of languages
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdcommenter'                          " Plugin to help with commenting
Plug 'jiangmiao/auto-pairs'                             " Plugin to help with pairs (brackets, quotes, etc)
Plug 'tpope/vim-surround'                               " Plugin to help with surrounding
Plug 'tpope/vim-repeat'                                 " Plugin to repeat plugin commands
Plug 'dracula/vim'                                      " Plugin for colorscheme

call plug#end()

"------Colour Scheme
colorscheme dracula

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
nnoremap <leader>gf :GFiles<CR>
nnoremap <leader>F :Files<CR>

"---Fugitive
nnoremap <leader>gs :G status<CR>
nnoremap <leader>gd :G diff<CR>

"---YCM
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>rf :YcmCompleter RefactorRename 

"---lightline config
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
