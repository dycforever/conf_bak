#!/bin/bash
export PATH=$HOME/bin/:$PATH
export LANG="en_GB.utf8"

ulimit -c unlimited

alias ls='ls --color=auto'
alias l='ls --color=auto -F'
alias la='ls --color=auto -aF'
alias ll='ls --color=auto -alF'
alias grep='grep --color'

export PYTHONPATH=/home/dyc/tools/python3-protobuf_src/python:$PYTHONPATH
export PATH=/home/dyc/tools/python3-protobuf/bin:$PATH
export LD_LIBRARY_PATH=/home/dyc/tools/python3-protobuf/lib/:$LD_LIBRARY_PATH

export PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]\u@\h'; fi)\[\033[01;34m\] \w \$([[ \$? != 0 ]] && echo \"\[\033[01;31m\]:(\[\033[01;34m\] \")\\$\[\033[00m\] "

export LC_CTYPE="zh_CN.UTF-8"
export XMODIFIERS="@im=fcitx"
fcitx