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

    # Get the args 
    if [ $1 = "--logfile" ]; then
        filename=$2
        email=$4
    else
        filename=$4
        email=$2
    fi

    # Monitor
    times=0
    while [ 1 ] 
    do
        ps ax -o pid -o user -o %cpu -o rss -o time -o command -r > ps_tmp
        idle_size=`grep idle\] ps_tmp | grep -v grep | awk '{ print $3 }'`
        total_size=`awk '{ if(NR > 1) {size+=$3} } END { print size}' ps_tmp`
        usage_size=`echo "$total_size - $idle_size" | bc`
        cpuusage=`echo "$usage_size * 100 / $total_size" | bc`
        echo $cpuusage >> $filename

        # Use times to record cpu loading is too high's condition
        if [ $cpuusage -gt 90 ]; then
            times=`echo "$times + 1" | bc`
        else 
            times=`echo 0`
        fi
        
        # Auto email
        if [ $times -eq 5 ]; then
            echo "TOP 5 processes are:" > mail.cmd
            echo "===============================================================" >> mail.cmd
            cat ps_tmp | grep -v idle\] | head -n 6 >> mail.cmd
            `mail -s "CPU LOADING IS TOO HIGH" $email < mail.cmd`
            rm mail.cmd
        fi
        rm ps_tmp

        sleep 1
    done
    exit
fi
