#!/bin/sh
args=`getopt hotcn: $*`
if [ $? -ne 0 ]; then
    echo "Usage: cpuplot [-h] [-o out_file_name] [-t type] [-c color] -n <60-600>"
    exit 2
fi

# Set argument
size=0
out_file_name="out.png"
type="filledcurve"
color="#1E90FF"

# Cut the tags
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
            string=$2;
            if [ `expr $2 : '#[A-F0-9]\{6\}'` -eq ${#string} ]; then
                color="$2"; shift;
            else
                echo "color format error"
                echo "Usage: cpuplot [-h] [-o out_file_name] [-t type] [-c color] -n <60-600>";
                exit 2;
            fi
            shift;;
        -n)
            if [ $2 -gt 60 ]; then
                if [  $2 -lt 600 ]; then
                    size="$2"; shift;
                else
                echo "num should be in range 60 - 600";
                echo "Usage: cpuplot [-h] [-o out_file_name] [-t type] [-c color] -n <60-600>";
                exit 2;
                fi
            else
                echo "num should be in range 60 - 600";
                echo "Usage: cpuplot [-h] [-o out_file_name] [-t type] [-c color] -n <60-600>";
                exit 2;
            fi
            shift;;
        "")
            shift; break;;
    esac
done

# See if size is set or not
if [ $size -eq 0 ]; then
    echo "num must be set";
    echo "Usage: cpuplot [-h] [-o out_file_name] [-t type] [-c color] -n <60-600>"
    exit 2;
fi
