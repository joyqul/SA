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
            if [ $2 -ge 60 ]; then
                if [  $2 -le 600 ]; then
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

# Gernerate cpuusage_tmp for command to use
awk '{ print NR - 600" "$1}' cpuusage | tail -n $size > cpuusage_tmp

# Generate a temparary file to set the command file
echo "set terminal png" >> gnuplot_tmp
echo "set output '"$out_file_name"'">> gnuplot_tmp
if [ $type = "filledcurve" ]; then
    echo "set style data filledcurve above y1=0" >> gnuplot_tmp
else
    echo "set style data lines" >> gnuplot_tmp
fi
echo "set grid" >> gnuplot_tmp
echo "set title 'CPU Usage'" >> gnuplot_tmp
echo "set xlabel 'time from now (sec)'" >> gnuplot_tmp
echo "set ylabel 'CPU Usage (%)'" >> gnuplot_tmp
echo "set ytics 20" >> gnuplot_tmp
echo "set sample" $size >> gnuplot_tmp
echo "set xrange[-"$size":0]" >> gnuplot_tmp
echo "set yrange[0:100]" >> gnuplot_tmp
echo "plot 'cpuusage_tmp' using 1:2 lt rgb " '"'$color'"' "notitle" >> gnuplot_tmp
echo "set output" >> gnuplot_tmp
echo "quit" >> gnuplot_tmp

# Start drawing picture
gnuplot gnuplot_tmp

# Remove temp file
rm -f gnuplot_tmp
rm -f cpuusage_tmp
