#!/bin/sh
if [ -z $1 ]; then
    echo "Usage: sysmonitor --logfile filename --email yourname@server"
#    $0 -a &
    exit
else
    # Check id
    if [ "$(id -u)" != "0" ]; then
        echo "This script must be run as root" 1>&2
        exit 1
    fi
    while [ 1 ] 
    do
        ps ax -o pid -o user -o %cpu -o rss -o time -o command -r > ps_tmp
        idle_size=`grep idle\] ps_tmp | grep -v grep | awk '{ print $3 }'`
        total_size=`awk '{ if(NR > 1) {size+=$3} } END { print size}' ps_tmp`
        usage_size=`echo "$total_size - $idle_size" | bc`
        echo "$usage_size * 100 / $total_size" | bc >> cpuusage
        echo "TOP 5 processes are:"
        echo "==============================================================="
        cat ps_tmp | grep -v idle\] | head -n 6
        
        
        sleep 1
    done
    exit
fi
