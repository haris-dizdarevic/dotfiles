call plug#begin('~/.config/neovim/plugged')
Plug 'kien/ctrlp.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'benizi/vim-automkdir'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/matchit.zip'
Plug 'tpope/vim-vinegar'
Plug 'shime/vim-livedown'
Plug 'https://github.com/jeffkreeftmeijer/vim-numbertoggle'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/Townk/vim-autoclose'
Plug 'slashmili/alchemist.vim'
Plug 'leafgarland/typescript-vim'
Plug 'w0rp/ale'
Plug 'alvan/vim-closetag'
Plug 'gregsexton/MatchTag'
Plug 'craigemery/vim-autotag'
Plug 'rking/ag.vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'szw/vim-tags'
Plug 'tpope/vim-rails'
Plug 'airblade/vim-gitgutter'
call plug#end()

set number
set ruler
set showmatch
set showmode
set colorcolumn=80
set cursorline
set mouse=
set magic
set autoread
set ai

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"
" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" Display tabs and end of line spaces visually
set list
set listchars=tab:▸\ ,eol:¬

"" Whitespace
set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set backspace=indent,eol,start    " backspace through everything in insert mode

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Colorscheme

set termguicolors
set background=dark
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
set noshowmode

let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '`':'`'}
let g:alchemist_tag_disable = 1
set ttimeoutlen=0

set noerrorbells visualbell t_vb=
set showcmd
let mapleader = ","

" yank to system clipboard
map <leader>y "*y

" ================ jump_to tag with ,F and ,f ========================
" hit ,f to find the definition of the current class
" this uses ctags. the standard way to get this is Ctrl-]
" use ,d to show all definitions
nnoremap <silent> ,f <C-]>
nnoremap <silent> ,d g]

" use ,F to jump to tag in a vertical split
nnoremap <silent> ,F :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>


" map ,v to open ~/.vim/vimrc in new tab
nmap <leader>v :tabedit $HOME/.config/nvim/init.vim<CR>
nmap <leader>e :Explore<CR>

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>


"" history scroll use Ctrl-p and Ctrl-n instead up and down arrow
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
"

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
set ttyfast                           " indicates a fast terminal connection
set lazyredraw                        " see if this fixes the slowness

" more natural splits
set splitbelow
set splitright

" Syntax checker ale
let g:ale_javascript_eslint_use_global = 1
let g:ale_ruby_rubocop_use_global = 1
let g:ale_ruby_mri_use_global = 1
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '⚠'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_linters = { 'ruby': ['rubocop', 'mri', 'reek'] }


" ==================== Improved search ======================
" Open the Ag command and place the cursor into the quotes
nmap ,ag :Ag ""<Left>
nmap ,af :AgFile ""<Left>

function! GetVisual()
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save
  return selection
endfunction

"grep the current word using ,k (mnemonic Kurrent)
nnoremap <silent> ,k :Ag <cword><CR>

"grep visual selection
vnoremap ,k :<C-U>execute "Ag " . GetVisual()<CR>

"grep current word up to the next exclamation point using ,K
nnoremap ,K viwf!:<C-U>execute "Ag " . GetVisual()<CR>

"grep for 'def foo'
nnoremap <silent> ,gd :Ag 'def <cword>'<CR>

",gg = Grep! - using Ag the silver searcher
" open up a grep line, with a quote started for the search
nnoremap ,gg :Ag ""<left>

"Grep for usages of the current file
nnoremap ,gcf :exec "Ag " . expand("%:t:r")<CR>

" Select code completion with Enter instead of Ctrl + y
inoremap <expr> <silent> <cr> pumvisible() ? "<c-y>" : "<cr>"

"
" Remove scrollbar
set guioptions=egm

" CTRLP config
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*/vendor/**
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|vendor\|node_modules\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:50'

" remove trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e
