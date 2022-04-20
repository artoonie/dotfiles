set number
set ruler
set tabstop=4
set expandtab
set shiftwidth=4
syntax on
set nocompatible
set history=1000
set formatoptions+=r
set nocursorline

set undofile
set undodir=~/.vim/undo
set term=builtin_ansi

set backspace=indent,eol,start
fixdel

let mapleader = "."

" Because I have high unshift latency
map H h
map L l
command! W write

map <leader>gf :vs <cfile><cr>

" Reload .vimrc on write
autocmd bufwritepost .vimrc source $MYVIMRC

" Comments readable
hi comment ctermfg=darkcyan ctermbg=black

" Menu background
hi Pmenu ctermbg=gray


" Make active window more obvious
hi StatusLine   ctermfg=0 ctermbg=6 cterm=bold
hi StatusLineNC ctermfg=0 ctermbg=2 cterm=none
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  filetype plugin on
  " ...
endif

" VISUAL SELECTION SUBSTITUTION, from Jeremy Cantrell, Peter Odding, and Bryan Kennedy @ StackOverflow
" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
vmap <leader>s <Esc>:%s/<c-r>=GetVisual()<cr>/

" ctags location
set tags=./tags,tags;$HOME

" Periodically save the session, if there are more than one windows open
autocmd CursorHold * if winbufnr(2)!=-1 |  mksession! .session.vim

" EasyMotion
    let g:EasyMotion_do_mapping = 0 " Disable default mappings

    " Bi-directional find motion
    " Jump to anywhere you want with minimal keystrokes, with just one key binding.
    " `s{char}{label}`
    nmap <Leader>s <Plug>(easymotion-s)
    " or
    " `s{char}{char}{label}`
    " Need one more keystroke, but on average, it may be more comfortable.
    " nmap e <Plug>(easymotion-s2)

    " Turn on case insensitive feature
    let g:EasyMotion_smartcase = 1

    " JK motions: Line motions
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)


"call plug#begin('~/.vim/plugged')
"Plug 'OmniSharp/omnisharp-vim'
""Plug 'valloric/youcompleteme'
""Plug 'dense-analysis/ale'
"Plug 'scrooloose/syntastic'
"call plug#end()
"let g:OmniSharp_server_use_mono = 1
