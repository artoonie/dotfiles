set number
set ruler
set tabstop=4
set expandtab
set shiftwidth=4
syntax on
set nocompatible
set history=1000

set undofile
set undodir=~/.vim/undo

set backspace=indent,eol,start
fixdel

let mapleader = "."

" Because I have high unshift latency
map H h
map L l
cmap W w

" Reload .vimrc on write
autocmd bufwritepost .vimrc source $MYVIMRC

" Comments readable
hi comment ctermfg=darkcyan 

" Set current statusline to be a different color to make active window more obvious
"hi StatusLine   ctermfg=34  ctermbg=10 cterm=bold
"hi StatusLineNC ctermfg=249 guifg=#b2b2b2 ctermbg=237 guibg=#3a3a3a cterm=none gui=none

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
