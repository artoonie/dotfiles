#!/bin/bash

# Die on any error
set -e

# Set up bash_profile
echo "source ~/.bashrc" >>  ~/.bash_profile

# Set up vim undo directory
mkdir -p .vim/undo

# Install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install things with homebrew
brew install tmux trash htop the_silver_searcher

# Install pathogen for vim plugins
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Notes to self
echo "Now install BetterSnapTool and Slack from the AppStore"
echo "Then install iStat Menus from https://bjango.com/mac/istatmenus/"
echo "Then install Creative Cloud https://creative.adobe.com/products/download/photoshop"
