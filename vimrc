" mkdir -p ~/.vim/autoload ~/.vim/bundle
" ls ~/.vim/
"    autoload/ bundle/
" curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" ls ~/.vim/autoload/
"    pathogen.vim

call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

" Basic Mapping section
"""""""""""""""""""""""""""""""""""""""""""""
" <mode>noremap - do not take mapped chars into account (no recursive mapping)
" see http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
" You cannot copy and paste these commands.
"  map shift down to bump all the text down.
"  map {C-v}{Shift-Down} O{C-v}{Esc}j, etc.
" This seems to execute whether I hold shift down or not... nnoremap OB Oj
" nnoremap <Up> :set number!<CR>
" nnoremap <Down> Oj
nnoremap <Up> ddkP
nnoremap <Down> ddp
nnoremap <Left> :bp<CR>
nnoremap <Right> :bn<CR>

" nnoremap - ddp
" nnoremap + ddkP

" some mode specific mappings
" insert mode
"  delete a line
inoremap <c-d> <esc>ddi
"  change the current word into all caps and move back to insert at the end
inoremap <c-u> <esc>viwUea

" in normal mode F2 will save the file
nnoremap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
inoremap <F2> <ESC>:w<CR>i
" switch between header/source with F4 in normal mode
noremap <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
"toggle to paste mode while in insert mode so vim doesn't autoindent pastes
set pastetoggle=<F6>

" use ctags
nnoremap <f5> :!ctags -R --exclude=.git<CR>
" autogenerate a tags file on write - it isn't obvious this should be on by default...
"autocmd BufWritePost * call system("ctags -R --exclude=.git")

" set the leader (and local leader?) for more complex mappings
let mapleader="-"
" let maplocalleader="-"

" open/source the vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" put a word in quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
" put the visually selected block in quotes
vnoremap <leader>" <esc>a"<esc>`<i"<esc>`>f"

" get a split of the previous buffer
nnoremap <leader>pb :execute "rightbelow vsplit " . bufname("#")<cr>

" automatically make searches magic
nnoremap <leader>/ /\v
nnoremap <leader>? ?\v

" toggle line numbers conveniently
nnoremap <leader>N :setlocal number!<cr>

" foldcolumn toggle
nnoremap <leader>f :call <SID>FoldColumnToggle()<cr>

function! s:FoldColumnToggle()
  if &foldcolumn
    setlocal foldcolumn=0
  else
    setlocal foldcolumn=4
  endif
endfunction

" quickfix toggle - uses a global var!
nnoremap <leader>q :call <SID>QuickfixToggle()<cr>
" we have to initialzie the global var
let g:quickfix_is_open = 0

function! s:QuickfixToggle()
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open=0
    execute g:quickfix_return_to_window . "wincmd w"
  else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open=1
  endif
endfunction


"""""""""""""""""""""""""""""
" regex's
" note: nnoremap interprets <cr> before exe does, so we need
" to use <lt> as a literal < to get the regex to work.
nnoremap <leader>c :noh<cr>
nnoremap <leader>w :execute "normal! gg" . '/\v\s+$' . "\<lt>cr>"<cr>

"""""""""""""""""""""""""""""""""""""""""""""

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

"""""""""""""""""""""""""""""
" Status Line
set laststatus=2
set statusline=%f
set statusline+=\ -\ 
set statusline+=%c
set statusline+=\ -\ 
set statusline+=%l/%L
set statusline+=\ -\ 
set statusline+=%n
set statusline+=\ -\ 
set statusline+=%y

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

au BufRead,BufNewFile *py,*pyw set tabstop=4
au BufRead,BufNewFile *py,*pyw set softtabstop=4
au BufRead,BufNewFile *py,*pyw set shiftwidth=4

au BufRead,BufNewFile *.hs set tabstop=2
au BufRead,BufNewFile *.hs set softtabstop=2
au BufRead,BufNewFile *.hs set shiftwidth=2

au BufRead,BufNewFile *.R set tabstop=2
au BufRead,BufNewFile *.R set softtabstop=2
au BufRead,BufNewFile *.R set shiftwidth=2

augroup ruby
  autocmd!
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
augroup END

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
" TODO - purge eventually...
"  au BufRead,BufNewFile *.c,*.h,*.cpp set formatoptions-=c formatoptions-=o formatoptions-=r
" turn off auto-commenting when going to a new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h,*.cpp,*.pl,*.pm,*.m,*.hs set fileformat=unix

" Set the default file encoding to UTF-8: 
set encoding=utf-8

" Cause vim to treat all number formats as decimal, e.g., ctrl-x on 007 will be 008 and not 010 (octal)
set nrformats=

set backspace=indent,eol,start " make backspace a more flexible


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

" Code folding section (contains some maps)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Code folding - set method to indent, but also let me make them manually.
" Don't fold in plain text...
augroup vimrc
  au BufReadPre *\(*.txt\)\@<! setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
  au BufWinEnter * normal zR
augroup END

" Re-map "za" to space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf

" Erlang specific folding in vimerl
let g:erlang_folding=1

" JS specific folding?
au FileType javascript call JavaScriptFold()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Syntax Checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic - add C++11 syntax features
let g:syntastic_cpp_compiler_options = '-std=c++0x'

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

" Can't fight cron's attempt to run a backup...
au FileType crontab set nobackup nowritebackup

" don't highlight my last search when I source this...
noh
