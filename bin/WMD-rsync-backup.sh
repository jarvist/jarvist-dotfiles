#!/bin/sh

# Rsync WMD backup script
# 2015-02-02 - JMF; First Version
# 2017-11-14 - updates in machine list

# Construct an exclude.tmp list for rsync
cat > exclude.tmp <<EOF
oq#cq <--- this is an Rsync comment (I know, crazy eh?)

oq#cq Standard VASP big files
WAVECAR
CHG
CHGCAR

oq#cq Gaussian Checkpoints
*.chk
oq#cq Gaussian Crash outputs
Gau-*

oq#cq General unix core-dumps (crashed program memory contents)
core.*
EOF

# Echo the contents to the user
echo "I am excluding from backup: "
cat exclude.tmp

# OK; loop over the machines from which we want to backup
#  --> these are alised in your .ssh/config
for MACHINE in archer frisky titanium-tunnel scandium-tunnel cx2 #neon ultra 
do
    # Banner display of which MACHINE we're hoovering from
    figlet "${MACHINE}"
    # Rsync
    #  -a(rchive)
    #  -v(erbose)
    #  --exclude-from - dynamically generated list
    #  Pull down MACHINE:~/work/ into a directory called MACHINE-work
    # && logical and, so only if rsync exited happily, 
    # touch - update timestamped note of backupattempt
    rsync -av \
        --exclude-from 'exclude.tmp' \
        "${MACHINE}:~/work/" ./${MACHINE}-work \
    && touch ${MACHINE}-work_lastbackupattempt
done

