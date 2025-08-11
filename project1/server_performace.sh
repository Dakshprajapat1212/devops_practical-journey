#!/bin/bash

# ============================================
# 🖥️ Server Performance Snapshot
# ============================================
# A quick script to check how your server's doing.
# Includes CPU, memory, disk usage, top processes,
# and a few bonus stats like uptime and OS version.
# ============================================

echo "===== Server Performance Stats ====="
echo "Timestamp: $(date)"
echo ""

# 🧠 CPU Usage
echo ">> CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{ print "Used: " $2 + $4 \"%\" }'
echo ""

# 🧠 Memory Usage
echo ">> Memory Usage:"
free -m | awk 'NR==2 { printf "Used: %sMB / %sMB (%.2f%%)\n", $3, $2, $3*100/$2 }'
echo ""

# 💾 Disk Usage
echo ">> Disk Usage:"
df -h --total | grep 'total' | awk '{ print "Used: " $3 " / " $2 " (" $5 ")" }'
echo ""

# 🔥 Top 5 CPU-hungry processes
echo ">> Top 5 Processes by CPU:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo ""

# 🔥 Top 5 Memory-hungry processes
echo ">> Top 5 Processes by Memory:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo ""

# 🌟 Bonus Stats

# OS Version
echo ">> OS Version:"
grep PRETTY_NAME /etc/os-release | cut -d= -f2
echo ""

# Uptime (pretty format)
echo ">> Uptime:"
uptime -p
echo ""

# Load Average
echo ">> Load Average:"
uptime | awk -F'load average:' '{ print $2 }'
echo ""

# Logged-in Users
echo ">> Logged In Users:"
who | wc -l
echo ""

# Failed Login Attempts
echo ">> Failed Login Attempts:"
lastb | wc -l
echo ""
