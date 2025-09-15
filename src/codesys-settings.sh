#!/bin/bash

if [ $EUID -ne 0 ]; then
    echo "This script should be run as root." > /dev/stderr
    exit 1
fi

CODESYS_USER_CONFIG="/etc/CODESYSControl_User.cfg"

# Use new codesys file location if available
if [ -f "/etc/codesyscontrol/CODESYSControl_User.cfg" ]
    CODESYS_USER_CONFIG="/etc/codesyscontrol/CODESYSControl_User.cfg"
fi

if grep -q "ttySC" $CODESYS_USER_CONFIG; then
        echo ""
else
    echo "INFO: configuring COMPORT1 to /dev/ttySC0"

    echo "" >> $CODESYS_USER_CONFIG
    echo "[SysCom]" >> $CODESYS_USER_CONFIG
    echo "Linux.Devicefile=/dev/ttySC" >> $CODESYS_USER_CONFIG
fi    

if grep -q "rts_set_baud" $CODESYS_USER_CONFIG; then
        echo ""
else
    echo "" >> $CODESYS_USER_CONFIG
    echo "[CmpSocketCanDrv]" >> $CODESYS_USER_CONFIG
    echo "ScriptPath=/opt/codesys/scripts" >> $CODESYS_USER_CONFIG
    echo "ScriptName=rts_set_baud.sh" >> $CODESYS_USER_CONFIG
fi

sed -i 's/ip link set $1 type can bitrate $BITRATE/ip link set $1 type can bitrate $BITRATE\nip link set $1 up txqueuelen 1000/' /opt/codesys/scripts/rts_set_baud.sh

echo "INFO: disabling can0 and can1 startup service"
systemctl disable can0.service
systemctl disable can1.service