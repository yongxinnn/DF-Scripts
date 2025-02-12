# Digital Forensics Module Scripts for evidence creation

## setup.sh
Install applications: awscli, udev & cron <br/>
Copies “suspicious.sh” from the USB drive to the victim’s machine <br/>
Schedule cronjob to run suspicious.sh

## suspicious.sh
Uploads exfiltrated_data.txt to MinIO Object Storage’s public bucket
