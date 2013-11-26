set terminal png
set output 'test.png'
set style data filledcurve above y1=0
set grid
set title 'CPU Usage'
set xlabel 'time from now (sec)'
set ylabel 'CPU Usage (%)'
set ytics 20
set sample 600
set xrange[-600:0]
set yrange[0:100]
plot "cpuusage_tmp" using 1:2 lt rgb "#87CEFA" notitle
set output
quit
