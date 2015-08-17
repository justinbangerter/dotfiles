#!/bin/sh -e
cd
for F in `ls -A --ignore=[^.]* --ignore=.git --ignore=.vim dotfiles`
do
  rm -r $HOME/$F || true
  ln -s $HOME/dotfiles/$F $HOME/$F || true
done

mkdir $HOME/.vim || true

for F in `ls -A dotfiles/.vim`
do
  rm -r $HOME/.vim/$F || true
  ln -s $HOME/dotfiles/.vim/$F $HOME/.vim/$F || true
done