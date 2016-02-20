set encoding=utf-8

"
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
  set nocompatible

  filetype off                   " required

""""//////### General Config ###\\\\\\\\"""""

  set history=1000                "Store lots of :cmdline history
  set autoread                    "Reload files changed outside vim
  syntax on
  let mapleader=","               "The \ key seems rather out of the way
	inoremap jk <ESC>               "jj don't fit
  set showcmd                     "Show incomplete cmds down the bottom
  set showmode                    "Show current mode down the bottom
  set gcr=n:blinkon0
  set ruler
  set title
  set backspace=indent,eol,start  "Intuitive backspacing in insert mode
  set number
  set vb                          "Enable visual bell (disable audio bell)
  "set clipboard=unnamed           "Use the system clipboard
  set ttimeoutlen=100             "Decrease timeout for faster insert with 'O'

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
	set tabstop=2
	set softtabstop=2
	set shiftwidth=2

  filetype plugin on
  filetype indent on

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

" ================ Spliting ========================

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"
" ================ Spliting ========================

" Highlight current line
set cursorline
" Show “invisible” characters
" set list
" Always show status line
set laststatus=2

" Don’t show the intro message when starting Vim
" set shortmess=atI


" Enable spellchecking for Markdown
autocmd BufRead,BufNewFile *.md setlocal spell"
autocmd FileType gitcommit setlocal spell
set complete+=kspell

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

syntax enable

" Columns to 80 as right wide
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

set expandtab

" Edit / Reload vimrc maps
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set list
set lcs=tab:▸\ ,trail:·,eol:¬,extends:#,nbsp:_
" autocmd filetype html,xml set listchars-=tab:>.

" It changes behaviour so that it jumps to the next row in the editor"
nnoremap j gj
nnoremap k gk

" Clear highlighted searches
nmap <silent> ,/ :nohlsearch<CR>

" Sudo after edit
cmap w!! w !sudo tee % >/dev/null

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|rdb)$',
  \ }


colorscheme solarized
if strftime("%H") >= 5 && strftime("%H") <= 19
	set background=light
else
	set background=dark
endif

let g:solarized_visibility = "high"


if colors_name == 'solarized'
  if has('gui_macvim')
    set transparency=0
  endif

  if !has('gui_running') && $TERM_PROGRAM == 'Apple_Terminal'
    let g:solarized_termcolors = &t_Co
    let g:solarized_termtrans = 1
    colorscheme solarized
  endif

endif

" Leave this at normal at all times
let g:solarized_contrast='normal'

" Non-text items visibility, normal low or high
let g:solarized_visibility='normal'

" Show trailing white spaces
let g:solarized_hitrail=1

" Disable the Solarized menu, when using GUI
let g:solarized_menu=0

" Don't use any underline styles
let g:solarized_underline=0

set background=dark " Use the light/dark version the color scheme
silent! colorscheme solarized " Set the color scheme to use, no errors allowed

" Set Guardfile filetype as ruby
au BufNewFile,BufRead Guardfile set filetype=ruby

vmap <Leader>z :call I18nTranslateString()<CR>

" %% give back path of current working dir
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" ctrlp config
" let g:ctrlp_map = '<leader>f'
let g:ctrlp_max_height = 30
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0

" use silver searcher for ctrlp
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" search for word under cursor with Silver Searcher
map <leader>A :Ag! "<C-r>=expand('<cword>')<CR>"

" map Silver Searcher
map <leader>a :Ag!<space>

" rename current file, via Gary Bernhardt
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

function! RunTests(filename)
  " Write the file and run tests for the given filename
  :w
  :silent !clear
  if match(a:filename, '\.feature$') != -1
    exec ":!bundle exec cucumber " . a:filename
  elseif match(a:filename, '_test\.rb$') != -1
    if filereadable("bin/testrb")
      exec ":!bin/testrb " . a:filename
    else
      exec ":!ruby -Itest " . a:filename
    end
  else
    if filereadable("Gemfile")
      exec ":!bundle exec rspec --color " . a:filename
    else
      exec ":!rspec --color " . a:filename
    end
  end
endfunction

function! SetTestFile()
  " set the spec file that tests will be run for.
  let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " run the tests for the previously-marked file.
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number . " -b")
endfunction

"" Layout Balancing
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_runner = "os_x_iterm2"
let g:rspec_command = 'call Send_to_Tmux("zeus rspec {spec}\n")'
