#!/bin/bash
set -e

# Login to Azure using Service Principal
az login --service-principal --username "$ARM_CLIENT_ID" --password "$ARM_CLIENT_SECRET" --tenant "$ARM_TENANT_ID"

# Initialize Terraform with backend configuration
terraform init 

# Plan Terraform deployment
terraform plan -var-file=prod.tfvars

# Apply Terraform deployment
terraform apply -auto-approve -var-file=prod.tfvars

