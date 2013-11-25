set terminal png
set output 'test.png'
set style data filledcurve
set grid
set title 'CPU Usage'
set xlabel 'time from now (sec)'
set ylabel 'CPU Usage (%)'
set ytics 20
set sample 600
set xrange[-600:0]
set yrange[0:100]
f(x) = x
plot 'cpuusage' with linespoints, f(x)
set output
quit
