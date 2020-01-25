# Unload Giga-Ethernet
sudo rmmod e1000e

# WiFi powersave
iw dev wlan0 set power_save on

#NMI Watchdog off
echo '0' > '/proc/sys/kernel/nmi_watchdog';

# Dirty writebacks
echo '1500' > '/proc/sys/vm/dirty_writeback_centisecs'

#Autosuspend for USB device USB DISK 2.0
echo 'auto' > '/sys/bus/usb/devices/2-1.1/power/control'

#Min power all SATA links
for i in ` seq 0 5 `
do
    echo "SATA Link $i min power..."
    echo 'min_power' > '/sys/class/scsi_host/host'$i'/link_power_management_policy'
done

# Intel chipset power control

for dir in /sys/bus/pci/devices/*
do
    echo "Intel chipset $dir auto power control..."
     echo 'auto' > "${dir}/power/control"
done

echo "OK! Tried to save power."

echo "Setting 80% battery charge limit..."

# better to use tlp, than set this by hand
#sudo modprobe tp_smapi
#echo 40 | sudo tee /sys/devices/platform/smapi/BAT0/start_charge_thresh
#echo 80 | sudo tee /sys/devices/platform/smapi/BAT0/stop_charge_thresh

sudo tlp setcharge 50 80 BAT0

cat /sys/devices/platform/smapi/BAT0/start_charge_thresh
cat /sys/devices/platform/smapi/BAT0/stop_charge_thresh

# catch all powertop autotune
#  I think this might turn on power saving audio codec = irritating clicking,
#  and usb mouse transciever = irritating lag in mouse
sudo powertop --auto-tune
