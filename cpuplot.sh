#!/bin/sh
args=`getopt hotcn: $*`
if [ $? -ne 0 ]; then
    echo "Usage: cpuplot [-h] [-o out_file_name] [-t type] [-c color] -n <60-600>"
    exit 2
fi
size=0
out_file_name="out.png"
type="filledcurve"
color="#1E90FF"
while true;
do
    case "$1"
    in
        -h)
            echo "Usage: cpuplot [-h] [-o out_file_name] [-t type] [-c color] -n <60-600>";
            exit 0;;
        -o)
            out_file_name="$2"; shift;
            echo out_file_name is "'"$out_file_name"'";
            shift;;
        -t)
            type="$2"; shift;
            echo $type;
            shift;;
        -c)
            color="$2"; shift;
            echo $color;
            shift;;
        -n)
            size="$2"; shift;
            echo $size;
            shift;;
        "")
            shift; break;;
    esac
done
        
