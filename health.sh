#!/bin/bash

# Simple System Health Dashboard
# Author: Bart Podkowa
# Description: Shows basic system health metrics in a clean layout

# Colours
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RESET="\e[0m"

# CPU Usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')

# Memory Usage
mem_usage=$(free | grep Mem | awk '{printf "%.2f%", $3/$2 * 100}')

# Disk Usage
disk_usage=$(df -h / | awk 'NR==2 {print $5}')

# Uptime
uptime_now=$(uptime -p)

# IP Address
ip_addr=$(hostname -I | awk '{print $1}')

# Default Gateway
gateway=$(ip route | grep default | awk '{print $3}')

# Logged in users
users=$(who | awk '{print $1}' | sort | uniq | tr '\n' ' ')

# Top 5 processes by CPU
top_processes=$(ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6)

echo -e "${CYAN}=== System Health Dashboard ===${RESET}"
echo -e "${GREEN}CPU Usage:      ${RESET}${cpu_usage}"
echo -e "${GREEN}Memory Usage:   ${RESET}${mem_usage}"
echo -e "${GREEN}Disk Usage:     ${RESET}${disk_usage}"
echo -e "${GREEN}Uptime:         ${RESET}${uptime_now}"
echo -e "${GREEN}IP Address:     ${RESET}${ip_addr}"
echo -e "${GREEN}Gateway:        ${RESET}${gateway}"
echo -e "${GREEN}Logged in users:${RESET} ${users}"
echo
echo -e "${YELLOW}Top 5 Processes by CPU${RESET}"
echo "$top_processes"
