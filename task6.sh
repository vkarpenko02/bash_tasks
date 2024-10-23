#!/bin/bash

outputfile="report.txt"
echo "==========" >> "$outputfile"

# Function to log messages
log_message() {
    echo "$1" >> "$outputfile"
}

# Function to get internal IP address
get_internal_ip() {
    local internal_ip
    internal_ip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
    log_message "Internal IP address: ${internal_ip:-'Not found'}"
}

# Function to get external IP address
get_external_ip() {
    local external_ip
    external_ip=$(curl -s ifconfig.me)
    log_message "External IP address: ${external_ip:-'Not reachable'}"
}

# Log current date and time
log_message "Current date and time: $(date)"

# Log current user
log_message "Current user: $USER"

# Get and log internal and external IP addresses
get_internal_ip
get_external_ip

# Log hostname
log_message "Hostname: $(hostname -s)"

# Log name and version of Linux distribution
log_message "Name and version of Linux distribution: $(lsb_release -d | awk -F'\t' '{print $2}' || echo 'Not available')"

# Log system uptime
uptime_info=$(uptime)
log_message "System Uptime: $(echo "$uptime_info" | awk -F, '{print $1}' | sed 's/^.*up //')"

# Log information about used and free space
read total_size available_size <<< "$(df -kh . | awk 'NR==2 {print $2, $4}')"
log_message "Total size: $total_size"
log_message "Available size: $available_size"

# Log information about total and free RAM
free_ram_info=$(free -h)
log_message "Memory Usage: $free_ram_info"

# Log number and frequency of CPU cores
num_cores=$(nproc)
cpu_freq=$(grep 'cpu MHz' /proc/cpuinfo | head -1 | awk -F: '{print $2/1024}')
log_message "Number of CPU cores: $num_cores"
log_message "Frequency of CPU cores: ${cpu_freq:-'Not available'} GHz"

# Completion message
log_message "System report generated in $outputfile"

echo "==========" >> "$outputfile"
echo -e "\n" >> "$outputfile"
