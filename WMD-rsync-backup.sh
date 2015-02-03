#!/bin/sh

# Rsync WMD backup script
# 2015-02-02 - JMF; First Version

# Construct an exclude.tmp list for rsync
cat > exclude.tmp <<EOF
WAVECAR
CHG
CHGCAR
*.chk
EOF

# Echo the contents to the user
echo "I am excluding from backup: "
cat exclude.tmp

# OK; loop over the machines from which we want to backup
#  --> these are alised in your .ssh/config
for MACHINE in ultra archer neon scandium titanium
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
    rsync -av --exclude-from 'exclude.tmp' "${MACHINE}:~/work/" ./${MACHINE}-work && touch ${MACHINE}-work_lastbackupattempt
done
