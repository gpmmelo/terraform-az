#!/bin/bash
set -e

# Ensure the user confirms destruction
read -p "Are you sure you want to destroy the infrastructure? (yes/no): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "Aborting destruction..."
    exit 1
fi

# Login to Azure using Service Principal
az login --service-principal --username "$ARM_CLIENT_ID" --password "$ARM_CLIENT_SECRET" --tenant "$ARM_TENANT_ID"

# Initialize Terraform with backend configuration
terraform init 

# Plan Terraform destruction
terraform plan -destroy -var-file=dev.tfvars

# Apply Terraform destruction
terraform destroy -auto-approve -var-file=dev.tfvars

