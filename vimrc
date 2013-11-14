" mkdir -p ~/.vim/autoload ~/.vim/bundle
" ls ~/.vim/
"    autoload/ bundle/
" curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" ls ~/.vim/autoload/
"    pathogen.vim

call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

" cd ~/.vim/bundle
" git clone git://github.com/tpope/vim-commentary.git

" cd ~/.vim/bundle
" git clone git://github.com/tpope/vim-markdown.git

" git clone git://github.com/scala/scala-dist.git
" cd tool-support/src/vim
" cp -r ftdetect ~/.vim
" cp -r indent ~/.vim
" cp -r syntax ~/.vim

" Training like Rocky...
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
map <Up> :set number<CR>
map <Down> :set nonumber<CR>
map <Left> :bp<CR>
map <Right> :bn<CR>

set history=200 " Keep the last 200 commands (default is 20)

set nocompatible " explicitly get out of vi-compatible mode

" pick the colorscheme
" delek for white backgrounds, evening for dark
" colorscheme blue
" colorscheme darkblue
" colorscheme default
" colorscheme delek
" colorscheme desert
" colorscheme elflord
colorscheme evening
" colorscheme koehler
" colorscheme morning
" colorscheme murphy
" colorscheme pablo
" colorscheme peachpuff
" colorscheme ron
" colorscheme shine
" colorscheme torte
" colorscheme zellner

" show me more of the command window (HLint, etc.)
set cmdheight=2

"case insensitive seach unless there are caps
set ignorecase
set smartcase

" Highlight search
set hlsearch

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
set tabstop=2

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
set shiftwidth=2
set expandtab
au BufRead,BufNewFile Makefile* set noexpandtab

" For python, we want something like this eventually...
" shiftwidth=4
" softtabstop=4
" expandtab
" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
au BufRead,BufNewFile *py,*pyw set tabstop=4
au BufRead,BufNewFile *py,*pyw set softtabstop=4
au BufRead,BufNewFile *py,*pyw set shiftwidth=4

au BufRead,BufNewFile *.hs set tabstop=2
au BufRead,BufNewFile *.hs set softtabstop=2
au BufRead,BufNewFile *.hs set shiftwidth=2

au BufRead,BufNewFile *.R set tabstop=2
au BufRead,BufNewFile *.R set softtabstop=2
au BufRead,BufNewFile *.R set shiftwidth=2

" For full syntax highlighting:
let python_highlight_all=1
let perl_extended_vars=1
syntax on

" put doxygen syntax in c and cpp language
au Syntax {cpp,c} runtime syntax/doxygen.vim

" set doxygen type for pure dox files
au BufNewFile,BufRead *.doxygen setfiletype doxygen

set showmatch " show matching brackets

set ruler

" Automatically indent based on file type: 
filetype on
filetype indent on
" Keep indentation level from previous line: 
"set autoindent
"set smartindent


" Use the below highlight group when displaying bad whitespace for python
highlight BadWhitespace ctermbg=gray 
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Display tabs at the beginning of a line in Haskell mode as bad.
au BufRead,BufNewFile *.hs match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad in Python
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 79 
" C: 79
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79

" - give todo a different color
"highlight ToDoCol ctermbg=white ctermfg=darkblue
"au BufRead,BufNewFile * match ToDoCol /\ctodo/
 
" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h,*.cpp set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h,*.cpp,*.pl,*.pm,*.m,*.hs set fileformat=unix

" Set the default file encoding to UTF-8: 
set encoding=utf-8

" Cause vim to treat all number formats as decimal, e.g., ctrl-x on 007 will be 008 and not 010 (octal)
set nrformats=

set backspace=indent,eol,start " make backspace a more flexible
" in normal mode F2 will save the file
nmap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
imap <F2> <ESC>:w<CR>i
" switch between header/source with F4 in normal mode
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
"toggle to paste mode while in insert mode so vim doesn't autoindent pastes
set pastetoggle=<F6>

if has("autocmd")
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
endif

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" use this function and the one below to restore cursor position when restarting a session
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
" use this function and the one above to restore cursor position when restarting a session
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" use ghc functionality for haskell files
au BufEnter *.hs compiler ghc
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"

set incsearch

" turn off auto-commenting when going to a new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" use ctags
nnoremap <f5> :!ctags -R --exclude=.git<CR>
" autogenerate a tags file on write - it isn't obvious this should be on by default...
"autocmd BufWritePost * call system("ctags -R --exclude=.git")

" show whitespace chars with ":set list" (and turn off with ":set nolist")
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<         

" automaitcally write before compiling. Undo with :set noautowrite
set autowrite

" Erlang comment string for use with vim-commentary
autocmd FileType erlang set commentstring=%\ %s
" R comment string for use with vim-commentary
autocmd FileType r set commentstring=#\ %s
" AsciiDoc
autocmd FileType asciidoc set commentstring=//\ %s

" Code folding - set method to indent, but also let me make them manually.
" Don't fold in plain text...
augroup vimrc
  au BufReadPre *\(*.txt\)\@<! setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

" Re-map "za" to space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf

" Erlang specific folding in vimerl
let g:erlang_folding=1

" JS specific folding?
au FileType javascript call JavaScriptFold()

" AUTOMATIC BACKUPS =====================================================
"enable backup
set backup

"set and create the root backupdir
let rootbackupdir = $HOME."/.vim_backup" "root backup directory
let cmd = "silent !mkdir ".rootbackupdir." > /dev/null 2>&1"
execute cmd

"set and create the day's backup directory
let day = strftime("%Y.%m.%d")
let backupdir=rootbackupdir."/".day
let cmd = "silent !mkdir ".backupdir." > /dev/null 2>&1"
execute cmd

"finally set vim's backupdir
let cmd = "set backupdir=".backupdir
execute cmd

"set the file extension for hour.minute.second
let time = strftime(".%H.%M.%S")
let cmd = "set backupext=".time
execute cmd
"test.cpp is going to be backed up as HOME/.vim_backup/day/test.cpp.hour.min.sec
" ===================================================== AUTOMATIC BACKUPS

au FileType crontab set nobackup nowritebackup
