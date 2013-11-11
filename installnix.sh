#!/bin/bash

if [ "$(ls -A vim/bundle/syntastic)" = "" ]; then
  git submodule init
  git submodule update
fi

# Check to see if .vim and .vimrc already exist. If they do, archvie them
# into _bck files unless they are just symbolic links, in which case just
# remove the old links.

DAT=`date -u +%s`

if [ -e $HOME/.vimrc ]; then
  if [ -L $HOME/.vimrc ]; then
    rm $HOME/.vimrc
  else
    mv $HOME/.vimrc $HOME/.vimrc_bck_$DAT
  fi
fi

if [ -e $HOME/.vim ]; then
  if [ -L $HOME/.vim ]; then
    rm $HOME/.vim
  else
    mv $HOME/.vim $HOME/.vim_bck_$DAT
  fi
fi

ln -s ${PWD}/vimrc $HOME/.vimrc
ln -s ${PWD}/vim $HOME/.vim
