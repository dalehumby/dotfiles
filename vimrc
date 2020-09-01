"NOTE: Reload without restart using :source ~/.vimrc
scriptencoding utf-8

" General config
set nocompatible                "Use Vim settings, rather then Vi settings
let mapleader=","               "Remap leader
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=500                 "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set hidden                      "Buffers can exist without being in a window
set magic                       "Turn on magic for regular expressions
set lazyredraw                  "Don't redraw while executing macros (good performance config)
set showmatch                   "Show matching brackets when text indicator is over them
set mat=2                       "How many tenths of a second to blink when matching brackets
set encoding=utf8               "Standard encoding
syntax on                       "Turn on syntax highlighting

" Turn off swap file, backup
set noswapfile
set nobackup
set nowb

" Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=4                "How many spaces in a tab
set softtabstop=4
set tabstop=4
set expandtab                   "Tabs to spaces
set wrap                        "Wrap lines
set linebreak                   "Wrap lines at convenient points
set showbreak=↪                 "Show wrapped lines
filetype plugin on
filetype indent on

" File search
set wildmenu                    "Turn on autocompletion
set wildignore=*.o,*~,*.pyc,__pycache__/
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set wildignore+=*.png,*.jpg,*.gif


" Search
" Visual mode pressing * searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

set hlsearch                    "Highlight search results
set smartcase
set ignorecase
set incsearch                   "Make search behave as in modern browsers


" Display
set background=dark
colorscheme desert
set guifont=IBM\ Plex\ Mono:h14,Monaco:h11,Hack:h12,Source\ Code\ Pro:h15,Menlo:h15
set ruler                       "Show current position
set cmdheight=1                 "Height of command bar
set laststatus=2                "Height of status bar
set scrolloff=8                 "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
set guioptions-=r               "Disable scrollbars
set guioptions-=R
set guioptions-=l
set guioptions-=L

"TODO statusline

" Relative line number
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Display whitespace
set listchars=eol:¬,tab:»·,space:·,trail:·,precedes:⇠,extends:⇢,nbsp:×
" Toggle showing whitespace
map <leader>w :setlocal list!<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Spelling
set spelllang=en_gb
map <leader>s :setlocal spell!<cr>

" Functions
" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Delete trailing white space on save
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh :call CleanExtraSpaces()
endif

