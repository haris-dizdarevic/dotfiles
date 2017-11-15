call plug#begin('~/.config/neovim/plugged')
Plug 'kien/ctrlp.vim'
Plug 'terryma/vim-multiple-cursors'
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
Plug 'https://github.com/nikvdp/ejs-syntax'
Plug 'slashmili/alchemist.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'kchmck/vim-coffee-script'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'
Plug 'magarcia/vim-angular2-snippets'
Plug 'isRuslan/vim-es6'
Plug 'leafgarland/typescript-vim'
Plug 'w0rp/ale'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Quramy/tsuquyomi'
Plug 'Quramy/vim-js-pretty-template'
Plug 'alvan/vim-closetag'
Plug 'gregsexton/MatchTag'
Plug 'craigemery/vim-autotag'
Plug 'rking/ag.vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'chr4/jellygrass.vim'
Plug 'carakan/new-railscasts-theme'
Plug 'sheerun/vim-polyglot'
Plug 'mxw/vim-jsx'
Plug 'szw/vim-tags'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neco-syntax'
Plug 'wokalski/autocomplete-flow'
Plug 'tpope/vim-rails'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'osyo-manga/vim-monster'
Plug 'ngmy/vim-rubocop'
Plug 'rakr/vim-one'
call plug#end()

highlight ColorColumn ctermbg=white

set number
set ruler
set showmatch
set showmode
set colorcolumn=80
set cursorline
set mouse=a
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

" Display tabs and trailing spaces visually
set list listchars=tab:▸\ , eol:¬


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

set noautoindent

" Colorscheme

set termguicolors
colorscheme one
set background=dark
set termguicolors

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


" more natural splits
set splitbelow
set splitright

let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
let g:Powerline_symbols = 'fancy'
"let g:airline#extensions#tabline#enabled = 1
set laststatus=2

" Syntax checker ale
let g:ale_javascript_eslint_use_global = 1
let g:ale_ruby_rubocop_use_global = 1
let g:ale_ruby_mri_use_global = 1
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '⚠'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_linters = { 'javascript': ['eslint'], 'ruby': ['rubocop', 'mri', 'reek'] }

" vim jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

autocmd FileType javascript JsPreTmpl html


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

autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" omnifuncs
set omnifunc=syntaxcomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Remove scrollbar
set guioptions=egm

" CTRLP config
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*/vendor/**
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|vendor\|node_modules\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }

let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#enable_snipmate_compatibility = 1
let g:monster#completion#rcodetools#backend = "async_rct_complete"
let g:monster#completion#rcodetools#backend = "async_rct_complete"
let g:deoplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
\}

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" remove trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e
