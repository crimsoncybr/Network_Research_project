# Network Scanning and Anonymization Script

## Overview
This script facilitates network scanning and anonymization tasks on a Linux system. It automates the process of connecting via SSH to a target,
performing network scans using `nmap` and `whois`, and anonymizing the user's IP address using `nipe`.
The script provides a set of variables for the user to input, such as the target address for scanning and SSH connection details.

## Prerequisites
- This script should be run on a Linux system.
- Root privileges are required (`sudo`).
- Ensure that the following tools are installed:
    - `nmap`
    - `sshpass`
    - `geoip-bin`
    - `git`
    - `perl`

## Installation
1. Download or clone the script to your Linux system.
2. Ensure that the script has executable permissions using `chmod +x project Remote Control.sh`.
3. Execute the script with `sudo ./project Remote Control.sh`.

## Usage
- Run the script with root privileges (`sudo ./project Remote Control.sh`).
- Follow the on-screen instructions to:
    - Enter the target address for scanning.
    - View the results of the `nmap` and `whois` scans.
    - Anonymize your IP address using `nipe`.
    - Optionally, stop the anonymization service.

## Functionality
### Interface Unit (IU)
- Prompts the user to enter the target address for scanning.

### Remote SSH Connection (SSH)
- Connects to the target via SSH.
- Retrieves system uptime and remote server information using `sshpass` and `geoiplookup`.

### Network Scanning (NMAP)
- Runs an `nmap` scan on the target address.
- Saves the scan results to `~/Desktop/scanlog/nmapscan.log`.

### WHOIS Lookup (WHOIS)
- Performs a `whois` lookup on the target address.
- Saves the lookup results to `~/Desktop/scanlog/WHOISscan.log`.

### Anonymization and End Process (END)
- Anonymizes the user's IP address using `nipe`.
- Stops the anonymization service at the end of the script.

## Notes
- Ensure that the required tools (`nmap`, `sshpass`, `geoip-bin`, `git`, `perl`) are installed on your system before running the script.
- Running this script requires root privileges.
- It's recommended to review the script and understand its functionality before execution.
- Use caution and ensure compliance with legal and ethical guidelines when performing network scanning and anonymization tasks.

