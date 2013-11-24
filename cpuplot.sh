#!/bin/sh
args=`getopt hotcn: $*`
if [ $? -ne 0 ]; then
    echo "Usage: cpuplot [-h] [-o out_file_name] [-t type] [-c color] -n <60-600>"
    exit 2
fi
set -- $args
while true;
do
    case "$1"
    in
        -h)
            echo "Usage: cpuplot [-h] [-o out_file_name] [-t type] [-c color] -n <60-600>";
            exit 0;;
        -o)
            echo "out_file_name";
            shift;;
        -t)
            echo "-t type";
            shift;;
        -c)
            echo "-c color";
            shift;;
        -n)
            echo "must be set";
            shift;;
        --)
            shift; break;;
    esac
done
        
