#!/usr/bin/env bash
# script to update the system packages
IP="google.com"
COUNT=4
TIMESTAMP=$(date +%Y-%m-%d_%H:%M:%S)   
# LOG_FILE="/var/log/mycustomlog/system_update.log"
LOG_FILE="./system_update.log"
# Redirect stdout and stderr to a log file
echo "Updating the System packages..."
echo "Script Started at $(date)"
echo "Writing Log...Please wait.."
exec >> "$LOG_FILE" 2>&1

echo "Script Started at $(date)"

#set -x 
#set -e

echo "Checking Network Connectivity.."
if ping -c $COUNT $IP > /dev/null 2>&1; then
    echo "Network Connectivity $IP was Successful."

    echo "System Update Script Started at $TIMESTAMP"
    sudo apt-get update -y

    echo "------------------------------------------"
    echo "System Full-Upgrade Started at $TIMESTAMP"
    sudo apt-get full-upgrade -y
    echo "------------------------------------------"
    echo "System Dist-Upgrade Started at $TIMESTAMP"
    sudo apt-get dist-upgrade -y
    echo "-------------------------------------------"
    echo "Clean up Unnecessary Packages at $TIMESTAMP"
    sudo apt-get autoremove -y
    echo "--------------------------------------------"
    echo "Clean up Cached Package files at $TIMESTAMP"
    sudo apt-get autoclean -y   
    echo "--------------------------------------------"
    # optional: upgrade to the latest distribution release
    echo "Distribution Upgrade Started at $TIMESTAMP"
    sudo do-release-upgrade -f DistUpgradeViewNonInteractive
    echo "--------------------------------------------"
    # system update and full-Upgrade completed
    echo "System Update and Full-Upgrade Completed..Done."
    echo "Script finished at $(date)" 
    echo "---------------------------------------------"
    #logger -s "log message" 2>> "$LOG_FILE"
    logger -s "log message" 2>> "$LOG_FILE"
    echo "============================================="
    exit 0
else
    echo "Network Connectivity $IP failed at $TIMESTAMP"
    echo "System Update and Full-Upgrade Failed at $TIMESTAMP"
    echo "Script finished at $(date)" 
    echo "---------------------------------------------"
    #logger -s "log message" 2>> "$LOG_FILE"
    logger -s "log message" 2>> "$LOG_FILE"
    echo "============================================="
    exit 1
fi


