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
highlight ColorColumn ctermbg=17
set colorcolumn=80

if $SHELL =~ 'bin/fish'
  set shell=/bin/sh
endif

" Highlight trailing whitespaces, multiple spaces and tabs in red.
highlight trailingwhitespace ctermbg=red ctermfg=white guibg=#592929
call matchadd('trailingwhitespace', '\s\+$', 4)
highlight multiplewhitespace ctermbg=52 ctermfg=white guibg=#592929
call matchadd('multiplewhitespace', '\S\zs\s\{2,}\ze[^/#]')
highlight highlighttabs cterm=undercurl ctermbg=red ctermfg=white guibg=#592929
call matchadd('highlighttabs', '\t')
highlight Search ctermbg=88 ctermfg=white
highlight IncSearch ctermbg=DarkRed ctermfg=white
set incsearch
highlight difffilemine ctermbg=17
call matchadd('difffilemine', '^<<<<<<<\_.*=======')
highlight difffiletheirs ctermbg=52
call matchadd('difffiletheirs', '^=======\_.*>>>>>>>.*')
highlight difffilemiddle ctermbg=8
call matchadd('difffilemiddle', '^=======$')
highlight metadata ctermbg=17
call matchadd('metadata', '^#!\(\/\w*\)*')
call matchadd('metadata', '#.*-\*-.*coding:.*-\*-')
call matchadd('metadata', '__\w*__.*=.*["|''].*["|'']$')
highlight conditionalcomments ctermfg=17 ctermbg=45
call matchadd('conditionalcomments', '<!\(-\{2\}\)\?\[if.*\]\_.*\[endif\]\(-\{2\}\)\?>')
call matchadd('conditionalcomments', '\/\*@cc_on\_.*@\*\/')

execute pathogen#infect()
highlight SignColumn ctermbg=black
set runtimepath^=~/.vim/bundle/ctrlp.vim
set ruler
set mouse=a
set laststatus=2
set noswapfile
set autochdir
set wildignore+=*.pyc
let c_minlines = 200

" netrw conf
let g:netrw_list_hide = '.*\.pyc$'
let g:netrw_sort_sequence = '[\/]$,\<core\%(\.\d\+\)\=\>,\.py$,\.js$,\.html$,\.less$,\.css$,\.h$,\.c$,\.cpp$,*,\.o$,\.obj$,\.info$,\.pyc$,\.swp$,\.bak$,\~$'

syn match netrwPyc "\(\S\+ \)*\S\+\.pyc\>" contains=netrwTreeBar,@NoSpell
hi default link netrwPyc Directory

let g:netrw_special_syntax= 1

let g:netrw_liststyle = 3

" Use Python syntax highlight for mesos config files
au BufRead,BufNewFile *.mesos set filetype=python

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
    let expl_win_num = bufwinnr(t:expl_buf_num)
    if expl_win_num != -1
      let cur_win_nr = winnr()
      exec expl_win_num . 'wincmd w'
      close
      exec cur_win_nr . 'wincmd w'
      unlet t:expl_buf_num
    else
      unlet t:expl_buf_num
    endif
  else
    exec '1wincmd w'
    Vexplore
    let t:expl_buf_num = bufnr("%")
  endif
  exec window size 80
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

autocmd! bufwritepost .vimrc source %  "Autoreload vimrc on edit
