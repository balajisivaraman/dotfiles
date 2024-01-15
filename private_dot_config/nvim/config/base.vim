" General
set nocompatible          " Be iMproved
filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
syntax enable             " enable syntax highlighting

set autoread      " auto-reload files changed on disk
set updatecount=0 " disable swap files
set visualbell    " Don't beep, please
set display+=lastline
set expandtab " expand tabs into spaces

" Leave paste mode when leaving insert mode
au InsertLeave * set nopaste

" Use system clipboard for yanks.
set clipboard+=unnamedplus
