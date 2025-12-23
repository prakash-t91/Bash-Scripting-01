#!/usr/bin/env bash

# System Monitoring Script
TIMESTAMP=$(date +%Y-%m-%d_%H:%M:%S)   
# LOG_FILE="/var/log/mycustomlog/system_monitoring.log"
LOG_FILE="./system_monitoring.log"
# Redirect stdout and stderr to a log file
echo "System Monitoring Script Started..$(date) Writing Log..Please wait.."
exec >> "$LOG_FILE" 2>&1

echo "System Monitoring Script Started at $(date)"
#set -x # Enable debugging
set -e # Exit on error

# Check Cpu Usage    
THRESHOLD=80

while true; do

cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo "--------------------------------------------------"
echo "Current CPU Usage: $cpu_usage%"

if (( $(echo "$cpu_usage > $THRESHOLD" |bc -l) )); then
    echo "CPU usage is above $THRESHOLD%. Current usage: $cpu_usage%" | mail -s "CPU Alert" you@example.com
fi

echo "--------------------------------------------------"
# Check Memory Usage
memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
echo "Current Memory Usage: $memory_usage%"
if (( $(echo "$memory_usage > $THRESHOLD" |bc -l) )); then
    echo "Memory usage is above $THRESHOLD%. Current usage: $memory_usage%" | mail -s "Memory Alert"
fi
echo "---------------------------------------------------"
#Check Disk Usage
disk_usage=$(df -h / | tail -n 1 | awk '{print $5}' | sed 's/%//')

if [ "$disk_usage" -ge "$THRESHOLD" ]; then
    echo "Disk space is running low! Disk Usage: $disk_usage%"
    echo "Script Ended at $(date)"
    sleep 10 # Sleep for 5 seconds before next check
    echo "======================================================"
    exit 0
else
    echo "Current Disk Usage: $disk_usage%"
    echo "Disk space is within acceptable limits"
    echo "----------------------------------------------------"
    echo "Script Ended at $(date)"
    sleep 10 # Sleep for 5 seconds before next check
    echo "======================================================"
    exit 1
fi
done