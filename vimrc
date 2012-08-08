" Add to your .vimrc:
"
"   source ~/src/environment/vimrc
"

set nocompatible
syntax on

set background=light

set showmatch
set ignorecase
set showmode
set ts=2
set sw=2
set autoindent
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
