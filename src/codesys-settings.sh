#!/bin/bash

if [ $EUID -ne 0 ]; then
    echo "This script should be run as root." > /dev/stderr
    exit 1
fi

if grep -q "ttySC" "/etc/CODESYSControl.cfg"; then
        echo ""
else
    echo "INFO: configuring COMPORT1 to /dev/ttySC0"

    echo "" >>/etc/CODESYSControl.cfg
    echo "[SysCom]" >>/etc/CODESYSControl.cfg
    echo "Linux.Devicefile=/dev/ttySC" >>/etc/CODESYSControl.cfg
    echo "portnum := COM.SysCom.SYS_COMPORT1;" >>/etc/CODESYSControl.cfg
fi    

if grep -q "rts_set_baud" "/etc/CODESYSControl.cfg"; then
        echo ""
else
    echo "" >>/etc/CODESYSControl.cfg
    echo "[CmpSocketCanDrv]" >>/etc/CODESYSControl.cfg
    echo "ScriptPath=/opt/codesys/scripts" >>/etc/CODESYSControl.cfg
    echo "ScriptName=rts_set_baud.sh" >>/etc/CODESYSControl.cfg
fi

sed -i 's/ip link set $1 type can bitrate $BITRATE/ip link set $1 type can bitrate $BITRATE\nip link set $1 up txqueuelen 1000/' /opt/codesys/scripts/rts_set_baud.sh

echo "INFO: disabling can0 and can1 startup service"
systemctl disable can0.service
systemctl disable can1.service