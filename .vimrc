"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""PLUGINS"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set directory=.,$TEMP
set shellslash


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""PLUGINS"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('$HOME/vimfiles/bundle')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

""""""""""""""""""""""""""""""""CONVENIENT"""""""""""""""""""""""""""""""""""""
" Swap window's positions. Mapped with %
Plugin 'wesQ3/vim-windowswap'

" Tree Navigator :NERDTREE
Plugin 'scrooloose/nerdtree'

" Search file in sub-tree :CtrlP or <Ctrl+P>
Plugin 'kien/ctrlp.vim'

" A more advanced equivalent of :ls
Plugin 'jlanzarotta/bufexplorer'

" When open or close braces detects pairs
Plugin 'jiangmiao/auto-pairs'

""""""""""""""""""""""""""""""""LINUX LIKE"""""""""""""""""""""""""""""""""""""
" Function ack (as the linux one)
Plugin 'mileszs/ack.vim'

" Function grep (as the linux one)
Plugin 'dkprice/vim-easygrep'

""""""""""""""""""""""""""""""""GIT DEDICATED""""""""""""""""""""""""""""""""""
" Enable git command (as the linux one) :Git order
Plugin 'tpope/vim-fugitive'

" Perform page layout :Tabularize /{pattern}
Plugin 'godlygeek/tabular'

"""""""""""""""""""""""""""""LANGUAGE DEDICATED""""""""""""""""""""""""""""""""
Plugin 'dpelle/vim-LanguageTool'
" Color in red trailing whitespaces
Plugin 'bronson/vim-trailing-whitespace'

" C plugin, opening .c/.h file corresponding to the open one :AV
Plugin 'a.vim'

" Static analyse
Plugin 'scrooloose/syntastic'

" Generation of skeleton for Doxygen labels :Dox...
Plugin 'vim-scripts/DoxygenToolkit.vim'

" Syntaxic coloration latex
Plugin 'vim-latex/vim-latex'

" HTML plugin (@see doc)
Plugin 'mattn/emmet-vim'

" HJSON
Plugin 'hjson/vim-hjson'

" Jinja2
Plugin 'glench/vim-jinja2-syntax'

""""""""""""""""""""""""""""USELESS BUT DISTRACTING""""""""""""""""""""""""""""
" Themes
Plugin 'altercation/vim-colors-solarized'
Plugin 'w0ng/vim-hybrid'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jpo/vim-railscasts-theme'
Plugin 'chriskempson/tomorrow-theme'

call vundle#end()            " required
filetype plugin indent on    " required


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""CONFIGURATION"""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim options
set hlsearch               " highlight search result
" set ic                     " ignore case for search
set incsearch              " incremental search
set number                 " print line numbers
set shiftwidth=2           " TAB equals 2 spaces
set tabstop=2              " ...probably the same thing
set expandtab              " use spaces, not tabs
set autoindent             " auto-indentation
set tw=100                 " default text width: 100 chars
set colorcolumn=100        " Set a colored colomn at 100 chars (Facilitate tw see)
set wrap                   " Wrap if the line extends...
set shm=A                  " do not prompt warning message if the file is
                           " already opened
set autoread               " re-read the file if it is modified externally
" set foldcolumn=1           " colonne de gauche pour indiquer les zones
                           " \"foldables\"
set scrolloff=3            " toujours afficher au moins 3 lignes au dessus et
                           " en dessous du curseur
set modeline               " autoriser les modlines
set foldmethod=syntax      " Folding base sur la syntaxe (parenthèse, crochets)
" :set foldlevel=100       " deplier tous les folds jusqu'au nv. 100
set diffopt+=iwhite        " en mode 'diff', ignorer les espaces

" Windows dark magic to make the backspace key work properly...
set backspace=2
set noshellslash

set grepprg=C:/msys64/usr/bin/grep.exe\ -R

set guifont=Consolas:h8:cANSI " Set font type and size (far better than the
                              " inital one)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""THEMES"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"" Aliases

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""MAPPER"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ack the word under the cursor, prompting a path
nmap    µ       "gyiw:Ack <C-R>g

" Switch windows, one time on the window to move, and a second on the desired
" position
nmap    %       <leader>ww

" Search all the tags corresponding to the poited function
nmap  <C-g>     g<C-]>

" Auto-completion
nmap  <C-Space> <C-p>

" Remove trailing white spaces on save
" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :call RemoveWhiteSpaces()<CR>
vnoremap <C-S> <C-C>:call RemoveWhiteSpaces()<CR>
inoremap <C-S> <C-O>:call RemoveWhiteSpaces()<CR>

" Remove trailing white spaces on save an quit
" Use CTRL-Q for saving and quit, also in Insert mode
noremap <C-Q> :call RemoveWhiteSpaces()<CR>:q<CR>
vnoremap <C-Q> :call RemoveWhiteSpaces()<CR>:q<CR>
inoremap <C-Q> :call RemoveWhiteSpaces()<CR>:q<CR>

" Path for a tags file @
set tags=F:\k2\bsp0-stm32f4\tags;

" Window navigation
nnoremap <A-l> :wincmd l<CR>
nnoremap <A-k> :wincmd k<CR>
nnoremap <A-j> :wincmd j<CR>
nnoremap <A-h> :wincmd h<CR>

function! RemoveWhiteSpaces()
  :%s/\s\+$//e
  :%s/\t/  /e
  :set fileencoding=utf-8
  :update
endfunction
