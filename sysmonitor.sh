#!/bin/sh
if [ -z $1 ]; then
    echo "Usage: sysmonitor --logfile filename --email yourname@server"
    $0 -a &
    echo $! > /var/run/sysmonitord.pid
    exit
else
    # Record PID
    echo $$ > /var/run/sysmonitord.pid

    # Check id
    if [ "$(id -u)" != "0" ]; then
        echo "This script must be run as root" 1>&2
        exit 1
    fi

    # Get the args 
    if [ $1 = "--logfile" ]; then
        LOGFILE=$2
        EMAIL=$4
    else
        LOGFILE=$4
        EMAIL=$2
    fi

    # Monitor
    TIMES=0
    while [ 1 ] 
    do
        ps ax -o pid -o user -o %cpu -o rss -o time -o command -r > ps_tmp
        IDLE_SIZE=`grep idle\] ps_tmp | grep -v grep | awk '{ print $3 }'`
        TOTAL_SIZE=`awk '{ if(NR > 1) {size+=$3} } END { print size}' ps_tmp`
        USAGE_SIZE=`echo "$TOTAL_SIZE - $IDLE_SIZE" | bc`
        CPUUSAGE=`echo "$USAGE_SIZE * 100 / $TOTAL_SIZE" | bc`
        echo $CPUUSAGE >> ${LOGFILE:="/tmp/sysmonitor"}
        `uptime | awk '{print $9}' >> /tmp/loading`

        # Use TIMES to record cpu loading is too high's condition
        if [ $CPUUSAGE -gt 90 ]; then
            TIMES=`echo "$TIMES + 1" | bc`
        else 
            TIMES=`echo 0`
        fi
        
        # Auto EMAIL
        if [ $TIMES -eq 5 ]; then
            echo "TOP 5 processes are:" > mail.cmd
            echo "===============================================================" >> mail.cmd
            cat ps_tmp | grep -v idle\] | head -n 6 >> mail.cmd
            `mail -s "CPU LOADING IS TOO HIGH" $EMAIL < mail.cmd`
            rm mail.cmd
        fi
        rm ps_tmp

        sleep 1
    done
    exit
fi
