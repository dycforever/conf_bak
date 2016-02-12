#!/bin/bash

# NOTICE!! 
# problem 1: apt-get update failed with 'failed to fetch xxx package: ... hash sum mismatch'
# solution : edit /etc/apt/sources.list, comments line with 'dev http://extra.ubuntu.com'

APTGET_OPTIONS=""
APTGET_OPTIONS="-y"

INSTALL_CMD="apt-get install $APTGET_OPTIONS"

## sudo $INSTALL_CMD vim
# sudo $INSTALL_CMD ctags cscope
# sudo $INSTALL_CMD git
# sudo $INSTALL_CMD cmake
# sudo $INSTALL_CMD libtool automake
# sudo $INSTALL_CMD g++
# sudo $INSTALL_CMD curl
# sudo $INSTALL_CMD ack-grep
# sudo $INSTALL_CMD manpages manpages-dev
# sudo $INSTALL_CMD valgrind
# sudo $INSTALL_CMD tmux
# sudo $INSTALL_CMD openssh-server
# sudo $INSTALL_CMD linux-common-tools
#
# sudo $INSTALL_CMD zsh
# git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
# cp ./dingyc.zsh-theme ~/.oh-my-zsh/themes
# chsh -s /bin/zsh 


# git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
### vim and :BundleInstall or:
# vim +BundleInstall +qall 
# sudo $INSTALL_CMD python-dev
# mkdir ~/.vim/bundle/YouCompleteMe && cd ~/.vim/bundle/YouCompleteMe && git submodule update --init --recursive && ./install.py


# sudo $INSTALL_CMD libboost-dev
# sudo $INSTALL_CMD libjsoncpp-dev
# sudo $INSTALL_CMD libssl-dev

# sudo $INSTALL_CMD scons

# for make iputils
#
# sudo $INSTALL_CMD libcap-dev

# for network traffic monitor
#
# sudo $INSTALL_CMD sysstat iftop vnstat
# sudo $INSTALL_CMD iperf 
# sudo $INSTALL_CMD glances
# sudo $INSTALL_CMD snort
# sudo $INSTALL_CMD socat netcat
# sudo $INSTALL_CMD libnetfilter-queue-dev

# sudo $INSTALL_CMD libgoogle-perftools-dev

# for js/bootstrap
# sudo $INSTALL_CMD npm
# npm install -g grunt-cli

## for haskell
#
# sudo $INSTALL_CMD ghc 
# sudo $INSTALL_CMD ruby-full

## for database 
#
# sudo $INSTALL_CMD mysql-server
#
# sudo $INSTALL_CMD --force-yes sqlite3
# sudo $INSTALL_CMD --force-yes sqlite3
# sudo $INSTALL_CMD --force-yes libsqlite3-dev


# for php-mysql extention
#
# sudo $INSTALL_CMD php5-gd 
# sudo $INSTALL_CMD php5-mysql


## for clang-llvm
# sudo $INSTALL_CMD clang llvm 


## Chinese input 
#
## if there is no "language support" item in system setting, run command below :
#sudo apt-get update && apt-get upgrade
#sudo $INSTALL_CMD language-selector-gnome

## if ibus make fcitx launch failed, run command below:
# killall ibus-daemon
# sudo apt-get purge ibus ibus-gtk ibus-gtk3 ibus-pinyin* ibus-sunpinyin

## remind !! set XMODIFIERS in gnomerc and bashrc !!
#sudo $INSTALL_CMD fcitx fcitx-pinyin fcitx-googlepinyin

## install sogou pinyin
# sudo add-apt-repository ppa:fcitx-team/nightly
# sudo apt-get update
# sudo $INSTALL_CMD fcitx-sogoupinyin

# if click buttons on laptop's pad, try command below:
# echo options psmouse proto=exps > /etc/modprobe.d/psmouse.modprobe
# if can't use wireless, try this:
# sudo apt-get install linux-firmware-nonfree

# for image 
# netpbm

# sudo apt-get install libimobiledevice-dev libplist-utils ideviceinstaller libimobiledevice-utils



