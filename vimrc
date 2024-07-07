scriptencoding utf-8

" General config
set nocompatible                "Use Vim settings, rather then Vi settings
let mapleader="\\"              "Leader
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=500                 "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set guicursor=a:blinkwait750-blinkon750-blinkoff750
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set hidden                      "Buffers can exist without being in a window
set magic                       "Turn on magic for regular expressions
set lazyredraw                  "Don't redraw while executing macros (good performance config)
set showmatch                   "Show matching brackets when text indicator is over them
set mat=2                       "How many tenths of a second to blink when matching brackets
set encoding=utf8               "Standard encoding
set number relativenumber       "Relative line numbers
set nojoinspaces                "Insert only 1 space when joining lines with J
syntax on                       "Turn on syntax highlighting

" Turn off swap file, backup
set noswapfile
set nobackup
set nowb

" Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=2                "How many spaces in a tab
set softtabstop=2
set tabstop=2
set expandtab                   "Tabs to spaces
set wrap                        "Wrap lines
set linebreak                   "Wrap lines at convenient points
set showbreak=↪                 "Show wrapped lines
filetype plugin on
filetype indent on

" File search
set wildmenu                    "Filename autocompletion
set wildignore=*.o,*~,*.pyc,__pycache__/
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set wildignore+=*.png,*.jpg,*.gif

" Search
" Visual mode pressing * searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>

" Disable search highlight
noremap <silent> <leader><leader> :noh<cr>

set hlsearch                    "Highlight search results
set smartcase
set ignorecase
set incsearch                   "Incremental search, highlight while typing

" Display
set background=dark
colorscheme desert

set guifont=IBM\ Plex\ Mono:h14,Monaco:h11,Hack:h12,Source\ Code\ Pro:h15,Menlo:h15
set ruler                       "Show current position
set cmdheight=1                 "Height of command bar
set scrolloff=8                 "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
set guioptions-=r               "Disable scrollbars
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Statusline
set laststatus=2                "Always show status bar
set statusline=
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %y
set statusline+=\ %l:%c
set statusline+=\ %P

" Display whitespace
set listchars=eol:¬,tab:»·,space:·,trail:·,precedes:⇠,extends:⇢,nbsp:×
" Toggle showing whitespace
noremap <leader>w :setlocal list!<cr>

" List content of registers
nnoremap <silent> "" :registers "01234abcde-*./=<CR>

" Switch CWD to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Spelling
set spelllang=en_gb
noremap <leader>s :setlocal spell!<cr>
" Fix latest spelling mistake
imap <c-s> <c-g>u<Esc>[s1z=`]a<c-g>u
nmap <c-s> [s1z=<c-o>

" Edit / Reload vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Swap lines
" A+j = ∆ and A+k = ˚ on MacOS
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Navigate through buffers
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" Fuzzy find, ripgrep
noremap <leader>/ :Rg 
noremap <silent> <C-f> :Files<CR>
noremap <silent> <C-g> :GFiles<CR>
noremap <silent> <C-b> :Buffers<CR>

noremap <leader>n :NERDTreeFocus<CR>

" Reindent file
noremap <leader>= gg=G<C-o><C-o>

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Manage plugins with Plug
" Bootstrap Plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'fisadev/vim-isort'
Plug 'lark-parser/vim-lark-syntax'
Plug 'tpope/vim-surround'
Plug 'glench/vim-jinja2-syntax'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'
Plug 'rkulla/pydiction'
Plug 'preservim/nerdtree'
call plug#end()

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_yaml_checkers = ["yamllint"]

let g:vim_isort_python_version = 'python3'
let g:rustfmt_autosave = 1
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.5, 'relative': v:true, 'yoffset': 1.0 } }

let g:vimwiki_list = [{'path': '/Users/$USER/My Drive/kb', 'syntax': 'markdown', 'ext': '.md'}]

let g:pydiction_location = '/Users/$USER/.vim/plugged/pydiction/complete-dict'

augroup formatting
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown wrap spell
    autocmd BufNewFile,BufFilePre,BufRead *.py,.rs setlocal sw=4 ts=4
    autocmd BufNewFile,BufFilePre,BufRead *.json,*.js,*.ts,*.html,*.css setlocal sw=2 ts=2 nowrap conceallevel=0 fdm=syntax 
    autocmd BufWritePre *.py silent execute ':Black'
    autocmd BufWritePre *.py execute ':Isort'
    autocmd BufWritePre *.txt,*.js,*.py,*.sh :call DeleteTrailingSpaces()
augroup END

" Delete trailing white space on save
fun! DeleteTrailingSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

" Use fzf to find file, c-r inserts relative path filename into current buffer
func! s:insert_filename(lines)
  let @@ = fnamemodify(a:lines[0], ":f")
  normal! p
endfunc
let g:fzf_action = { 'ctrl-r': function('s:insert_filename')}


" GPT-4o script for task management
command! -nargs=* T silent execute '!python tasks.py <q-args>' | redraw!
