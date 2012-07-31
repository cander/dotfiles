set nocompatible
behave xterm
set ai showmatch
" good for Latex - not so good for real coding
set textwidth=76
" tabstops=4 for java IDEs, expandtabs so we don't insert any tabs
set ts=4 expandtab

set sw=4
" except for Ruby files - should add Rakefile
" this is kinda lame b/c it sets it for all buffers
autocmd BufRead *.rb set sw=2

" coding blocks: crtl-b for matched curlies, crtl-e for end block
map!  {}O
map!  endO
" old mapping for Latex - emphasis block
" map!  {\em}i 

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" fix up backspace under tmux - assume tmux is only 256 color
" and that regular "screen" is for screen.
if &term == "screen-256color"
    set t_kb=
   fixdel
endif

" -------- Stuff from Daimin Conway --------

" always display position in file, not just via ctrl-G
set ruler

" Make space into page-down - more useful, more often
nnoremap <SPACE> <PAGEDOWN>

"====[ Use persistent undo ]=================

if has('persistent_undo')
    " Save all undo files in a single location (less messy, more risky)...
    set undodir=$HOME/tmp/.VIM_UNDO_FILES

    " Save a lot of back-history...
    set undolevels=2000

    " Actually switch on persistent undo
    set undofile
endif

