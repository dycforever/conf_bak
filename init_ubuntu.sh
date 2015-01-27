#!/bin/bash

# NOTICE!! 
# problem 1: apt-get update failed with 'failed to fetch xxx package: ... hash sum mismatch'
# solution : edit /etc/apt/sources.list, comments line with 'dev http://extra.ubuntu.com'

APTGET_OPTIONS=""
APTGET_OPTIONS="-y"

INSTALL_CMD="apt-get install $APTGET_OPTIONS"

# sudo $INSTALL_CMD vim
# sudo $INSTALL_CMD ctags cscope
# sudo $INSTALL_CMD git
# sudo $INSTALL_CMD cmake
# sudo $INSTALL_CMD libtool automake
# sudo $INSTALL_CMD g++
# sudo $INSTALL_CMD ack-grep
# sudo $INSTALL_CMD manpages manpages-dev
# sudo $INSTALL_CMD valgrind
# sudo $INSTALL_CMD  python-dev python3
# git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
# 
## vim and :BundleInstall or:
# vim +BundleInstall +qall 
# cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer

# 
# sudo $INSTALL_CMD tmux
# sudo $INSTALL_CMD openssh-server
# sudo $INSTALL_CMD libboost-dev
# sudo $INSTALL_CMD libjsoncpp-dev

# sudo $INSTALL_CMD scons

# for make iputils
#
# sudo $INSTALL_CMD libcap-dev

# for network traffic monitor
#
# sudo $INSTALL_CMD sysstat iftop vnstat
# sudo $INSTALL_CMD glances
# sudo $INSTALL_CMD snort
# sudo $INSTALL_CMD socat netcat
# sudo $INSTALL_CMD libnetfilter-queue-dev

# sudo $INSTALL_CMD libgoogle-perftools-dev

# for js/bootstrap
# sudo $INSTALL_CMD npm
# npm install -g grunt-cli

## for mp3/media player
#
# sudo $INSTALL_CMD ubuntu-restricted-extras
# sudo $INSTALL_CMD chmsee

## for python-qt
# 
# sudo $INSTALL_CMD qt4-dev-tools qt4-doc qt4-qtconfig qt4-demos qt4-designer qtcreator
# sudo $INSTALL_CMD libphonon4 libqt4-webkit
## then download lucid-version libqt4-webkit from http://packages.ubuntu.com/lucid/amd64/libqt4-webkit/download
## extract .deb and place libqt4-webkit_4.6.2-0ubuntu5.6_amd64/usr/lib/qt4/plugins/designer/libqwebview.so in /usr/share/qt4/plugins/designer
#
# sudo $INSTALL_CMD pyqt4-dev-tools

## for haskell
#
# sudo $INSTALL_CMD ghc 


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

# sudo $INSTALL_CMD ruby-full

