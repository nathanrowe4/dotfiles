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
set noshowmode

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

set clipboard=unnamedplus
set encoding=UTF-8
set cmdheight=2
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Wrap git commits at 72 characters
au FileType gitcommit setlocal tw=72

"---------- Plugins
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'                               " Git
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " Fuzzy search
Plug 'junegunn/fzf.vim'                                 " Fuzzy search
Plug 'junegunn/vim-peekaboo'                            " Preview registers/macros
Plug 'RRethy/vim-illuminate'                            " Highlight the word under the cursor
Plug 'itchyny/lightline.vim'                            " Status bar
Plug 'tpope/vim-surround'                               " Surrounding
Plug 'tpope/vim-repeat'                                 " Repeat plugin commands
Plug 'tpope/vim-commentary'                             " Commenting
Plug 'wellle/targets.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'

call plug#end()

"------Colour Scheme
colorscheme gruvbox
set termguicolors

"---------------Mappings ----------------
let mapleader = ","

"--- Map jk to Esc
imap jk <Esc>

"--- Make Y behave like other capital letters
nnoremap Y y$

"--- Line and paragraph navigation
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

"--- Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

"--- Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

"--- fzf
nnoremap <leader>b :Buffer<CR>
nnoremap <leader>B :BLines<CR>
nnoremap <leader>L :Lines<CR>
nnoremap <leader>gf :GFiles<CR>
nnoremap <leader>F :Files<CR>
nnoremap <leader>w :Windows<CR>

"--- Fugitive
nnoremap <leader>gs :G<CR>
nnoremap <leader>gc :G commit<CR>
nnoremap <leader>gp :G push<CR>

"--- fzf Checkout
nnoremap <leader>gco :GBranches checkout --locals<CR>
nnoremap <leader>gdb :GBranches delete<CR>
nnoremap <leader>grb :GBranches rebase<CR>
nnoremap <leader>gmb :GBranches merge<CR>
nnoremap <leader>gtb :GBranches track --remotes<CR>

"--- Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

"--- lightline config
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filetype': 'MyFiletype',
      \ },
      \ 'tab_component_function': {
      \   'tabnum': 'LightlineWebDevIcons',
      \ },
      \ }

function! LightlineWebDevIcons(n)
  let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  return WebDevIconsGetFileTypeSymbol(bufname(l:bufnr))
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() : '') : ''
endfunction

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Label'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'],
  \ 'preview-fg': ['fg', 'Normal']}

let &t_TI = ""
let &t_TE = ""

""" COC config
" Map <tab> to trigger completion and navigate to the next item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> T :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader> rn <Plug>(coc-rename)
