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
- cpuplot [-h] [-o out\_file\_name] [-t type] [-c color] -n \<60-600\>
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
 
#### gnuplot.cmd
- Using gnuplot this tool to draw picture, and this file contains the command test.

#### sysmonitor.sh
###### Requirement
- Your script should be in /usr/local/bin/.
- sysmonitor --logfile filename --email yourname@server
- Log the usage per second to the file specify by --logfile
- Do not need to implement fool-proof. You can add additional arguments if you need.
- If the user is not root, you should print some error message and exit.

Part 1: Get and calculate the CPU usage and log it to a file
------
- Get CPU usage of each process from ps(1).
- (sum of CPU usage exclude [idle] process) / (sum of CPU usage)
- Assume the PID of idle process is 11.
- You can only call ps once per second.
- If the CPU usage is higher than 90% over 5 seconds, you should send a email out to notify you.
- When you send a mail, you are allowed to call ps at the second time.
- Only send one mail if the loading is continuously high.
- Sample mail format

>   You should exclude the [idle] process.
    List top 5 processes of CPU usage. You should sort the result by CPU usage.
    You should display the same columns as below.
  
Part 2: Write a RC script to manage it
------
- Your RC script should be in /usr/local/etc/rc.d/.
- Start it when system start.
- Can use service(8) to start or stop it.
- You should log the running pid in "/var/run/sysmonitord.pid"
    
