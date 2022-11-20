# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# getting proper history
export HISTCONTROL=ignoredups:ignorespace:erasedups
export HISTFILESIZE=20000
export HISTSIZE=20000
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
shopt -s histappend
shopt -s checkwinsize

# getting proper colors
export TERM="xterm-256color"

# ParrotOS Like terminal prompt
if [ "$color_prompt" = yes ]; then
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
else
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
fi

# bash completiotion
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# kubectl auto completion
if [ -x "$(command -v kubectl)" ]; then
    source <(kubectl completion bash)
fi
 
# "bat" as manpager
if [ -x "$(command -v bat)" ]; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# source functions and aliases
[[ -f ~/.bash/aliases.sh ]] && source "$HOME/.bash/aliases.sh"
[[ -f ~/.bash/functions.sh ]] && source "$HOME/.bash/functions.sh"

export PATH=$PATH:/root/bin

/root/bin/banner
