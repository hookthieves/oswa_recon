#!/bin/bash

# Define green and gray colors
GREEN="\033[0;32m"
RESET="\033[0m"

echo "========================="
echo "OSWA Recon Scans"
echo "Designed By Cuong Nguyen"
echo "========================="


# Ask the user for an IP address
read -p "Enter the IP address: " IP

# Ask the user for the port number
read -p "Enter the port number (default is 80): " PORT

# If no port is provided, use 80 as the default
if [[ -z "$PORT" ]]; then
    PORT=80
fi

# Validate IP format using regex (optional, but helpful for basic checks)
if [[ ! $IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo -e "${GREEN}[i] Invalid IP address format. Please enter a valid IPv4 address.${RESET}"
    exit 1
fi

# Run Nmap scan and save the output to a file
echo -e "${GREEN}[i] Running Nmap scan for $IP on port $PORT...${RESET}"
nmap -sV -sC -p $PORT $IP -oN "nmap_${IP}_port_${PORT}.txt"

# Run Gobuster scans and save the outputs to respective files
echo -e "${GREEN}[i] Running Gobuster scan with big.txt on port $PORT...${RESET}"
gobuster dir -u http://$IP:$PORT -w /usr/share/wordlists/dirb/big.txt -o "gobuster_${IP}_port_${PORT}_big.txt"

echo -e "${GREEN}[i] Running Gobuster scan with raft-medium-files.txt on port $PORT...${RESET}"
gobuster dir -u http://$IP:$PORT -w /usr/share/seclists/Discovery/Web-Content/raft-medium-files.txt -o "gobuster_${IP}_port_${PORT}_raft_medium_files.txt"

echo -e "${GREEN}[i] Running Gobuster scan with directory-list-lowercase-2.3-medium.txt on port $PORT...${RESET}"

gobuster dir -u http://$IP:$PORT -w /usr/share/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-medium.txt -o "gobuster_${IP}_port_${PORT}_directory_list_lowercase_2_3_medium.txt"

# Output file information without green color
echo
echo "[i] Scans completed. Outputs saved as:"
echo "nmap_${IP}_port_${PORT}.txt"
echo "gobuster_${IP}_port_${PORT}_big.txt"
echo "gobuster_${IP}_port_${PORT}_raft_medium_files.txt"
echo "gobuster_${IP}_port_${PORT}_directory_list_lowercase_2_3_medium.txt"
