#!/bin/bash

APTGET_OPTIONS="-y"
#APTGET_OPTIONS=""

INSTALL_CMD="apt-get install $APTGET_OPTIONS"

# sudo $INSTALL_CMD vim
# sudo $INSTALL_CMD ctags cscope
# sudo $INSTALL_CMD git
# sudo $INSTALL_CMD cmake
# sudo $INSTALL_CMD g++
# sudo $INSTALL_CMD ack-grep
# sudo $INSTALL_CMD  python-dev
# git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

#  vim and :BundleInstall or:
# vim +BundleInstall +qall
#cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer

# sudo $INSTALL_CMD tmux
# sudo $INSTALL_CMD openssh-server

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
#killall ibus-daemon
#sudo apt-get purge ibus ibus-gtk ibus-gtk3 ibus-pinyin* ibus-sunpinyin

## remind !! set XMODIFIERS in gnomerc and bashrc !!
#sudo $INSTALL_CMD fcitx fcitx-pinyin fcitx-googlepinyin

## install sogou pinyin
# sudo add-apt-repository ppa:fcitx-team/nightly
# sudo apt-get update
# sudo $INSTALL_CMD fcitx-sogoupinyin

