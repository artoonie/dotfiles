# ~/.bashrc: executed by bash(1) for non-login shells.

source ~/.git_completion.sh
source ~/.make_completion_wrapper.sh

# Set the platform globally
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='mac'
fi
export platform

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi


function jobcount {
   jobs | wc -l | tr -d " "
}
cur_tty=$(tty | sed -e "s/.*tty\(.*\)/\1/")
PS1='\[\033[1;44m\]\[\033[1;37m\]  \[\033[1;40m\] [\u@\h:\w]` echo $(__git_ps1 " \[\033[1;33m\] (%s)") | sed "s/ //"`\n\[\033[1;44m\]\[\033[1;32m\]  \[\033[1;40m\] [j:`jobcount`, t:$cur_tty]\n\[\033[1;46m\]\[\033[1;36m\]  \[\033[1;40m\] [`date +%D` \t] $> \[\033[0;39m\]'

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ] && [ $platform = 'linux' ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto -s'
    alias fgrep='fgrep --color=auto -s'
    alias egrep='egrep --color=auto -s'
elif [ $platform = 'mac' ]; then
    alias grep='grep -s'
    alias ls='ls -G'
    alias ctags="`brew --prefix`/bin/ctags"
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [[ $platform == 'linux' ]]; then
    alias open='xdg-open'
    alias rm='trash-put'
elif [[ $platform == 'mac' ]]; then
    alias rm='rmtrash'
fi

# Utils
alias downloaddir="wget -H -r --level=1 -k -p "
alias net=' lsof -Pan -i tcp -i udp' # show all listening TCP/UDP ports
alias latexloop='latexmk -pvc -pdf'

# Git Shortcuts
alias gp='git pull'
alias gf='git fetch'
alias gc='git commit'
alias gca="git commit -a"
alias gpu='git push'
alias gpnb='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)' # git push new branch
alias gspp='git stash && git pull && git stash pop'
alias gcm='git branch --merged | grep -v "\*" | grep -v master | grep -v dev | xargs -n 1 git branch -d' # git clean merged branches
alias grhh='git reset --hard HEAD'
alias gsp='git stash pop'
alias gco='git checkout'
gg() { git checkout $1 && git pull --ff-only origin $1  ; } # git get: checkout and grab latest

# Conveniences for gwih
alias gcb='git rev-parse --abbrev-ref HEAD' # git current branch
alias gid='if [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]]; then echo "DIRTY"; else echo "CLEAN"; fi' # git is dirty?
alias gip='if [[ $(git diff origin/$(gcb)) != "" ]]; then echo "NOT YET PUSHED "; else echo "HAS BEEN PUSHED"; fi' # git is pushed?
alias gwih='for i in *; do cd $i && echo "$(gid) | $(gip) :: $i @ $(gcb)" && cd ..; done' # git what is here? check each subdir

# Other shortcuts
alias mcm='make clean && make'
alias hgp="history | grep"
alias pseg="ps -e | grep"
alias sagi='sudo apt-get install'
alias htopc='htop --sort-key PERCENT_CPU'
alias htopm='htop --sort-key PERCENT_MEM'
alias findf='find . -name'

# find
findr() { find . -name $1 ; }
# grepr: recursively grep all non-binary files, case-insensitively, in the current directory
grepr() { grep -iIR "$1" . ; }
# python function count
pfc() { for i in $(grep -o  "def [^(]*" $1 | sed -e "s/def //"); do echo $(grep -c $i $1) $i; done }

if [[ $platform == 'linux' ]]; then
    alias matlab='/usr/local/MATLAB/R2012b/bin/matlab -nosplash -nodesktop'
elif [[ $platform == 'mac' ]]; then
    alias matlab='/Applications/MATLAB_R2013a.app/bin/matlab -nosplash -nodesktop'
fi

# pwd -P: "Display the physical current working directory (all symbolic links resolved)."
alias pwd="pwd -P"

if [[ -e '~/.bashlexusalias' ]]; then
    source ~/.bashlexusalias
fi

# Make 'sagi' have tab-completion
make-completion-wrapper _apt_get _sagi apt-get install
complete -o filenames -F _sagi sagi

# Environment vars
export EDITOR=/usr/bin/vim

# Run tmux on start
SYSSCREENRC="" # Don't read the global screenrc
if [ $SHLVL -eq 1 ]
then
    echo "Starting tmux"
    tmux
    echo "tmux exited. Quitting outer shell."
fi

# Easier to read LS on black background
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
