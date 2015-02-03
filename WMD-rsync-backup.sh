#!/bin/sh

# Rsync WMD backup script
# 2015-02-02 - JMF; First Version

cat > exclude.tmp <<EOF
WAVECAR
CHG
CHGCAR
*.chk
EOF

echo "I am excluding from backup: "
cat exclude.tmp

for MACHINE in ultra archer neon scandium titanium
do
    figlet "${MACHINE}"
    rsync -av --exclude-from 'exclude.tmp' "${MACHINE}:~/work/" ./${MACHINE}-work && touch ${MACHINE}-work_lastbackupattempt
done
