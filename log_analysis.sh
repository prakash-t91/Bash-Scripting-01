#!/usr/bin/env bash
##############################
# Script Name: log_analysis.sh
# Description: This script analyses log files in the current directory for specific error patterns.
# Author: Prakash
# Date: 2024-06-10
# Version: 1.0
# Usage: ./log_analysis.sh
##############################

LOG_DIR="./"
LOG_FILE="*.log"
ALL_LOGS=$LOG_DIR/$LOG_FILE
ERROR_PATTERNS=("ERROR" "FATAL" "DEBUG" "TRACE")

set -e

# Script to analyse log files for specific error patterns
echo "Script Started at Date: $(date)"
echo "============================================="
echo "Analysing All Log Files"
echo "========================"
echo -e "\nList of Log Files Found in Last 24 Hours"
echo "============================================="
LOG_FILES=$(find $LOG_DIR -name "*.log" )
echo "$LOG_FILES"
echo "============================================="
for ALL_LOG in $ALL_LOGS; do
echo -e "\nNumber of ERROR logs found in $ALL_LOG"
grep -c "${ERROR_PATTERNS[0]}" "$ALL_LOG"

echo -e "\nNumber FATAL logs found in $ALL_LOG"
grep -c "${ERROR_PATTERNS[1]}" "$ALL_LOG"

echo -e "\nNumber DEBUG logs found in $ALL_LOG"
grep -c "${ERROR_PATTERNS[2]}" "$ALL_LOG"

echo -e "\nNumber TRACE logs found in $ALL_LOG"
grep -c "${ERROR_PATTERNS[3]}" "$ALL_LOG"
echo "================================================"
done

