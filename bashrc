# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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

# Override if we detect xterm suggesting color (logged in servers, tmux etc.) 
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
esac


if [ "$color_prompt" = yes ]; then
# Compact Two line Prompt with
# [WeekdayDateMonth-Hour:Minute]user@host:~/directory/
# Looks Like:
# [Tue24May-12:55]jarvist@chmc-7602:~/
# >
 PS1="\[${TITLEBAR}${bold}\][\D{%a%d%b-%R}]\u@\h:\w/ \n> \[${normal}\]"

else
 PS1="\[${TITLEBAR}${bold}\][\D{%a%d%b-%R}]\u@\h:\w/ \n> \[${normal}\]"

 #  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\n> '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto '

    alias grep='grep --color=auto '
    alias fgrep='fgrep --color=auto '
    alias egrep='egrep --color=auto '
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
alias hpc='ssh hpc ' #Home sweet home; though actually most of these are ssh-config now
# These use the pleasantly simple https://github.com/jonls/redshift/ to change colour temperature
alias redshiftnow='redshift -l 51:0 -o ' #Hardcoded to London; this is where it's at.
alias blueshift='redshift -O 5600' #I'm good with daylight

# Output full set of 256 termcolours for when I'm playing with colourschemes
alias termcolours='for x in 0 1 4 5 7 8; do for i in `seq 30 37`; do for a in `seq 40 47`; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo "";'

# Bash key bindings
alias bashbindings="bind -p | grep -v '^#\|self-insert\|^$' "

# set title of current terminal 
function setTerminalTitle { echo -ne "\033]0;${1}\007"; } 
alias termtitle=setTerminalTitle

# Oh god I'm turning into a mac head; these enables you to 'open File' and it'll do a Mime-esque guess
alias open='xdg-open'

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
#Kick vim to give full colour, please
export TERM=xterm-256color

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
