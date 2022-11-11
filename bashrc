# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#Kick vim to give full colour, please. This might cause bad things to happen if logging in with some ancient terminal emulator.
#export TERM=xterM-UNicode-256color # xterm-256color
# made obsolete by putting term correct in Xdefaults
#unset TERM

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
#  Nb: now that I use VS code, I switch to vim, Ctrl-S, and hang the terminal :^)
stty -ixon

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
if [ -n "$ZSH_VERSION" ]; then
    PS1="%B[%D{%a%d%b-%R}]%n@%M:%/%b
; "
elif [ -n "$BASH_VERSION" ]; then
    PS1="\[${TITLEBAR}${bold}\][\D{%a%d%b-%R}]\u@\h:\w/ \n; \[${normal}\]"

# Archive history line by line to own per-day file
    PROMPT_COMMAND=' echo "$(date "+%Y-%m-%d.%H:%M:%S")${USER}@${HOSTNAME}:$(pwd) $(history 1)" >> ~/.logs/$(date "+%Y-%m-%d")-${HOSTNAME}-bash.log '
fi

# https://news.ycombinator.com/item?id=19762190
# The tl;dr here is that "ls" can be much faster if you disable colorizing files based on the their file capabilities, setuid/setgid bits, or executable flag.
LS_COLORS='ex=00:su=00:sg=00:ca=00:'

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
# simplifies and blends a photograph of a whiteboard into some more Kahn-academy esque
convert "$1" -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 "$2"
}
alias whiteboard=whiteboardme

# Post to my .plan
alias plan=' T=`mktemp` && curl -so $T https://plan.cat/~jarvist && vim $T && \
  curl -su jarvist -F "plan=<$T" https://plan.cat/stdin'

# Weather via wttr.in service to Wego command line app (unicode terminal only!)
alias weatherbath='curl http://wttr.in/bath '
alias weatherlondon='curl http://wttr.in/london '
alias weathernoc='curl http://wttr.in/noc '
alias weathermayo=weathernoc
alias weather=weatherlondon

# Check / Close SSH Master Connections (when X-forwarding suddenly breaks; laptop wakes up with stale WiFi / connections)
alias ssh-MasterConnection-exit="ssh -O exit "
alias ssh-MasterConnection-check="ssh -O check "

# Background noise; seen before elsewhere, but these are from: https://news.ycombinator.com/item?id=12851409
alias play-pinknoise="play -n -n --combine merge synth pinknoise band -n 1200 1800 tremolo 50 10 tremolo 0.14 70 tremolo 0.2 50 gain  -10"
alias play-ocean="play -n -n --combine merge synth pinknoise band -n 1200 1800 tremolo 50 10 tremolo 0.14 70 tremolo 0.2 50 gain  -10"
alias play-enterprise="play -c2 -n synth whitenoise band -n 100 24 band -n 300 100 gain +20"

# Internet Radios
# London's resonance FM
alias radio-resonanceFM='mplayer -playlist http://stream.resonance.fm:8000/resonance '
# Soma FM
alias soma-dronezone='mplayer -playlist http://somafm.com/dronezone130.pls '
alias soma-groovesalad='mplayer -playlist http://somafm.com/groovesalad130.pls '
alias soma-folkforward='mplayer -playlist http://somafm.com/folkfwd130.pls '
alias soma-underground80s='mplayer -playlist http://somafm.com/u80s130.pls '
alias soma-missioncontrol='mplayer -playlist http://somafm.com/missioncontrol64.pls ' # Only 64 kbps stream?

# BBC: What else do you need other than R4 and R6?  :)
# Latest working playlists from: https://gist.github.com/noodlebug/0e5e3754f4e8dbf608e72431b9c34484
# Fiddled with URLS until I got High Res streams (within UK), 2017-06-07
#  Current GitHub GIST with URLS:
#  https://gist.github.com/bpsib/67089b959e4fa898af69fea59ad74bc3 
# Low res ~ 44.6 kbps - AVAILABLE INTERNATIONALLY
# Med res ~ 130 kbps
# High res ~ 320 kbps - COOKING ON GAS
alias r6low='mplayer http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/nonuk/low/ak/bbc_6music.m3u8 '
alias r6med='mplayer http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/uk/high/ak/bbc_6music.m3u8 '
alias r6='mplayer http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/uk/sbr_high/ak/bbc_6music.m3u8 '

alias r4low='mplayer http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/nonuk/low/ak/bbc_radio_fourfm.m3u8 '
alias r4med='mplayer http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/uk/high/ak/bbc_radio_fourfm.m3u8 ' 
alias r4='mplayer http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/uk/sbr_high/ak/bbc_radio_fourfm.m3u8 ' 

alias r3low='mplayer http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/nonuk/low/ak/bbc_radio_three.m3u8 ' 
alias r3med='mplayer http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/uk/high/ak/bbc_radio_three.m3u8 ' 
alias r3='mplayer http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/uk/sbr_high/ak/bbc_radio_three.m3u8 '

alias worldservice='mplayer "http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/nonuk/sbr_low/ak/bbc_world_service.m3u8" ' # lo-fi alas, 96 kbps ?, AAC

alias datestamp='rename "s/^/`date +%Y-%m-%d`-JarvistMooreFrost-/" '

# Output full set of 256 termcolours for when I'm playing with colourschemes
alias termcolours='for x in 0 1 4 5 7 8; do for i in `seq 30 37`; do for a in `seq 40 47`; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo "";'

# Nice list here: https://jonasjacek.github.io/colors/ - xterm name is the easiest method
alias backgroundblue="printf '\033]11;navyblue\007'"
alias backgroundred="printf '\033]11;darkred\007'"
alias backgroundpurple="printf '\033]11;plum4\007'"
alias backgroundteal="printf '\033]11;teal\007'"

# Bash key bindings
alias bashbindings="bind -p | grep -v '^#\|self-insert\|^$' "

# such a fan https://mobile.twitter.com/thingskatedid/status/1316074032379248640
alias icat="kitty icat --align=left"
alias isvg="rsvg-convert | icat"

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
export PATH

if [ -n "$DISPLAY" ]; then
    xset b off
fi

# PLATFORM specific stuff

# Detect the platform.
case "$OSTYPE" 
in darwin*) # Mac (OSX)
    #echo "Hipster mode (OSX) enabled..."
    # Abuse Apple's open command; so you can use 'program file' sensible in terminal
    alias vesta='open -a Vesta '
    alias ase="source ~/Virtualenvs/python-ase-3.8.1.3440/bin/activate"
;;
linux-gnu*) # Debian
#echo "Debian Linux; woo"
# Oh god I'm turning into a mac head; these enables you to 'open File' and it'll do a Mime-esque guess
    alias open='xdg-open'
    
    xrdb ~/.XResources # icewm itself doesn't seem to load this. mainly urxvt defaults.
    
# These use the pleasantly simple https://github.com/jonls/redshift/ to change colour temperature
    alias redshiftnow='redshift -l 51:0 -o ' #Hardcoded to London; this is where it's at.
# nice limits for brightness; works with my Thinkpad X220
    alias bright='xbacklight -time 0 -set 100'
    alias dim='xbacklight -time 0 -set 10'
# colour temperature + brightness in one alias
    alias night='redshift -O 2700 && dim'
    alias mars='redshift -O 3500 -g 1:0.1:0.1 && dim' # The rust planet. Blue and Green are gone.
    alias day='redshift -O 5600 && bright ' #I'm good with daylight
;;
esac


# turn on auto-jump. Use 'j' to jump!
source /usr/share/autojump/autojump.sh

# Message of the day

# See: https://en.wikipedia.org/wiki/WarGames ; Child of the 80s
echo -e "${bold}     GREETINGS PROFESSOR FALKEN.  SHALL WE PLAY A GAME?${normal}"
tmux list-sessions 2> /dev/null # list tmux sessions, don't show anything if none...

# Countdown to next end of PDRA contract / life event
now=` date  +%s `

#theend=` date --date "23 July 2016 13:30" +%s `
#now=` date  +%s `
#diff=` expr $theend - $now `
#echo "Really Married in: " `expr $diff / 86400`  days  `expr \( $diff % 86400 \) / 3600` hours `expr \( \( $diff % 86400 \) % 3600 \) / 60` minutes `expr $diff % 60` seconds.

theend=1499800800 # ` date --date "11 July 2017 20:20" +%s ` # precomputed for mac
diff=` expr $now - $theend  `
echo "Last struck by lightning:    " `expr $diff / 86400`  days  `expr \( $diff % 86400 \) / 3600` hours `expr \( \( $diff % 86400 \) % 3600 \) / 60` minutes `expr $diff % 60` seconds ago.

theend=1542192060 # ` date --date "14 Nov 2018 10:41" +%s ` # precomputed for Mac :^)
diff=` expr $now - $theend  `
echo "Tean is:  " `expr $diff  / 86400`  days  `expr \( $diff % 86400 \) / 3600` hours `expr \( \( $diff % 86400 \) % 3600 \) / 60` minutes `expr $diff % 60` seconds old.

#theend=` date --date "31 Dec 2018 23:58" +%s `
#now=` date  +%s `
#diff=` expr $theend - $now  `
#echo "Last minute in the academy:  " `expr $diff / 86400`  days  `expr \( $diff % 86400 \) / 3600` hours `expr \( \( $diff % 86400 \) % 3600 \) / 60` minutes `expr $diff % 60` seconds.

theend=1606452420 #date --date "27 November 2020 04:47" +%s
diff=` expr $now - $theend  `
echo "Delivered baby Tove:  " `expr $diff / 86400`  days  `expr \( $diff % 86400 \) / 3600` hours `expr \( \( $diff % 86400 \) % 3600 \) / 60` minutes `expr $diff % 60` seconds ago.


lockdown=1584489540 # date --date "17 March 2020 23:59" +%s
diff=` expr $now - $lockdown`
echo "Lockdown for:  " `expr $diff / 604800` weeks `expr \( $diff % 604800 \) / 86400`  days  `expr \( $diff % 86400 \) / 3600` hours `expr \( \( $diff % 86400 \) % 3600 \) / 60` minutes `expr $diff % 60` seconds.

jab=1622293200 #; date --date "29 May 2021 14:00" +%s
diff=` expr $now - $jab`
echo "First vaccine:  " `expr $diff  / 86400`  days  `expr \( $diff % 86400 \) / 3600` hours `expr \( \( $diff % 86400 \) % 3600 \) / 60` minutes `expr $diff % 60` seconds.



echo "Week ` date +%V ` of `date +%Y`."

export GAUSS_EXEDIR=/usr/local/bin/g16.dir/

# Highly Bash specific stuff that chokes ZSh
# vim input mode; also see .inputrc for readline 
set -o vi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


