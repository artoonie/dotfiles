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

" OMNICPP/CTAGS
"A-] - Open the definition in a vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

    " omnicppcomplete options
    map <C-x><C-x><C-T> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f ~/.vim/commontags /usr/include /usr/local/include<CR><CR>
    set tags+=~/.vim/commontags
     
    " --- OmniCppComplete ---
    " -- required --
    set nocp " non vi compatible mode
    filetype plugin off " enable plugins DISABLED
     
    " -- optional --
    " auto close options when exiting insert mode or moving away
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
    set completeopt=menu,menuone
     
    " -- configs --
    let OmniCpp_MayCompleteDot = 1 " autocomplete with .
    let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
    let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
    let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
    let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
    let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
    let OmniCpp_LocalSearchDecl = 1 " don't require special style of function opening braces
     
    " -- ctags --
    " map <ctrl>+F12 to generate ctags for current folder:
    map <C-x><C-t> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
    " add current directory's generated tags file to available tags
    set tags+=./tags
     
    " Setup the tab key to do autocompletion
    function! CompleteTab()
      let prec = strpart( getline('.'), 0, col('.')-1 )
      if prec =~ '^\s*$' || prec =~ '\s$'
        return "\<tab>"
      else
        return "\<c-x>\<c-o>"
      endif
    endfunction
     
"    inoremap <tab> <c-r>=CompleteTab()<cr>
" Removed because of annoyance ^
