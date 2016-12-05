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

# vim input mode; also see .inputrc for readline 
set -o vi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# PROMPT
bold=`tput bold`
normal=`tput sgr0`

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
whiteboardme() {
# via https://gist.github.com/lelandbatey/8677901
convert "$1" -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 "$2"
}
alias whiteboard=whiteboardme

# Weather via wttr.in service to Wego command line app (unicode terminal only!)
alias weatherbath='curl http://wttr.in/bath '
alias weatherlondon='curl http://wttr.in/london '

# Check / Close SSH Master Connections (when X-forwarding suddenly breaks; laptop wakes up with stale WiFi / connections)
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

alias datestamp='rename "s/^/`date +%Y-%m-%d`-JarvistMooreFrost-/" '

# Output full set of 256 termcolours for when I'm playing with colourschemes
alias termcolours='for x in 0 1 4 5 7 8; do for i in `seq 30 37`; do for a in `seq 40 47`; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo "";'

# Bash key bindings
alias bashbindings="bind -p | grep -v '^#\|self-insert\|^$' "

# some more ls aliases
alias ls='ls -Gp' #p to show trailing / on directory/ names
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# set title of current terminal to `termtitle FOO` 
function setTerminalTitle { echo -ne "\033]0;${1}\007"; } 
alias termtitle=setTerminalTitle

# PATHs
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

if [ -n "$DISPLAY" ]; then
    xset b off
fi

# PLATFORM specific stuff

# Detect the platform.
case "$OSTYPE" in
darwin*) # Mac (OSX)
#echo "Hipster mode (OSX) enabled..."
# Abuse Apple's open command; so you can use 'program file' sensible in terminal
alias vesta='open -a Vesta '
alias ase="source ~/Virtualenvs/python-ase-3.8.1.3440/bin/activate"

PYTHONPATH=/Users/jarvist/REPOSITORY/phonopy/lib/python:/usr/local/lib/python2.7/site-packages
export PYTHONPATH

;;
linux-gnu*) # Debian
#echo "Debian Linux; woo"
# Oh god I'm turning into a mac head; these enables you to 'open File' and it'll do a Mime-esque guess
alias open='xdg-open'
# These use the pleasantly simple https://github.com/jonls/redshift/ to change colour temperature
alias redshiftnow='redshift -l 51:0 -o ' #Hardcoded to London; this is where it's at.
alias redshiftnight='redshift -O 3700'
alias blueshift='redshift -O 5600' #I'm good with daylight
;;
esac

# See: https://en.wikipedia.org/wiki/WarGames ; Child of the 80s
echo -e "${bold}     GREETINGS PROFESSOR FALKEN.  SHALL WE PLAY A GAME?${normal}"

tmux list-sessions 2> /dev/null # list tmux sessions, don't show anything if none...

# Only on Linux currently! should rewrite this...
case "$OSTYPE" in
linux*) # Mac (OSX)
# Countdown to next end of PDRA contract / life event
theend=` date --date "23 July 2016 13:30" +%s `
now=` date  +%s `
diff=` expr $theend - $now `
echo "Really Married in: " `expr $diff / 86400`  days  `expr \( $diff % 86400 \) / 3600` hours `expr \( \( $diff % 86400 \) % 3600 \) / 60` minutes `expr $diff % 60` seconds.
;;
esac

