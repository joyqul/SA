SA
==

Codes for the system administration class.

#### p1.sh
###### Requirement
- Inspect the current directory(“.”) and all sub-directory. 
- Calculate the number of directories. (Do not include ‘.’ and ‘..’)
- Calculate the number of files.
- Calculate the sum of all file size.
- List the top 5 biggest files.
- Only consider the regular file. Do not count in the link, FIFO, block device... etc.

#### p1.awk
>   command's awk part's code.

#### cpuplot.sh
###### Requirement
- Use gnuplot to draw the CPU usage.
- CPU usage is logged in a log file. You only need to read and plot it.
- cpuplot [-h] [-o out_file_name] [-t type] [-c color] -n <60-600>
- -h print the help.
- -o set the output file name. (default: out.png)
- -t set the graph type. (one of ‘filledcurve’, ‘lines’, default: ‘filledcurve’)
- -c set graph color. (in hexadecimal form, default: #1E90FF)
- -n set the number of point should use. (Must be set. Should be in range [60-600])
- Read LOGFILE environment variable. If it is not set, use “/tmp/sysmonitor”
- If type is not one of ‘filledcurve’, ‘lines’, you should print error message and help.
>   type should be one of 'filledcurve' and 'lines'.
- If color is not in hexadecimal form (a leading sharp ‘#’ and 6 hex digits.), you should print error message and help.
>   color format error.
- If the number specified by –n is not in [60-600], you should print error message and help.
>   num should be in range 60 - 600.
- It doesn’t matter which is checked first.
- You can generate temporary files, but you need to clean them when exit.
-Image output format
>   The title should be “CPU Usage”.
    The y-title should be “CPU Usage (%)”.
    The x-title should be ”time from now (sec)”.
    The y-axis range should be 0-100.
    The x-axis means “time from now”. You can’t predict future, so the value should be negative.
    The CPU usage is appended to the log file every second. If you get “-n 60” it means you should draw the last 60 lines in the log file.
 
