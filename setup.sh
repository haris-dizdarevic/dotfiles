#!/usr/bin/env bash

if [[ -x "$HOME/.dotfiles" ]]
then
  echo "~/.dotfiles already exists, abort!"
  exit 1
fi

if [[ "x$(whereis git)" == "x" ]]
then
  echo "This script needs git, please install first!"
  exit 2
fi

git clone --recurse https://github.com/haris-dizdarevic/dotfiles "$HOME/.dotfiles"

# install all dependencies for vim plugins
brew install neovim
brew install the_silver_searcher
brew install python3
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

function create_link {
  element=$1
  if [[ -e "$HOME/.$element" ]]
  then
    echo "Skip: $element"
  else
    echo "Link: $element"
    if [ $element == "init.vim" ]
    then
      ls -s "$HOME/.dotfiles/$element" "$HOME/.config/nvim/init.vim"
    else
      ln -s "$HOME/.dotfiles/$element" "$HOME/.$element"
    fi
  fi
}

create_link init.vim
create_link gitconfig
create_link gitignore
create_link tmux.conf

nvim

exit 0
