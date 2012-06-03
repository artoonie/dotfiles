set number
set tabstop=4
set expandtab
set shiftwidth=4
syntax on
set nocompatible
set history=1000

set undofile
set undodir=~/.vim/undo

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
