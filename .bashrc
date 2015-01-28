# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

source ~/.git_completion.sh
source ~/.make_completion_wrapper.sh

# export PATH=$PATH:~/mitsuba:~/bin:/opt/local/bin:/usr/local/sbin:/Applications/MATLAB_R2012a.app/bin/maci64:/Applications/MATLAB_R2012a.app/sys/os/maci64
# export CPATH=$CPATH:~/include:/opt/local/include
# export DYLD_LIBRARY_PATH=DYLD_LIBRARY_PATH:/Applications/MATLAB_R2012a.app/bin/maci64/
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/mitsuba:/usr/lib:/usr/local/MATLAB/R2012b/bin/glnxa64
# export LIBRARY_PATH=$LIBRARY_PATH:~/lib:/usr/lib:/opt/local/lib
# export INCLUDE_PATH=$INCLUDE_PATH:/opt/local/include
# export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/opt/local/lib/pkgconfig

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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

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
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Custom stuff
alias u='ssh ksamii@unix.ic.ucsc.edu'
alias c='ssh samii@login.eecs.berkeley.edu'

############ REMOTE DESKTOP LOGINS ############ 
# remote 1 - winterm
alias r1='rdesktop -fu samii -d eecs winterm.eecs.berkeley.edu &'
# remote 1 external monitor
alias r1e='rdesktop -g 1595x850 -u samii -d eecs winterm.eecs.berkeley.edu &'
# remote 2 - iserver2
alias r2='rdesktop -fu samii -d eecs iserver2.eecs.berkeley.edu &'
# remote 2 external monitor
alias r2e='rdesktop -g 1595x850 -u samii -d eecs iserver2.eecs.berkeley.edu &'
alias thrain='ssh samii@thrain.cs.berkeley.edu'

if [[ $platform == 'linux' ]]; then
    alias open='xdg-open'
    alias rm='trash-put'
elif [[ $platform == 'mac' ]]; then
    alias rm='rmtrash'
    alias rgrep='grep -R'
fi

# Utils
alias downloaddir="wget -H -r --level=1 -k -p "
alias net=' lsof -Pan -i tcp -i udp' # show all listening TCP/UDP ports
alias latexloop='latexmk -pvc -pdf'

# Make & run
alias gp='git pull origin master'
alias ga='make debug && gdb --args'
alias RR='make && time ./crop'
alias DD='make debug && gdb --args ./dcrop'
alias mcm='make clean && make'

# Shortcuts
alias gc='git commit'
alias gca="git commit -a"
alias gpu='git push'
alias gspp='git stash && git pull && git stash pop'
alias hgp="history | grep"
alias pseg="ps -e | grep"
alias sagi='sudo apt-get install'
alias htopc='htop --sort-key PERCENT_CPU'
alias htopm='htop --sort-key PERCENT_MEM'
alias findf='find . -name'

# grepr: recursively grep all non-binary files, case-insensitively, in the current directory
grepr() { grep -iIR "$1" . ; }

if [[ $platform == 'linux' ]]; then
    alias matlab='/usr/local/MATLAB/R2012b/bin/matlab -nosplash -nodesktop'
elif [[ $platform == 'mac' ]]; then
    alias matlab='/Applications/MATLAB_R2013a.app/bin/matlab -nosplash -nodesktop'
fi

# Changing what a basic command does
alias pwd="pwd -P"
if [[ $platform == 'mac' ]]; then
    alias vim='mvim -v' # To prevent vim bug
fi

# Lol just because
export WHOAMI=$(whoami)
alias whoami='echo "You are $WHOAMI, and my do you look good today."'

if [[ -e '~/.bashlexusalias' ]]; then
    source ~/.bashlexusalias
fi

# Make 'sagi' have tab-completion
make-completion-wrapper _apt_get _sagi apt-get install
complete -o filenames -F _sagi sagi

# Environment vars
export EDITOR=/usr/bin/vim
export THRAIN=samii@thrain.cs.berkeley.edu

# Run screen on start
SYSSCREENRC="" # Don't read the global screenrc
if [ $SHLVL -eq 1 ]
then
    echo "Starting tmux"
    tmux
    echo "tmux exited. Quitting outer shell."
fi

# Easier to read LS on black background
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
