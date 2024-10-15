#!/bin/bash

outputfile="report.txt"
echo -n > $outputfile

# current date and time
current_date_time=$(date)
echo "Current date and time: $current_date_time" >> $outputfile

# current user
echo "Current user: $USER" >> $outputfile

# internal IP address
echo "Internal IP address: $(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')" >> $outputfile

# external IP address
echo "External IP address: $(curl -s ifconfig.me)" >> $outputfile

# hostname
echo "Hostname: $(hostname -s)" >> $outputfile

# name and version of linux distribution
echo "Name and version of Linux distribution: $(uname -a)" >> $outputfile

# system uptime
uptime_info=$(uptime)
echo "System Uptime: $(echo "$uptime_info" | awk -F, '{print $1}' | sed 's/^.*up //')" >> $outputfile

# info about used and free space
total_size=$(df -kh . | tail -n1 | awk '{print $2}')
available_size=$(df -kh . | tail -n1 | awk '{print $4}')

echo "Total size: $total_size" >> $outputfile
echo "Available size: $available_size" >> $outputfile

# info about total and free RAM
echo $(top -l 1 | grep PhysMem) >> $outputfile

# number and frequency of CPU cores
echo "Number of CPU cores: $(nproc)" >> $outputfile
echo "Frequency of CPU cores: $(grep 'cpu MHz' /proc/cpuinfo | head -1 | awk -F: '{print $2/1024}')" >> $outputfile
