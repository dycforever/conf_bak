source /etc/profile.d/bash-completion.sh 
export PATH=$HOME/bin/:$PATH
export LANG="en_GB.utf8"

ulimit -c unlimited

alias l='ls --color=auto -F'
alias la='ls --color=auto -aF'
alias ll='ls --color=auto -alF'

source /etc/profile.d/bash-completion.sh 
export PYTHONPATH=/home/dyc/tools/python3-protobuf_src/python:$PYTHONPATH
export PATH=/home/dyc/tools/python3-protobuf/bin:$PATH
export LD_LIBRARY_PATH=/home/dyc/tools/python3-protobuf/lib/:$LD_LIBRARY_PATH
