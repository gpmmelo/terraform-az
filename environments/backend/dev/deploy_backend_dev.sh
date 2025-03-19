#!/bin/bash
set -e

# Login to Azure using Service Principal
az login --service-principal --username "$ARM_CLIENT_ID" --password "$ARM_CLIENT_SECRET" --tenant "$ARM_TENANT_ID"

# Initialize Terraform with the correct backend configuration
terraform init -backend-config=backend-dev.tfvars

# Plan Terraform deployment
terraform plan -var-file=dev.tfvars

# Apply Terraform deployment
terraform apply -auto-approve -var-file=dev.tfvars
