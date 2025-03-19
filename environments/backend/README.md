<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>4.1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>4.1.0 |

## Modules◊◊◊◊

| Name | Source | Version |
|------|--------|---------|
| <a name="module_storage"></a> [storage](#module\_storage) | ../../modules/storage | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | <pre>{<br/>  "Cost-Center": "department it",<br/>  "Environment": "dev",<br/>  "Owner": "DevOps Team",<br/>  "Project": "developer"<br/>}</pre> | no |

## Outputs

No outputs.

````hcl
#sub
subscription_id = "xxxxxxxxxxxxxxxx"

#rg
name     = "rg-dev"
location = "eastus"

tags = {
  Project     = "developer"
  Owner       = "DevOps Team"
  Cost-Center = "department it"
  Environment = "dev"
}

#storage
    storage_account_name = "devstatefile123456"    # Storage account name
    container_name       = "dev-tfstate"           # Container name
    key                  = "dev.terraform.tfstate" # State file name for dev environment

````

# Terraform deploy backend

## Prerequisites

Before running Terraform, you need to generate Azure credentials and set them as environment variables.

### 1. Generate Azure Credentials

If you don't have a service principal, create one using the Azure CLI:

```bash
az ad sp create-for-rbac --name "TerraformCloudSP" --role="Contributor" --scopes="/subscriptions/YOUR_SUBSCRIPTION_ID"
```

This command will output:

```json
{
  "appId": "xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",  # This is the ARM_CLIENT_ID
  "displayName": "TerraformCloudSP",
  "password": "xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",  # This is the ARM_CLIENT_SECRET
  "tenant": "ed9f8e07-c324-4671-96a7-dbb4fe601de1"  # This is the ARM_TENANT_ID
}
```

### 2. Export the Required Environment Variables

Set these variables in your terminal before running Terraform:

```bash
export ARM_CLIENT_ID="xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
export ARM_CLIENT_SECRET="xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
export ARM_TENANT_ID="ed9f8e07-c324-4671-96a7-dbb4fe601de1"
export ARM_SUBSCRIPTION_ID="dcb704e1-b807-4206-b060-767cfffe8fff"
```

If using Terraform Cloud, navigate to **Settings > Environment Variables** and add these variables.

### 3. Deploy Using the Script

A deployment script has been created to simplify the Terraform process.

#### **Deploy Terraform Infrastructure**
Run the following script manually:

```bash
#!/bin/bash
set -e

# Login to Azure using Service Principal
az login --service-principal --username "$ARM_CLIENT_ID" --password "$ARM_CLIENT_SECRET" --tenant "$ARM_TENANT_ID"

# Initialize Terraform with backend configuration
terraform init 

# Plan Terraform deployment
terraform plan -var-file=dev.tfvars

# Apply Terraform deployment
terraform apply -auto-approve -var-file=dev.tfvars
```

Save this script as `deploy.sh`, make it executable, and run:

```bash
chmod +x deploy.sh
./deploy.sh
```

#### **Destroy Terraform Infrastructure**
To destroy resources manually, create a `destroy.sh` script:

```bash
#!/bin/bash
set -e

# Login to Azure using Service Principal
az login --service-principal --username "$ARM_CLIENT_ID" --password "$ARM_CLIENT_SECRET" --tenant "$ARM_TENANT_ID"

# Destroy Terraform resources
terraform destroy -auto-approve -var-file=dev.tfvars
```

Make it executable and run:

```bash
chmod +x destroy.sh
./destroy.sh
```
<!-- END_TF_DOCS -->