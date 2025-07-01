#!/bin/bash

[ $# -ne 1 ] && { echo "Usage: $0 <port>"; exit 1; }
port=$1

# Validate port
[[ ! "$port" =~ ^[0-9]+$ ]] && { echo "Invalid port number"; exit 1; }

# Network interfaces header
echo -e "\n\033[1mNETWORK INTERFACES\033[0m"
ip -brief a

# Traffic monitoring
echo -e "\n\033[1mMONITORING PORT $port FOR 5 SECONDS\033[0m"
count=$(timeout 5 tcpdump -i any -nn "port $port" 2>/dev/null | grep -c "IP ")

# Results
echo -e "\n\033[1mRESULT\033[0m"
if [ "$count" -gt 0 ]; then
    echo "Detected $count packets on port $port"
else
    echo "No packets detected on port $port"
    echo -e "\n\033[1mNOTE\033[0m: If expecting traffic:"
    echo "- Service may be containerized (check with 'docker ps')"
    echo "- Try monitoring specific interface:"
    echo "  sudo tcpdump -i lo -nn port $port -c 5"
fi
