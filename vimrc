" .vimrc
"
" ajmacias (ajmacias@ajmacias.com)
"
" CREATED:  15-09-2009 17:56
" MODIFIED: 16-01-2013 18:57

" Configuracion basica

set autoindent          " auto indentado
set backspace=2         " configuramos el retroceso

set autochdir           " chdir al directorio del fichero editado

set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

set nocompatible		" uso VIM!
set nobackup            " no hacer copias
set nowrap              " no cortar lineas largas
set ruler               " mostrar regla
set laststatus=2		" mostrar la barra de estado
set novisualbell		
set showmatch			" resaltamos los corchetes
set matchpairs+=<:>		" hacemos que < y > se resalten
set matchtime=3			" mostrar el resaltado de corchetes 0.3s
set autowrite			" autoguardado cuando :make o :next
set hidden              " ocultar bufferes sin uso
set splitright			" para que divida en la derecha

set number              " numeros de linea


set backupdir=/tmp      " poner los backups en /tmp
set backupdir-=.        " ... y no en el directorio actual

set numberwidth=1       " 
set completeopt-=menu   " quitamos el menu feito

"set textwidth=72        " ancho de linea
set textwidth=0

set expandtab           " cambiar tabs por espacios
set tabstop=4           " numero de espacios
set softtabstop=4
set shiftwidth=4
set smarttab			" TABS solo al principio de linea
set undolevels=50       " niveles de undo

set wildignore+=*/CVS/  " ignorar CVS
set wildignore+=*/SVN/  " ignorar SVN
set wildmenu
set wildmode=longest:full,full


set title
set titlestring=%F\ [vim]

" folding settings
set foldmethod=marker
set foldnestmax=10
set nofoldenable
set foldlevel=1
noremap <silent> <F2> za

" PLUGINS
" ----------------------------------------------
" taglist
let Tlist_Inc_Winwidth=0
let Tlist_Show_One_File=1
let Tlist_Exist_OnlyWindow=1
let Tlist_Use_Right_Window=1
let Tlist_Sort_Type="name"
let Tlist_Display_Prototype=0
let Tlist_Compact_Format=1 " Compact?
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Display_Tag_Scope=1
let Tlist_Close_On_Select=0
let Tlist_Enable_Fold_Column=0
let TList_WinWidth=50

" project
"let g:proj_window_width = 50
"nmap <silent> <F12> <Plug>ToggleProject
"map <silent> ,pb <Plug>ToggleProject

" NERDTree
nmap <silent> <F12> :NERDTreeToggle<CR>


" mostramos solo espacios, no barras
set fillchars=

filetype plugin on      " deteccion de tipos de fichero
syntax on               " permitimos resaltado de sintaxis

" Colores
"set background=dark
"colorscheme darkdot
" selectively enable 256 colors
if (&term == "screen" || &term == "screen-bce" || &term == "xterm" || &term == "xterm-256color" || &term == "rxvt-unicode-256color" )
  set t_Co=256
endif
"colorscheme wombat256
colorscheme railscasts

" automatismos
au BufRead * call SetStatusLine()                       " linea de estado
au BufNewFile * silent! 0r $HOME/.vim/templates/%:e.tpl " permitimos plantillas

au BufNewFile * call Created()                          " añadimos automagicamente 
au BufWrite * call LastModified()                       " CREATED y MODIFIED


" Opciones por tipos de fichero
set comments+=b:#
set comments+=b:\"
set comments+=fb:*
set comments+=n::
set comments+=s:/*,mb:**,ex:*/
set comments-=s1:/*,mb:*,ex:*/
au FileType c,cpp,java          let b:comment_leader = '// '
au FileType sh,make,perl,python let b:comment_leader = '# ' 
au FileType tex                 let b:comment_leader = '% '
au FileType vim                 let b:comment_leader = '" ' 

" Remapeos de Fn
set pastetoggle=<F6>
map <F7> :TlistToggle<CR>
map <F5> \si
map <F10> :set filetype=human wrap wm=4 lbr noswapfile nobackup<CR>
map <F11> :!wc -w %; sleep 3 <Enter><Enter>

" Abreviaturas
iabbr --s #-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
iabbr --x -- -------------------------------------------------------------------------------------
iabbr --n Alejandro Jiménez Macías
iabbr --e ajmacias@differware.net
iabbr --w ajmacias@ajmacias.com



" Funciones
function! SetStatusLine()
  let l:s1="%-3.3n\\ %f\\ %h%m%r%w"
  let l:s2="[%{strlen(&filetype)?&filetype:'?'},%{&encoding},%{&fileformat}]"
  let l:s3="%=\\ 0x%-8B\\ \\ %-14.(%l,%c%V%)\\ %<%P"
  execute "set statusline=" . l:s1 . l:s2 . l:s3
endfunction

function! Created()
    normal msHmS
    let n = min([20, line("$")])
    exe '1,' . n . 's#^\(.\{,10}CREATED:  \).*#\1' . strftime('%d-%m-%Y %H:%M') . '#e'
    normal `Szt`s
    call LastModified()
endfun

function! LastModified()
    if &modified
      normal msHmS
      let n = min([20, line("$")])
      exe '1,' . n . 's#^\(.\{,10}MODIFIED: \).*#\1' . strftime('%d-%m-%Y %H:%M') . '#e'
      normal `Szt`s
    endif
endfun

