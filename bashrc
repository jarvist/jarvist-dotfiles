# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#Kick vim to give full colour, please. This might cause bad things to happen if logging in with some ancient terminal emulator.
export TERM=xterm-256color

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Compact Two line Prompt with
# [WeekdayDateMonth-Hour:Minute]user@host:~/directory/
# Looks Like:
# [Tue24May-12:55]jarvist@chmc-7602:~/
# >
PS1="\[${TITLEBAR}${bold}\][\D{%a%d%b-%R}]\u@\h:\w/ \n> \[${normal}\]"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto '

    alias grep='grep --color=auto '
    alias fgrep='fgrep --color=auto '
    alias egrep='egrep --color=auto '
fi

# Alias definitions.

# Output full set of 256 termcolours for when I'm playing with colourschemes
alias termcolours='for x in 0 1 4 5 7 8; do for i in `seq 30 37`; do for a in `seq 40 47`; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo "";'

# Bash key bindings
alias bashbindings="bind -p | grep -v '^#\|self-insert\|^$' "

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# set title of current terminal to `termtitle FOO` 
function setTerminalTitle { echo -ne "\033]0;${1}\007"; } 
alias termtitle=setTerminalTitle

# LINUX SPECIFIC
# Oh god I'm turning into a mac head; these enables you to 'open File' and it'll do a Mime-esque guess
alias open='xdg-open'
# These use the pleasantly simple https://github.com/jonls/redshift/ to change colour temperature
alias redshiftnow='redshift -l 51:0 -o ' #Hardcoded to London; this is where it's at.
alias blueshift='redshift -O 5600' #I'm good with daylight


# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
 PATH=~/bin:"${PATH}"
fi
export PATH

PYTHONPATH=/Users/jarvist/REPOSITORY/phonopy/lib/python:/usr/local/lib/python2.7/site-packages
export PYTHONPATH

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -n "$DISPLAY" ]; then
    xset b off
fi

# See: https://en.wikipedia.org/wiki/WarGames ; Child of the 80s
echo -e "     GREETINGS PROFESSOR FALKEN.  SHALL WE PLAY A GAME?"

tmux list-sessions 2> /dev/null # list tmux sessions, don't show anything if none...

# Countdown to next end of PDRA contract / life event
theend=` date --date "23 July 2016 13:30" +%s `
now=` date  +%s `
diff=` expr $theend - $now `
echo "Really Married in: " `expr $diff / 86400`  days  `expr \( $diff % 86400 \) / 3600` hours `expr \( \( $diff % 86400 \) % 3600 \) / 60` minutes `expr $diff % 60` seconds.
