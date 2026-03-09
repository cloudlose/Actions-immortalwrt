#!/bin/sh
# ncm1.sh - Restore USB network mode on boot using ncm.sh (direct command version)

sleep 3
MODE=$(cat /etc/net_mode 2>/dev/null)
case "$MODE" in
    ncm|ecm|rndis)
        /root/ncm.sh "$MODE" &
        ;;
    *)
        /root/ncm.sh rndis &
        ;;
esac
