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

bold=`tput bold`
normal=`tput sgr0`

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
# Compact Two line Prompt with 
# [WeekdayDateMonth-Hour:Minute]user@host:~/directory/
# Looks Like:
# [Tue24May-12:55]jarvist@chmc-7602:~/
# > 
    PS1="\[${TITLEBAR}${bold}\][\D{%a%d%b-%R}]\u@\h:\w/ \n> \[${normal}\]"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -Gp '
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

alias ls='ls -Gp'

whiteboardme() { 
# via https://gist.github.com/lelandbatey/8677901
convert "$1" -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 "$2" 
}
alias whiteboard=whiteboardme

alias datestamp='rename "s/^/`date +%Y-%m-%d`-JarvistMooreFrost-/" '

alias ase="source ~/Virtualenvs/python-ase-3.8.1.3440/bin/activate"

# Abuse Apple's open command
alias vesta='open -a Vesta '

# Alias definitions.
#alias hpc='ssh hpc ' #Home sweet home

alias redshiftnow='redshift -l 51:0 -o ' # Linux laptop 'redshit'

# Weather via wttr.in service to Wego command line app
alias weatherbath='curl http://wttr.in/bath '
alias weatherlondon='curl http://wttr.in/london '

# Check / Close SSH Master Connections (when X-forwarding suddenly breaks)
alias ssh-MasterConnection-exit="ssh -O exit "
alias ssh-MasterConnection-check="ssh -O check "

# Background noise; seen before elsewhere, but these are from: https://news.ycombinator.com/item?id=12851409
alias play-pinknoise="play -n -n --combine merge synth pinknoise band -n 1200 1800 tremolo 50 10 tremolo 0.14 70 tremolo 0.2 50 gain  -10"
alias play-ocean="play -n -n --combine merge synth pinknoise band -n 1200 1800 tremolo 50 10 tremolo 0.14 70 tremolo 0.2 50 gain  -10"
alias play-enterprise="play -c2 -n synth whitenoise band -n 100 24 band -n 300 100 gain +20"

# Internet Radios
# Soma FM
alias soma-dronezone='mplayer -playlist http://somafm.com/dronezone130.pls'
alias soma-groovesalad='mplayer -playlist http://somafm.com/groovesalad130.pls'
# BBC: What else do you need other than R4 and R6?  :)
# Latest working playlists from: https://gist.github.com/noodlebug/0e5e3754f4e8dbf608e72431b9c34484
alias r6='mplayer -playlist http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/nonuk/low/ak/bbc_6music.m3u8 '
alias r4=' mplayer -playlist http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/nonuk/low/ak/bbc_radio_fourfm.m3u8 '

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
 PATH=~/bin:"${PATH}"
fi
if [ -d ~/hpc-bin ] ; then
 PATH=~/hpc-bin:"${PATH}"
fi
if [ -d ~/Library/Python/2.7/bin/  ] ; then
    PATH="{$PATH}":~/Library/Python/2.7/bin/
fi
export PATH

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

shopt -s checkwinsize

echo -e "${bold}     GREETINGS PROFESSOR FALKEN.  SHALL WE PLAY A GAME?${normal}"
tmux list-sessions 2> /dev/null # list tmux sessions, don't show anything if none...

# Requires GNU expr and other tools; doesn't work on Mac OSX :(
#theend=` date --date "1 November 2016 17:00" +%s `
#now=` date  +%s `
#diff=` expr $theend - $now `
#echo "Really Unemployed in: " `expr $diff / 86400`  days  `expr \( $diff % 86400 \) / 3600` hours `expr \( \( $diff % 86400 \) % 3600 \) / 60` minutes `expr $diff % 60` seconds.

