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
            shift;;
        -t)
            if [ $2 = "filledcurve" ]; then
                type="$2"; shift;
            elif [ $2 = "lines" ]; then
                type="$2"; shift;
            else
                echo "type should be one of 'filledcurve' and 'lines'";
                echo "Usage: cpuplot [-h] [-o out_file_name] [-t type] [-c color] -n <60-600>";
                exit 2;
            fi
            shift;;
        -c)
            color="$2"; shift;
            shift;;
        -n)
            size="$2"; shift;
            shift;;
        "")
            shift; break;;
    esac
done
        
