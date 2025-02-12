# Digital Forensics Module Scripts for evidence creation
Disclaimer: This project was created for educational purposes as part of a school assignment.<br/>It should not be used for any malicious or unethical activities.

## setup.sh
Install applications: awscli, udev & cron <br/>
Copies “suspicious.sh” from the USB drive to the victim’s machine <br/>
Schedule cronjob to run suspicious.sh

## suspicious.sh
Uploads exfiltrated_data.txt to MinIO Object Storage’s public bucket
