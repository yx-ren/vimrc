#/bin/bash

HOME_DIR=$(echo ~)

VIMRC_PATH="$HOME_DIR/.vimrc"
rm -rf $VIMRC_PATH
cp ./.vimrc $VIMRC_PATH

VIM_AUTOLOAD_DIR="$HOME_DIR/.vim/autoload"
rm -rf $VIM_AUTOLOAD_DIR
mkdir -p $VIM_AUTOLOAD_DIR

VIM_PLUG_PATH="./plug.vim"
cp $VIM_PLUG_PATH $VIM_AUTOLOAD_DIR
