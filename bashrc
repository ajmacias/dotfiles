# variables
export EDITOR="vim"
export VISUAL="vim"

# bash
export HISTIGNORE="cd:ls:[bf]g:clear:exit"
export HISTCONTROL=erasedups
export HISTSIZE=1023
export HISTFILESIZE=1023

# opciones BASH
shopt -s cdable_vars
shopt -s cdspell
shopt -s checkhash
shopt -s checkwinsize
shopt -s cmdhist
shopt -s extglob
shopt -s histappend histreedit histverify
shopt -s sourcepath
#shopt -u mailwarn

#stty stop undef
#stty start undef

# alias
alias be="vi ~/.bashrc;unalias -a;source ~/.bashrc"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias df="df -h"
alias mkdir="mkdir -p"
alias ps="ps aux"
alias vi="vim"
alias vissh="vim ~/.ssh/known_hosts"
alias ls='ls --color=auto'
alias wget="wget -c -t inf"

alias tmux="tmux -q has-session && tmux attach-session -d || tmux new-session -n$USER -s$USER@$HOSTNAME"
alias ncdu="ncdu -r"

_myos="$(uname -o)"

case $_myos in
    Cygwin*)    
                alias open="cygstart"
                alias ping="ping -t"
                ;;
    *)
                PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\u@\h \[\033[0m\]'; fi)\[\033[00;33m\][\W]\[\033[0;31m\]:\[\033[0m\] "
                ;;
esac

# git prompt
if [ -f ~/.git-prompt.sh ]
then
    source ~/.git-prompt.sh

    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="auto"
    PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\u@\h \[\033[0m\]'; fi)\[\033[00;33m\][\W]\[\033[0;31m\]:\[\033[0m\]\[\033[00;32m\]$(__git_ps1)\[\033[0m\] "
fi

### FUNCIONES

# calculadora
function calc () {
    gawk -v CONVFMT="%12.2f" -v OFMT="%.9g"  "BEGIN { print $* ; }"
}

# ps + grep
function psg(){
  ps x | grep -v grep | grep $1 --color
}

# sincomentarios
function nocomment()
{
    egrep -a -v '^[[:space:]]*#' $1 | egrep -a '[[:print:]]'
}


# encriptacion simple
function cifrar()
{
    [ -z "$1" ] && echo "Uso: cifrar FICHERO" && return 1
    openssl bf-cbc -salt -in "$1" -out "$1.bf"
}

function descifrar
{
    test -z "$1" -o -z "$2" && echo \
	"Uso: descifrar FICHEROENTRADA FICHEROSALIDA" && return 1
    openssl bf-cbc -d -salt -in "$1" -out "$2"
}

function ds()
{
    echo "size of directories in MB"
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
        echo "you did not specify a directy, using pwd"
        DIR=$(pwd)
        find $DIR -maxdepth 1 -type d -exec du -sm \{\} \; | sort -nr
    else
        find $1 -maxdepth 1 -type d -exec du -sm \{\} \; | sort -nr
    fi
}

function movein()
{
    if [ -z "$1" ]; then
        echo "Usage: movein hostname"
    else
        P=`pwd`
        cd ~/.skel
        tar zhcf - . | ssh $1 "tar zpvxf -"
        cd $P
    fi
}

function knock()
{
    PORTS="41323 30003"

    if [ -z "$1" ]; then
        echo "Usage: knock hostname"
    else
        for port in $PORTS
        do
            echo "Doing knock in port $port"
            echo | nc $1 $port
        done
        echo "Knocked. Try to connect now."
        if [ ! -z "$2" ]; then
            echo "ssh..."
            ssh $2@$1
        fi
    fi
}

