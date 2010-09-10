# ~/.bashrc: executed by bash(1) for non-login shells.

########################################################################
# Stuff from the standard debian/ubuntu .bashrc
########################################################################
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# colorize ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# NEIL: currently disabled cus i hate this
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

########################################################################
# basic neil stuff
########################################################################
# use a private bin
PATH=~/.bin:$PATH

# default file permission of -rw-r----- (drwxr-----)
umask 027

########################################################################
# colorized prompt stuff
########################################################################
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# We have color support; assume it's compliant with Ecma-48
# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# a case would tend to support setf rather than setaf.)
    color_prompt=yes
else
    color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    BLD=$(tput bold)
    RST=$(tput sgr0)
    RED=$BLD$(tput setaf 1)
    GRN=$(tput setaf 2)
    YLW=$BLD$(tput setaf 3)
    BLU=$BLD$(tput setaf 4)
    MAG=$(tput setaf 5)
    CYN=$(tput setaf 6)
    WHT=$BLD$(tput setaf 7)
else
    BLD=""
    RST=""
    RED=""
    GRN=""
    YLW=""
    BLU=""
    MAG=""
    CYN=""
    WHT=""
fi

function seperator {
  if [ $? -eq 0 ]; then
    COLOR=$GRN
  else
    COLOR=$RED
  fi

  echo "${COLOR}________________________________________________________________________________$RST"
}

export -f seperator

function indicate-virtualenv {
    if [ -n "$VIRTUAL_ENV" ]; then
        name=$(basename $VIRTUAL_ENV)
        echo "${YLW}[${name}] ${RST}: "
    fi
}

export PS1='$(seperator)\n${MAG}\u${RST}@${BLU}\h${RST} : $(indicate-virtualenv)${WHT}\w${RST}\n\$ '
