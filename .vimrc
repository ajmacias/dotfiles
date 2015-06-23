"inspirado por: http://c7.se/switching-to-vundle/
"             : http://yannesposito.com/Scratch/en/blog/Vim-as-IDE/
"

set nocompatible
filetype off

" Vundle Power
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" Vundle controlando Vundle :)
Plugin 'gmarik/vundle'

" -- Mis Plugins

" -- IDE
Plugin 'nanotech/jellybeans.vim'            " Color
Plugin 'bling/vim-airline'                  " Barra de estado
Plugin 'kien/ctrlp.vim'                     " Control de ficheros
Plugin 'majutsushi/tagbar'                  " Visor de tags
Plugin 'scrooloose/nerdtree'                " Visor de ficheros


" -- Ayudas Globales
Plugin 'bronson/vim-trailing-whitespace'    " Ver y borrar espacios al final de las lineas
Plugin 'junegunn/vim-easy-align'            " Para alinear bloques
Plugin 'scrooloose/syntastic'               " Comprobador de sintaxis
Plugin 'ervandew/supertab'                  " Autocompletado con tabulador
Plugin 'terryma/vim-multiple-cursors'       " Edicion multiple
Plugin 'tpope/vim-commentary'               " Comentado de codigo
Plugin 'Raimondi/delimitMate'               " cierra delimitadores
Plugin 'tpope/vim-surround'                 " encierra texto en comillas, parentesis...  :norm yss<li>

Plugin 'marcweber/vim-addon-mw-utils'       " Snippets
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" -- Ayudas por lenguaje
"Plugin 'docunext/closetag.vim'              " cierra tags x/html
Plugin 'brookhong/DBGPavim'                 " xdebug php
Plugin '0rca/vim-mikrotik'                  " resaltado mikrotik

" -- GIT
Plugin 'airblade/vim-gitgutter'             " Muestra el signo de git en el 'gutter'
Plugin 'tpope/vim-fugitive'                 " Git made easy!!!


call vundle#end()

if iCanHazVundle == 0
  echo "Installing Bundles... ignore errors!"
  echo ""
  :PluginInstall
endif



" ------------------------
"  CONFIGURACION PERSONAL
" ------------------------
let mapleader=","           " <leader>

set t_Co=256
set background=dark
colorscheme jellybeans

filetype plugin indent on   " Plugins
syntax on                   " Resaltado de sintaxis

set encoding=utf-8          " preferimos utf8 al codificar ficheros

set lazyredraw              " refresco de la pantalla 'vago'

set hidden                  " ocultamos los buffers en lugar de cerrarlos
set cursorline              " resaltado de la linea actual

set laststatus=2            " Mostramos SIEMPRE la barra de estado
set showcmd                 " mostrar ultima orden ejecutada en la barra de estado
set wildmenu                " menu salvaje :)
set modelines=0             " no usamos la linea de config para vim al final de algunos ficheros...
set clipboard=unnamed

set tabstop=2               " las columnas que tiene un TAB
set shiftwidth=2            " las columnas al indentar << y >>
set expandtab               " cambiar TAB por SPACE :)

set nowrap                  " no cortar las lineas
set number                  " mostramos el numero de linea actual en el lateral

set noswapfile              " sin fichero de swap
set nobackup                " sin backups de fichero...
set nowritebackup           " ... ni mientras lo escribimos

set hlsearch                " resaltado de las busquedas
set ignorecase              " busqueda insensitiva...
set smartcase               " ... pero inteligente :)
set incsearch               " busqueda incremental

set foldmethod=indent
set nofoldenable

set autoindent              " siempre indenta
set copyindent              " indenta al copiar



" ------------------------
"         PLUGINS
" ------------------------

let g:gitgutter_max_signs = 2048

" -- vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme='jellybeans'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" -- CtrlP
nnoremap <silent> t :CtrlP<cr>
let g:ctrlp_working_path_mode = 2
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 600
let g:ctrlp_max_depth = 5
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'

" -- NERDTree
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['\.py[co]$', '\.sw[po]$', '\.class$', '\.aux$', '\.o$', '\.so$', '\.git$', '\.svn$']
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" -- Tagbar
let g:tagbar_width = 32

" -- SuperTAB
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabNoCompleteAfter = [',', '\s', ';', '/', '^', "'"]

" -- vim-commentary
autocmd FileType smarty set commentstring={*\ %s\ *}


" ------------------------
"         TECLAS
" ------------------------

" -- Teclas de funcion
map  <F1> <Esc>
nmap <F2> za
nmap <F3> :TagbarToggle<cr>
set pastetoggle=<F6>
nmap <F12> :NERDTreeToggle<cr>
nmap <S-F12> :NERDTreeClose<cr>

" -- Teclas con <leader>
nmap <leader>l :bnext<cr>
nmap <leader>h :bprevious<cr>
nmap <leader>x :bp<cr>:bd #<cr>
map  <leader>v :so ~/.vimrc<cr>
nmap <leader>n :nohlsearch<cr>

nmap <leader>u= :t.\|s/./=/g\|:nohls<cr>
nmap <leader>u- :t.\|s/./-/g\|:nohls<cr>
nmap <leader>u~ :t.\|s/./~/g\|:nohls<cr>

nmap <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <leader>gw :Gwrite<cr>
nmap <leader>gr :Gread<cr>

" -- Teclas en modo visual
" EasyAlign
vnoremap <silent> <Enter> :EasyAlign<cr>

" -- Funciones

" formatear el fichero completo
nmap <leader>fef ggVG=

" saltar entre ventanas
noremap <tab> <c-w><c-w>

" quitar resaltado de sintaxis y redibujar pantalla
nnoremap <silent> <C-L> :nohls<CR><C-L>


" ------------------------
"       ABREVIATURAS
" ------------------------
iabbr --s #-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


" ------------------------
"       FUNCIONES
" ------------------------

" Sale si no hay buffers abiertos
function! CheckLeftBuffers()
  if tabpagenr('$') == 1
    let i = 1
    while i <= winnr('$')
      if getbufvar(winbufnr(i), '&buftype') == 'help' ||
          \ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
          \ exists('t:NERDTreeBufName') &&
          \   bufname(winbufnr(i)) == t:NERDTreeBufName ||
          \ bufname(winbufnr(i)) == '__Tag_List__'
        let i += 1
      else
        break
      endif
    endwhile
    if i == winnr('$') + 1
      qall
    endif
    unlet i
  endif
endfunction
autocmd BufEnter * call CheckLeftBuffers()

