# Terraform Azure Modules

This repository contains reusable Terraform modules for provisioning and managing resources on Microsoft Azure. These modules are designed to simplify infrastructure deployment and follow best practices for infrastructure as code (IaC).

## Table of Contents

1. [Overview](#overview)
2. [Modules](#modules)
3. [Usage](#usage)
4. [Requirements](#requirements)

---
## Pre-requisites

## Pre-requisites

Before using this repository, ensure you have the following tools installed:

### 1. Install Terraform

Terraform is required to manage and deploy infrastructure using the modules in this repository.

- **Installation Instructions**:
  - Download and install Terraform from the official [Terraform download page](https://www.terraform.io/downloads.html).
  - Verify installation:
    ```bash
    terraform --version
    ```

---

### 2. Install Azure CLI (az cli)

The Azure CLI is required for authentication and interacting with your Azure subscription.

- **Installation Instructions**:
  - Download and install Azure CLI from the official [Azure CLI installation guide](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
  - Verify installation:
    ```bash
    az --version
    ```
  - Authenticate with Azure:
    ```bash
    az login
    ```

---

### 3. Install `terraform-docs`

`terraform-docs` is used to generate documentation for the Terraform modules in this repository.

- **Installation Instructions**:
  - Follow the installation guide on the [terraform-docs website](https://terraform-docs.io/user-guide/installation/).
  - Update documentation:
    ```bash
    terraform-docs markdown table --output-file README.md --output-mode inject .
    ```

---
## Overview

This repository provides modular and reusable Terraform configurations for deploying Azure resources. Each module is designed to be flexible, scalable, and easy to integrate into your Terraform projects.

---

## Modules

The following modules are available in this repository:

1. **Resorce Group**: Deploys an Azure resorce group name, location and tags. 
2. **Virtual Network (VNet)**: Deploys an Azure Virtual Network with configurable subnets and network security groups.
3. **Storage Account**: Creates an Azure Storage Account with support for advanced configurations like blob containers, file shares, and access policies.
4. **Virtual Machine (VM)**: Deploys an Azure Virtual Machine with configurable size, OS, and networking.

For detailed documentation on each module, navigate to the respective module's directory.

---

## Usage

To use a module from this repository, add the following to your Terraform configuration:

```hcl
module "example_module" {
  source = "github.com/gpmmelo/terraform-az//modules/<module_name>"

  # Required variables
  resource_group_name = "my-resource-group"
  location            = "East US"

  # Optional variables
  tags = {
    environment = "dev"
  }
}