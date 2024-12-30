#!/bin/bash

# Define green color
GREEN="\033[0;32m"
RESET="\033[0m"

# Display Banner
echo -e "${GREEN}----------------------------------"
echo -e "              OSWA Recon 1.0"
echo -e "Designed By Cuong Nguyen"
echo -e "----------------------------------${RESET}"
echo

# Ask the user for an IP address
read -p "Enter the IP address: " IP

# Validate IP format using regex (optional, but helpful for basic checks)
if [[ ! $IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo -e "${GREEN}Invalid IP address format. Please enter a valid IPv4 address.${RESET}"
    exit 1
fi

# Run Nmap scan and save the output to a file
echo -e "${GREEN}Running Nmap scan for $IP...${RESET}"
nmap -sV -sC $IP -oN "nmap_$IP.txt"

# Run Gobuster scans and save the outputs to respective files
echo -e "${GREEN}Running Gobuster scan with big.txt...${RESET}"
gobuster dir -u http://$IP:80 -w /usr/share/wordlists/dirb/big.txt -o "gobuster_${IP}_big.txt"

echo -e "${GREEN}Running Gobuster scan with raft-medium-files.txt...${RESET}"
gobuster dir -u http://$IP:80 -w /usr/share/seclists/Discovery/Web-Content/raft-medium-files.txt -o "gobuster_${IP}_raft_medium_files.txt"

echo -e "${GREEN}Running Gobuster scan with directory-list-lowercase-2.3-medium.txt...${RESET}"
gobuster dir -u http://$IP:80 -w /usr/share/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-medium.txt -o "gobuster_${IP}_directory_list_lowercase_2_3_medium.txt"

echo
echo -e "${GREEN}Scans completed. Outputs saved as:${RESET}"
echo -e "${GREEN}nmap_$IP.txt${RESET}"
echo -e "${GREEN}gobuster_${IP}_big.txt${RESET}"
echo -e "${GREEN}gobuster_${IP}_raft_medium_files.txt${RESET}"
echo -e "${GREEN}gobuster_${IP}_directory_list_lowercase_2_3_medium.txt${RESET}"
