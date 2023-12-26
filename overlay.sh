# this script is for Petalinux

rm -rf /lib/firmware
mkdir /lib/firmware
cp /tmp/zybo-z7-10-pmods-petalinux.bit.bin /lib/firmware

rm -rf /sys/kernel/config/device-tree/overlays/full
mkdir /sys/kernel/config/device-tree/overlays/full
cat /tmp/zybo-z7-10-pmods-petalinux.dtbo > /sys/kernel/config/device-tree/overlays/full/dtbo
