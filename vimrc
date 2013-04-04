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
"set cursorline

" Mappings
nmap <C-N> :noh <CR>

colorscheme desert
if $TERM == "xterm-256color"
  set t_Co=256
endif

" Highlight lines over 80 characters.
"highlight OverLength ctermbg=blue ctermfg=white guibg=#592929
"highlight OverLength ctermbg=17 ctermfg=none guibg=#030347
"let lineoverlength = matchadd('OverLength', '\%81v.\+')
highlight ColorColumn ctermbg=17
set colorcolumn=80

if $SHELL =~ 'bin/fish'
  set shell=/bin/sh
endif

" Highlight trailing whitespaces, multiple spaces and tabs in red.
highlight trailingwhitespace ctermbg=red ctermfg=white guibg=#592929
let highlight_trailing_whitespace = matchadd('trailingwhitespace', '\s\+$', 4)
highlight multiplewhitespace ctermbg=52 ctermfg=white guibg=#592929
let highlight_multiple_whitespaces = matchadd('multiplewhitespace', '\S\zs\s\{2,}\ze[^/#]')
highlight highlighttabs cterm=undercurl ctermbg=red ctermfg=white guibg=#592929
let highlight_tabs = matchadd('highlighttabs', '\t')
highlight Search ctermbg=88 ctermfg=white
highlight IncSearch ctermbg=DarkRed ctermfg=white
set incsearch
highlight difffilemine ctermbg=17
let highlight_diff_start = matchadd('difffilemine', '^<<<<<<<\_.*=======')
highlight difffiletheirs ctermbg=52
let highlight_diff_end = matchadd('difffiletheirs', '^=======\_.*>>>>>>>.*')
highlight difffilemiddle ctermbg=8
let highlight_diff_middle = matchadd('difffilemiddle', '^=======$')
highlight metadata ctermbg=17
let hightlight_shebang = matchadd('metadata', '^#!\(\/\w*\)*')
let hightlight_python_encoding = matchadd('metadata', '#.*-\*-.*coding:.*-\*-')
let hightlight_python_metadata = matchadd('metadata', '__\w*__.*=.*["|''].*["|'']')
"highlight VisualNOS cterm=bold,underline ctermbg=53
"highlight VisualNOS ctermbg=53
"autocmd CursorMoved * silent! exe printf('match VisualNOS /\V\<%s\>/', escape(expand('<cword>'), '/\'))

execute pathogen#infect()
highlight SignColumn ctermbg=black
set runtimepath^=~/.vim/bundle/ctrlp.vim
set ruler
set mouse=a
set laststatus=2
