begin=` date --date "14 June 2012 17:00" +%s `
now=` date  +%s `

diff=` expr $now - $begin `

echo "For: " `expr $diff / 86400`  days  `expr \( $diff % 86400 \) / 3600` hours `expr \( \( $diff % 86400 \) % 3600 \) / 60` minutes `expr $diff % 60` seconds.
