#!/bin/bash

# Check if a port number was provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <port_number>"
    exit 1
fi

port=$1

# Verify the port is a valid number
if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
    echo "Error: Invalid port number. Must be between 1 and 65535."
    exit 1
fi

# Check if tcpdump is available
if ! command -v tcpdump >/dev/null 2>&1; then
    echo "Error: tcpdump is required but not installed."
    echo "You can install it with: sudo apt install tcpdump"
    exit 1
fi

# Check if we have sufficient privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "Warning: This script might require root privileges to capture network traffic."
    echo "Trying to proceed, but packet count might be incomplete..."
fi

# Temporary file for tcpdump output
tempfile=$(mktemp)

# Start tcpdump in background
echo "Monitoring traffic on port $port for 3 seconds..."
timeout 3 tcpdump -i any "port $port" -w "$tempfile" >/dev/null 2>&1

# Count packets using tcpdump reading its own capture file
packet_count=$(tcpdump -r "$tempfile" 2>/dev/null | wc -l)
packet_count=$((packet_count - 1)) # Subtract the header line

# Clean up
rm -f "$tempfile"

echo "Packet count on port $port: $packet_count"
