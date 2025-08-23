#!/bin/bash

# Serverless Todo API Cleanup Script
set -e

echo "Serverless Todo API - Cleanup Script"
echo "===================================="

# Check if AWS CLI is configured
if ! aws sts get-caller-identity > /dev/null 2>&1; then
    echo "Error: AWS CLI is not configured. Please run 'aws configure' first."
    exit 1
fi

# Check if Terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "Error: Terraform is not installed. Please install Terraform first."
    exit 1
fi

# Navigate to terraform directory
cd terraform

echo "WARNING: This will destroy all infrastructure resources!"
echo "This action cannot be undone."
echo ""
echo "Do you want to proceed with the cleanup? (y/N)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Destroying infrastructure..."
    terraform destroy -auto-approve
    
    echo ""
    echo "Cleanup completed successfully!"
    echo "All resources have been destroyed."
else
    echo "Cleanup cancelled."
    exit 0
fi
