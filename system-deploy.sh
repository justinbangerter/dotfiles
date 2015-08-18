#!/bin/sh -e
command -v git >/dev/null 2>&1 || { echo >&2 "Please install git."; exit 1; }
command -v curl >/dev/null 2>&1 || { echo >&2 "Please install curl"; exit 1; }
cd
for F in `ls -A --ignore=[^.]* --ignore=.git --ignore=.vim dotfiles`
do
  rm -r $HOME/$F || true
  ln -s $HOME/dotfiles/$F $HOME/$F
done

mkdir $HOME/.vim > /dev/null 2>&1 || true

for F in `ls -A dotfiles/.vim`
do
  rm -r $HOME/.vim/$F || true
  ln -s $HOME/dotfiles/.vim/$F $HOME/.vim/$F
done

mkdir $HOME/.vim/bundle > /dev/null 2>&1 || true
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

vim +PluginInstall +qall

echo "updated dotfiles"