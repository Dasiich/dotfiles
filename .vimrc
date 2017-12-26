set directory=.,$TEMP
set shellslash

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=C:/Users/kdubreil/vimfiles/bundle/Vundle.vim
call vundle#begin('C:/Users/kdubreil/vimfiles/bundle')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'w0ng/vim-hybrid'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'wesQ3/vim-windowswap'
Plugin 'mileszs/ack.vim'
Plugin 'vim-latex/vim-latex'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'jpo/vim-railscasts-theme'
Plugin 'chriskempson/tomorrow-theme'
"Plugin 'Vimjas/vim-python-pep8-indent'
"Plugin 'mitsuhiko/vim-jinja'
"Plugin 'ntpeters/vim-better-whitespace'
"Plugin 'itchyny/calendar.vim'
""Plugin 'davidhalter/jedi-vim'
Plugin 'dkprice/vim-easygrep'
"Plugin 'scrooloose/nerdcommenter'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mattn/emmet-vim'



call vundle#end()            " required
filetype plugin indent on    " required


" Vim options
set hlsearch               " highlight search result
set ic                     " ignore case
set incsearch              " incremental search
set number                 " print line numbers
set shiftwidth=2           " TAB equals 2 spaces
set tabstop=2              " ...probably the same thing
set expandtab              " use spaces, not tabs
set autoindent             " auto-indentation
set tw=80                  " default text width: 80 chars
set colorcolumn=150
set wrap                   " Wrap if the line extends...
set shm=A                  " do not prompt warning message if the file is
                           " already opened
set autoread               " re-read the file if it is modified externally
" set foldcolumn=1           " colonne de gauche pour indiquer les zones
                           " \"foldables\"
set scrolloff=3            " toujours afficher au moins 3 lignes au dessus et
                           " en dessous du curseur
set modeline               " autoriser les modlines
set foldmethod=indent      " Folding base sur l'indentation
" :set foldlevel=100       " deplier tous les folds jusqu'au nv. 100
set diffopt+=iwhite        " en mode 'diff', ignorer les espaces

" Windows dark magic to make the backspace key work properly...
set backspace=2
set noshellslash


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""THEMES""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable

" Solarized Dark Ttheme
"set background=dark
"colorscheme solarized

" Solarize Light Theme
"set background=light
"colorscheme solarized

" Hybrid Dark Theme
set background=dark
colorscheme hybrid

" Hybrid Light Theme
"set background=light
"colorscheme hybrid

" RailsCasts Theme
"colorscheme railscasts

" Tomorrow Themes
"colorscheme tomorrow
"colorscheme tomorrow-night
"colorscheme tomorrow-night-blue
"colorscheme tomorrow-night-bright
"colorscheme tomorrow-night-eighties

set guifont=Consolas:h8:cANSI:qDRAFT



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""MAPPER""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ack the word under the cursor, prompting a path
nmap    µ       "gyiw:Ack <C-R>g

" Switch windows, one time on the window to move, and a second on the desired
" position
nmap    %       <leader>ww

" Search all the tags corresponding to the poited function
nmap  <C-g>     g<C-]>

" Auto-completion
nmap  <C-Space> <C-p>


set tags=F:\k2\tags;
