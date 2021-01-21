execute pathogen#infect()

" Use comma for leader key
let mapleader=','

" Make Vim read per-filetype settings from `ftplugin` and `indent` directories
filetype plugin indent on

silent! nnoremap <Leader>j :ImportJSWord<CR>
silent! nnoremap <Space> :CommandT<CR>
silent! nnoremap <Leader><Space> :CommandTFlush<CR>:CommandT<CR>
silent! nnoremap gp :Prettier<CR>
silent! nnoremap <leader>y :call system('nc localhost 8377', @0)<CR>
let g:CommandTCancelMap = ['<ESC>', '<C-c>']
let g:CommandTFileScanner = 'watchman'

if &term =~# 'screen' || &term =~# 'tmux' || &term =~# 'xterm'
  let g:CommandTSelectNextMap = ['<C-n>', '<C-j>', '<Down>', '<ESC>OB']
  let g:CommandTSelectPrevMap = ['<C-p>', '<C-k>', '<Up>', '<ESC>OA']
endif

set wildignore+=*.o,*.pyc,*/tmp/*,*.swp,*.zip,.git,*/node_modules/*,*/build/*,*/dist/*,*/.next/*


" Linting
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_fixers = { 'javascript': ['eslint'] }


" Keep old leader key for pairing
map \ ,

set pythondll=/usr/local/Frameworks/Python.framework/Versions/3.9/Python
set pythonhome=/usr/local/Frameworks/Python.framework/Versions/3.9
set pythonthreedll=/usr/local/Frameworks/Python.framework/Versions/3.9/Python
set pythonthreehome=/usr/local/Frameworks/Python.framework/Versions/3.9

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=['~/dotfiles/.vim/UltiSnips']

set shell=/bin/sh " Use Bourne shell for command substitution
set history=10000 " Remember this many commands & searches

" Escape on typing "jj"
:imap jj <Esc>

" Customize how the interface is displayed and interacted with.

" Enable syntax highlighting
let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized

" Don't show Vim credits on startup
set shortmess+=I

set colorcolumn=+1 " Show textwidth limit
set nocursorline   " Disable highlighting cursorline as it slows rendering
set number         " Show line numbers
set laststatus=2   " Always show status line

set wildmenu       " Tab-completion menu for command mode
set wildignore+=*.o,*.pyc,*/tmp/*,*.swp,*.zip,.git
set wildmode=list:longest,full

" Vertically center cursor in middle of buffer
set scrolloff=999

" Allow interaction using mouse
set mouse=a

" Characters to display when showing invisible characters
set listchars=eol:¶,tab:⇥\ ,trail:·

set foldmethod=indent " Fold based on indent
set foldnestmax=5     " Deepest fold level
set nofoldenable      " Don't fold by default
set foldlevel=1

set incsearch         " Start searching from current cursor postion
set hlsearch          " Highlight search results
set ignorecase        " Make searching case insensitive
set smartcase         " ...unless query has capital letters

set autoindent        " Auto-indent new lines
set smartindent       " Auto-indent at the beginning of code blocks, etc.

if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j  " Remove comment marker when joining lines
endif

set formatoptions+=o  " Continue comment marker in new lines
set textwidth=80      " Hard-wrap long lines as you type them
set tabstop=8         " Render TABs using this many spaces
set expandtab         " Insert spaces when TAB is pressed
set softtabstop=2     " Tabs are this many spaces
set shiftwidth=2      " Indentation amount for < and > commands
set smarttab          " Add spaces according to shiftwidth, <BS> kills sw spaces

" Check first or last 5 lines of file for magic comments that set vim options
set modeline
set modelines=5

set splitright " Focus new window after vertical splitting
set splitbelow " Focus new window after horizontal splitting

" Enable completion using syntax highlighting definitions
set completefunc=syntaxcomplete#Complete

" Allow backspace to always delete
set backspace=eol,indent,start

" Detect background changes to file
set autoread

" Switch buffers without saving
set hidden

set nobackup    " Don't create backup files
set writebackup " Only backup file while editing
set noswapfile  " No swap files

" Edit file in-place rather than duplicate + copy when saving.
" Potentially problematic if mulitiple actors editing file, but this allows us
" to edit a file mounted in a Docker container without changing the inode (and
" thus ensuring the changes are propagated into the container)
set backupcopy=yes

" Ask user before
" - Writing to a file that already exists (with :w)
" - Closing a buffer with unsaved changes (with :q)
" - Quitting vim when there any buffers with unsaved changes (with :qa)
set confirm

" Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Handle common typo for saving
command! W w

" Save file with superuser privileges
command! WW w !sudo tee % > /dev/null

" Check for changes before attempting to write to file
autocmd CursorMoved,CursorMovedI,InsertEnter,InsertLeave * checktime

" Autodetect the filetype when renaming a file.
" Annoyingly, most Vim plugins that do filetype detection don't subscribe to the
" buffer rename event (BufFilePost), so we have to execute the BufReadPost
" autocommand, which is where most filetype detectors get run.
autocmd BufFilePost *.* filetype detect
