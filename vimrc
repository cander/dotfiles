set nocompatible
behave xterm
set ai sw=4 showmatch
" good for Latex - not so good for java
set textwidth=74
" tabstops=4 for java IDEs, expandtabs so we don't insert any tabs
set ts=4 expandtab
map!  {}O
map!  endO
" map!  {\em}i 

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

