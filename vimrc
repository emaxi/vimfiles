" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
  set nocompatible

  filetype off                   " required

""""//////### General Config ###\\\\\\\\"""""

  set history=1000                "Store lots of :cmdline history
  set visualbell                  "No sounds
  set autoread                    "Reload files changed outside vim
  syntax on
  let mapleader=","
  set showcmd                     "Show incomplete cmds down the bottom
  set showmode                    "Show current mode down the bottom
  set gcr=n:blinkon0
  set ruler
  set encoding=utf-8
  set title
  set backspace=indent,eol,start  "Intuitive backspacing in insert mode

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
  set hidden

""""//////### VUNDLE ###\\\\\\\\"""""

  if filereadable(expand("~/.vim/vundles.vim"))
    source ~/.vim/vundles.vim
  endif

" ================ Search Settings  =================

  set incsearch        "Find the next match as we type the search
  set hlsearch         "Hilight searches by default
  set viminfo='100,f1  "Save up to 100 marks, enable capital marks
  set ignorecase
  set smartcase

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile

" ================ Indentation ======================

  set autoindent
  set smartindent
  set smarttab
  set shiftwidth=2
  set softtabstop=2
  set tabstop=2
  set expandtab

  filetype plugin on
  filetype indent on

" Display tabs and trailing spaces visually
  set list listchars=tab:\ \ ,trail:·

  set nowrap       "Don't wrap lines
  set linebreak    "Wrap lines at convenient points

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ epliting ========================

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Highlight current line
set cursorline
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
" set list
" Always show status line
set laststatus=2
" Don’t show the intro message when starting Vim
set shortmess=atI



" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Don’t add empty newlines at the end of files
set binary
set noeol
