###  Jarv's totally rad GNUPLOT init

### Gnuplot version 5.0 intialization file
### This file is loaded by gnuplot at the start of each run.
### It is provided as a template, with all commands commented out.
### Uncomment and customize lines for local use.
### Any commands placed here will affect all users.
### To customize gnuplot's initial state for an individual user,
### place commands in a private file ~/.gnuplot instead.

###
### Language initialization
###
# set locale
# set encoding locale

###
### Default line colors and repeat cycle
###   from my gnuplot publication thingy
set linetype 1 pi -1 pt 6 lc rgb '#377EB8' dt solid # blue
set linetype 2 pi -1 pt 1 lc rgb '#E41A1C' dt solid # red
set linetype 3 pi -1 pt 2 lc rgb '#4DAF4A' dt solid # green
set linetype 4 pi -1 pt 4 lc rgb '#984EA3' dt solid # purple
set linetype 5 pi -1 pt 1 lc rgb '#FF7F00' dt solid # orange
set linetype 6 pi -1 pt 6 lc rgb '#FFFF33' dt solid # yellow
set linetype 7 pi -1 pt 2 lc rgb '#A65628' dt solid # brown
set linetype 8 pi -1 pt 4 lc rgb '#F781BF' dt solid # pink

# set linetype 1 lc rgb "dark-violet" lw 1
# set linetype 2 lc rgb "#009e73" lw 1
# set linetype 3 lc rgb "#56b4e9" lw 1
# set linetype 4 lc rgb "#e69f00" lw 1
# set linetype 5 lc rgb "#f0e442" lw 1
# set linetype 6 lc rgb "#0072b2" lw 1
# set linetype 7 lc rgb "#e51e10" lw 1
# set linetype 8 lc rgb "black"   lw 1
# set linetype cycle 8

###
### Initialize the default loadpath for shared gnuplot scripts and data.
### Please confirm that this path is correct before uncommented the line below.
###
# set loadpath "/usr/local/share/gnuplot/4.7/demo"

###
### Some commonly used functions that are not built in
###
# sinc(x) = sin(x)/x
# rgb(r,g,b) = sprintf("#%06x",256.*256.*255.*r+256.*255.*g+255.*b)
# hsv(h,s,v) = sprintf("#%06x",hsv2rgb(h,s,v))

###
### Other preferences
###
# set clip two

print "Jarv's totally rad GNUPLOT init."
