# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

source ~/.git_completion.sh

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
PS1='\[\033[1;44m\]\[\033[1;34m\]  \[\033[1;40m\] [\u@\h:\w]`echo $(__git_ps1 " (%s)") | sed "s/ //"`\n\[\033[1;44m\]\[\033[1;34m\]  \[\033[1;40m\] [j:`jobcount`, t:$cur_tty]\n\[\033[1;46m\]\[\033[1;36m\]  \[\033[1;40m\] [`date +%D` \t] $> \[\033[0;39m\]'

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
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
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

#alias matlab="ssh -o ForwardX11=yes samii@cory.eecs.berkeley.edu /share/b/bin/matlab &"
alias qt='/opt/qt/bin/qtcreator'
alias gp='git pull origin master'
alias gpu='git push'
alias gca="git commit -a"
alias rm='rmtrash'
alias sagi='sudo apt-get install'
alias pseg="ps -e | grep"
alias hg="history | grep"
alias downloaddir="wget -H -r --level=1 -k -p "
alias toon="artoonie@10.42.43.99:~"
alias pwd="pwd -P"

UNISONLOCALHOSTNAME=MARTELLA
