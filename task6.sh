#!/bin/bash

# current date and time
current_date_time=$(date)
echo "Current date and time: $current_date_time"

# current user
echo "Current user: $USER"

# internal IP address
echo "Internal IP address: $(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"

# external IP address
echo "External IP address: $(curl -s ifconfig.me)"

# hostname
echo "Hostname: $(hostname -s)"

# name and version of linux distribution
echo $(uname -a)

# system uptime
uptime_info=$(uptime)
echo "System Uptime: $(echo "$uptime_info" | awk -F, '{print $1}' | sed 's/^.*up //')"

# info about used and free space
total_size=$(df -kh . | tail -n1 | awk '{print $2}')
available_size=$(df -kh . | tail -n1 | awk '{print $4}')

echo "Total size: $total_size"
echo "Available size: $available_size"

# info about total and free RAM
echo $(top -l 1 | grep PhysMem)

# number and frequency of CPU cores
echo "Number of CPU cores: $(nproc)"
echo "Frequency of CPU cores: $(grep 'cpu MHz' /proc/cpuinfo | head -1 | awk -F: '{print $2/1024}')"
