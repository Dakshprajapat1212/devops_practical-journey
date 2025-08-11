# 🖥️ Server Performance Snapshot

A lightweight Bash script to quickly check your server's health. It pulls together CPU, memory, disk usage, and top processes, plus some extra goodies like uptime and OS version.

## 🔧 What It Shows

- CPU usage (from `top`)
- Memory usage (from `free`)
- Disk usage (from `df`)
- Top 5 processes by CPU and memory
- OS version
- Uptime and load average
- Logged-in users
- Failed login attempts

## 🚀 How to Use

```bash
chmod +x server_stats.sh
./server_stats.sh
