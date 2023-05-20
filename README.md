To terraform your machine:

On mac:

1. Download homebrew
2. brew install git git-lfs tmux the_silver_searcher
2. In terminal preferences:
    - Change Profile to Homebrew (hit "Default", don't just select it) 
    - In the "Shell" tab, change "Run Command" to run `tmux`
    - In the "Shell" tab, change "When the shell exits" to "if exited cleanly"
3. Clone this repo into your root:
```
git init
git remote add origin https://github.com/artoonie/dotfiles.git
git pull origin main
```
4. On mac, run ./new-machine-installation.sh

On Linux:

sudo apt-get install the_silver_searcher
