#!/bin/bash

# Serverless Todo API Deployment Script
set -e

echo "Serverless Todo API - Deployment Script"
echo "======================================="

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

echo "Initializing Terraform..."
terraform init

echo "Planning deployment..."
terraform plan

echo "Do you want to proceed with the deployment? (y/N)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Deploying infrastructure..."
    terraform apply -auto-approve
    
    echo ""
    echo "Deployment completed successfully!"
    echo ""
    echo "API Gateway URL:"
    terraform output -raw api_gateway_url
    echo ""
    echo "Available endpoints:"
    terraform output api_endpoints
    echo ""
    echo "To test the API, run:"
    echo "python ../scripts/test_api.py $(terraform output -raw api_gateway_url)"
else
    echo "Deployment cancelled."
    exit 0
fi
