#!/bin/bash

# Script to create Lambda deployment package
set -e

echo "Creating Lambda deployment package..."

# Navigate to project root
cd "$(dirname "$0")/.."

# Create terraform directory if it doesn't exist
mkdir -p terraform

# Remove existing package if it exists
rm -f terraform/lambda_function.zip

# Create the ZIP file
echo "Zipping Lambda function..."
cd src/lambda
zip -r ../../terraform/lambda_function.zip . -x "*.pyc" "__pycache__/*" "*.DS_Store"

# Calculate SHA256 hash
cd ../../terraform
if command -v shasum > /dev/null 2>&1; then
    # macOS
    SHA256_HASH=$(shasum -a 256 lambda_function.zip | cut -d' ' -f1 | base64)
else
    # Linux
    SHA256_HASH=$(sha256sum lambda_function.zip | cut -d' ' -f1 | base64)
fi

echo "Lambda package created: terraform/lambda_function.zip"
echo "SHA256 Hash: $SHA256_HASH"
echo "Package size: $(du -h lambda_function.zip | cut -f1)"
