# Set up bash_profile
echo "source ~/.bashrc" >>  ~/.bash_profile

# Install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install things with homebrew
brew install tmux
brew install rmtrash

# Install pathogen for vim plugins
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install vim plugins
git clone https://github.com/easymotion/vim-easymotion ~/.vim/bundle/vim-easymotion
