#!/bin/sh
if [ -z $1 ]; then
    echo "Usage: sysmonitor --logfile filename --email yourname@server"
    $0 -a &
    exit
else
    # Check id
    if [ "$(id -u)" != "0" ]; then
        echo "This script must be run as root" 1>&2
        $0 -a &
        exit 1
    fi
    while [ 1 ] 
    do
        ps aux > ps_tmp
        idle_size=`grep idle\] ps_tmp | grep -v grep | awk '{ print $3 }'`
        total_size=`awk '{ size+=$3 } END { print size}' ps_tmp`
        sleep 1
    done
fi
