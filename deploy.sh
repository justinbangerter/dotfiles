#!/bin/sh -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

command -v git >/dev/null 2>&1 || { echo >&2 "Please install git."; exit 1; }
command -v curl >/dev/null 2>&1 || { echo >&2 "Please install curl"; exit 1; }
cd
for F in `ls -A --ignore=[^.]* --ignore=.git --ignore=.vim --ignore=.cabal --ignore=.config $SCRIPT_DIR`
do
  rm -r $HOME/$F > /dev/null 2>&1 || true
  ln -s $SCRIPT_DIR/$F $HOME/$F
done

mkdir $HOME/.vim > /dev/null 2>&1 || true
for F in `ls -A $SCRIPT_DIR/.vim`
do
  rm -r $HOME/.vim/$F > /dev/null 2>&1 || true
  ln -s $SCRIPT_DIR/.vim/$F $HOME/.vim/$F
done

mkdir $HOME/.vim/bundle > /dev/null 2>&1 || true
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

vim +PluginInstall +qall

mkdir -p $HOME/.config 2>&1 || true
for F in `ls -A $SCRIPT_DIR/.config`
do
    rm -r $HOME/.config/$F > /dev/null 2>&1 || true
    ln -s $SCRIPT_DIR/.config/$F $HOME/.config/$F
done

echo "updated dotfiles"
