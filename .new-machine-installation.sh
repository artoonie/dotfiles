#!/bin/bash

# First, create the repo in your home folder by
# git init
# git remote add origin https://github.com/artoonie/dotfiles.git
# git pull origin master
# (To get that far on a mac, you'll be prompted to install xcode commmand line tools)
# Then, run this script

# Die on any error
set -e

# Set up bash_profile
echo "source ~/.bashrc" >>  ~/.bash_profile

# Set up vim undo directory
mkdir -p .vim/undo

# Install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install things with homebrew
brew install tmux
brew install rmtrash
brew install imagemagick

# Install pathogen for vim plugins
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install vim plugins
git clone https://github.com/easymotion/vim-easymotion ~/.vim/bundle/vim-easymotion

# Install lolcommits
sudo gem install lolcommits

# Notes to self
echo "Now install BetterSnapTool and Slack from the AppStore"
echo "Then install iStat Menus from https://bjango.com/mac/istatmenus/"
echo "Then install Creative Cloud https://creative.adobe.com/products/download/photoshop"
