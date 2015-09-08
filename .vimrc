"inspirado por: http://c7.se/switching-to-vundle/
"             : http://yannesposito.com/Scratch/en/blog/Vim-as-IDE/
"

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
Plugin 'itchyny/lightline.vim'              " Barra de estado
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

" -- vim-lightline
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ' ' " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0


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







