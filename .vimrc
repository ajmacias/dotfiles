"inspirado por: http://c7.se/switching-to-vundle/
"             : http://yannesposito.com/Scratch/en/blog/Vim-as-IDE/
"             : https://github.com/VundleVim/Vundle.vim

set nocompatible
filetype off

" Vundle Power
let FreshVundle=0
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  let FreshVundle=1
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle controlando Vundle :)
Plugin 'VundleVim/Vundle.vim'

" IDE: Basico
Plugin 'bling/vim-airline'                  " Barra de estado
Plugin 'nanotech/jellybeans.vim'            " Color
Plugin 'majutsushi/tagbar'                  " Visor de tags
Plugin 'scrooloose/nerdtree'                " Visor de ficheros

" IDE: Complementos
Plugin 'bronson/vim-trailing-whitespace'    " Ver y borrar espacios al final de las lineas
Plugin 'ervandew/supertab'                  " Autocompletado con tabulador
Plugin 'godlygeek/tabular'                  " formateo tabular de datos
Plugin 'Raimondi/delimitMate'               " cierra delimitadores
Plugin 'scrooloose/syntastic'               " Comprobador de sintaxis
Plugin 'sjl/gundo.vim'                      " undelete
Plugin 'tpope/vim-commentary'               " Comentado de codigo
Plugin 'tpope/vim-fugitive'                 " Git made easy!!!
Plugin 'mhinz/vim-signify'                  " git diff en gutter


call vundle#end()

if FreshVundle == 1
  echo "Installing Bundles... ignore errors!"
  echo ""
  :PluginInstall
endif


" -----------------------------
" CONFIGURACION GENERAL
" -----------------------------

set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"
set t_ut=                               " setting for looking properly in tmux
set t_ti= t_te=                         " prevent vim from clobbering the scrollback buffer
colorscheme jellybeans

filetype plugin indent on               " plugins
syntax on                               " resaltado de sintaxis

set modelines=0                         " ignoramos linea de config para vim en ficheros
set number                              " mostramos los numeros de linea
set ruler                               " mostramos la regla

set tabstop=2                           " las columnas que tiene un TAB
set shiftwidth=2                        " las columnas que movemos al indentar << y >>
set softtabstop=2
set expandtab                           " cambiar TABs por :space: :)

set encoding=utf-8                      " preferimos utf8 para la codificacion de ficheros
set autoindent                          " indentado automatico
set copyindent                          " indentado al copiar
set showcmd                             " mostrar la ultima orden ejecutada en la barra de estado
set hidden                              " ocultamos los buffers en lugar de cerrarlos

set wildmenu                            " menu salvaje :)
set wildmode=list:longest,full

set lazyredraw                          " refresco de la pantalla 'vago'
set laststatus=2                        " mostramos siempre la barra de estado
set cursorline                          " resaltado de linea actual

set hlsearch                            " resaltado de busquedas
set ignorecase                          " hacer la busqueda insensitiva...
set smartcase                           " ... pero inteligente
set incsearch                           " busqueda incremental

set noswapfile                          " sin fichero de swap
set nobackup                            " sin backups de fichero
set nowritebackup                       " ... ni mientras lo escribimos

set nofoldenable
set foldmethod=indent

set showmode
"set visualbell
set ttyfast
set backspace=indent,eol,start
set scrolloff=3

" -----------------------------
"  CONFIGURACION DE PLUGINS
" -----------------------------

" -- vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme='jellybeans'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tagbar#enabled = 0

" -- NERDTree
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['\.py[co]$', '\.sw[po]$', '\.class$', '\.aux$', '\.o$', '\.so$', '\.git$', '\.svn$']
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" -- Tagbar
let g:tagbar_width = 32

" -- SuperTAB
let g:SuperTabDefaultCompletitionType = "context"
let g:SuperTabNoCompleteAfter = [',', '\s', ';', '/', '^', "'"]

" -- vim-commentary
autocmd FileType smarty set commentstring={*\ %s\ *}


" -----------------------------
"  TECLAS Y ATAJOS DE TECLADO
" -----------------------------
let mapleader = ","

map <F1> <Esc>
nmap <F2> za
nmap <F3> :TagbarToggle<cr>
set pastetoggle=<F6>
nmap <F11> :GundoToggle<cr>
nmap <F12> :NERDTreeToggle<cr>
nmap <S-F12> :NERDTreeClose<cr>

" recarga de .vimrc
map  <leader>v :so ~/.vimrc<cr>


" - atajos para buffers
nmap <leader>l :bnext<cr>
nmap <leader>h :bprevious<cr>
nmap <leader>x :bp<cr>:bd #<cr>

" - limpiado de resultados de busqueda
nnoremap <silent> <C-L> :nohls<CR><C-L>
nmap <leader>n :nohls<cr>

" - subraya la linea actual
nmap <leader>u= :t.\|s/./=/g\|:nohls<cr>
nmap <leader>u- :t.\|s/./-/g\|:nohls<cr>
nmap <leader>u~ :t.\|s/./~/g\|:nohls<cr>

" formatear el fichero completo
nmap <leader>fef ggVG=

" saltar entre ventanas
noremap <tab> <c-w><c-w>

" atajos mas comunes de Tabular
nnoremap <leader>a= :Tabularize /=<CR>
vnoremap <leader>a= :Tabularize /=<CR>
nnoremap <leader>a: :Tabularize /:\zs<CR>
vnoremap <leader>a: :Tabularize /:\zs<CR>

" atajos para fugitive
nmap <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <leader>gw :Gwrite<cr>
nmap <leader>gr :Gread<cr>
nmap <leader>ga :Git add %:p<CR><CR>
nmap <leader>gc :Gcommit -v -q<CR>
nmap <leader>gt :Gcommit -v -q %:p<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gl :silent! Glog<CR>:bot copen<CR>
nmap <leader>gp :Ggrep<Space>
nmap <leader>gm :Gmove<Space>
nmap <leader>gb :Git branch<Space>
nmap <leader>go :Git checkout<Space>
nmap <leader>gps :Dispatch! git push<CR>
nmap <leader>gpl :Dispatch! git pull<CR>


" -----------------------------
" ABREVIATURAS
" -----------------------------
iabbr --s #-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


" -----------------------------
"       FUNCIONES
" -----------------------------
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







