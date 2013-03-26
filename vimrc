" Add to your .vimrc:
"
"   source ~/src/environment/vimrc
"

set nocompatible  " Extra vim features
syntax on

set background=light

set showmatch
set ignorecase
set showmode
set ts=2
set sw=2
set autoindent
set smarttab
set smartindent
set expandtab
set hlsearch
set number

" Mappings
nmap <C-N> :noh <CR>

colorscheme desert

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

if $SHELL =~ 'bin/fish' 
  set shell=/bin/sh 
endif 

" show trailing spaces in yellow (or red, for users with dark backgrounds).
" "set nolist" to disable this.
" this only works if syntax highlighting is enabled.
set list
if &background == "dark"
  highlight SpecialKey ctermbg=Red guibg=Red
else
  highlight SpecialKey ctermbg=Yellow guibg=Yellow
end 

autocmd CursorMoved * silent! exe printf('match VisualNOS /\V\<%s\>/', escape(expand('<cword>'), '/\'))

execute pathogen#infect()
highlight SignColumn ctermbg=black
set runtimepath^=~/.vim/bundle/ctrlp.vim
set colorcolumn=79
highlight ColorColumn ctermbg=4
set ruler
set mouse=a
