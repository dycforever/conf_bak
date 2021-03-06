#!/bin/bash
export PATH=$HOME/bin/:$PATH
export LANG="en_GB.utf8"

ulimit -c unlimited

alias ls='ls --color=auto'
alias l='ls --color=auto -F'
alias la='ls --color=auto -aF'
alias ll='ls --color=auto -alF'
alias grep='grep --color'
alias php-fpm='php-fpm -y ~/github/conf_bak/php-fpm.conf'
alias restart_fpm='kill -USR2 `cat ~/runtime/php-fpm/php-fpm.pid`'
alias vi=vim

# export PYTHONPATH=/home/dyc/tools/python3-protobuf_src/python:$PYTHONPATH
# export PATH=/home/dyc/tools/python3-protobuf/bin:$PATH
# export LD_LIBRARY_PATH=/home/dyc/tools/python3-protobuf/lib/:$LD_LIBRARY_PATH

# export LIBS=-lcommon
# export LDFLAGS=-L/home/dyc/github/program/common
# export CXXFLAGS=-L/home/dyc/github/program/common
export LIBRARY_PATH=/home/dyc/github/program/common
export CPLUS_INCLUDE_PATH=/home/dyc/github/program/common

export PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]\u@\h'; fi)\[\033[01;34m\] \w \$([[ \$? != 0 ]] && echo \"\[\033[01;31m\]:(\[\033[01;34m\] \")\\$\[\033[00m\] "

export LC_CTYPE="zh_CN.UTF-8"
export XMODIFIERS="@im=fcitx"
alias ack='ack-grep'
alias fp='ps -ef | grep'
alias emacs='emacs -nw'
