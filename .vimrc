autocmd! bufwritepost $MYVIMRC source %
set nobackup
set nowritebackup
set noswapfile

set nocompatible

set pastetoggle=<F2>
set clipboard=unnamedplus

set wildmenu
set esckeys
set backspace=indent,eol,start
set ttyfast
set gdefault
set encoding=utf-8 nobomb

let mapleader=","
set binary
set noeol

if exists("&undodir")
	set undodir=~/.vim/undo
endif

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4

" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
set number
syntax on
set cursorline

set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

" Highlight searches
set hlsearch
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch

" Always show status line
set laststatus=2

" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif
  
call plug#begin()
Plug 'tpope/vim-ragtag'
call plug#end()

set background=dark
let g:solarized_termcolors=256
colorscheme solarized

function! Stinted()
  if (!filereadable(getcwd() . '/.stint'))
      return 0
  endif
  if (filereadable(getcwd() . '/.stintignore'))
      for f in readfile(getcwd() . '/.stintignore')
        if (expand('%:t') == f)
          return 0
        endif
      endfor
  endif
  if (&ft == 'gitcommit')
    return 0
  endif
  if (expand('%:t') == '.vimrc')
    return 0
  endif
  " is this file under the stinted directory?
  return matchstr(expand('%:p'), getcwd()) == getcwd()
endfunction

function! MakeSession()
  if (!Stinted())
    return
  endif
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  if (!Stinted())
    return
  endif
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" Adding automatons for when entering or leaving Vim
au VimEnter * nested :call LoadSession()
au VimLeave * :call MakeSession()

" edit and source vimrc
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" Surround with quotes
:nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
:nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

:nnoremap H ^
:nnoremap L $
:inoremap jk <esc>
:inoremap <esc> <nop>