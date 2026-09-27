---

```markdown
# Azure Infrastructure with Terraform

This directory contains the Terraform configurations for provisioning and managing an Azure Linux Virtual Machine using SSH key-based authentication, along with its associated networking infrastructure (Virtual Network, Subnet, and Network Interface).

## 📁 Files Overview

* **`main.tf`**: Core resource declarations (Resource Group, VNet, Subnet, NIC, and Linux VM with SSH key access).
* **`variables.tf`**: Input variable definitions (location, VM size, SSH public key path/value, tags).
* **`outputs.tf`**: Output values generated after deployment (e.g., VM Public IP address, admin username, SSH command).
* **`terraform.tfvars`**: Local environment-specific variable assignments (ignored in version control).

---

## 🛠 Prerequisites

Before starting, ensure you have the following installed and configured on your machine:

1. **[Terraform CLI](https://developer.hashicorp.com/terraform/downloads)** (v1.0 or higher)
2. **[Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)**
3. An active **Azure Subscription** with permissions to create resources.
4. An **SSH Key Pair** (`~/.ssh/id_rsa.pub` or custom SSH key path) generated on your local machine.

---

## 🔑 Generating an SSH Key Pair (If Needed)

If you do not already have an SSH key on your machine, generate one by running:

```bash
ssh-keygen -t rsa -b 4096 -C "azurevm-key" -f ~/.ssh/id_rsa -N ""

```

This creates:

* **Private Key**: `~/.ssh/id_rsa` (Keep private, used to connect to the VM)
* **Public Key**: `~/.ssh/id_rsa.pub` (Provided to Azure via Terraform)

---

## ⚙️ Required Changes for Local Execution

When running Terraform locally instead of via GitHub Actions, make the following configuration adjustments:

1. **Authentication Method**:
* GitHub Actions uses Service Principal environment variables (`ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_TENANT_ID`, `ARM_SUBSCRIPTION_ID`).
* For local development, authenticate directly via Azure CLI (`az login`). This avoids embedding credential secrets in local files.


2. **Configure `terraform.tfvars` with SSH Key**:
Create a `terraform.tfvars` file inside the `terraform/` directory to pass local parameters and your SSH public key string:
```hcl
subscription_id     = "00000000-0000-0000-0000-000000000000"
resource_group_name = "rg-webtext-dev"
location            = "East US"
admin_username      = "azureuser"

# Pass your SSH public key string directly:
ssh_public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD..."

```


*Alternatively, if your `variables.tf` reads the public key from a file path using `file("~/.ssh/id_rsa.pub")`, ensure the local file path points to your actual SSH public key.*
3. **Backend Configuration (Optional)**:
* If a remote backend (e.g., Azure Blob Storage) is configured in `main.tf` for CI/CD, ensure your user account has access to the storage account, or temporarily comment out the `backend "azurerm" {}` block to use local state (`terraform.tfstate`).



---

## 🚀 Detailed Steps for Local Execution

### Step 1: Authenticate with Azure

Open your terminal, navigate to the `terraform/` directory, and log in to Azure:

```bash
cd terraform
az login

```

If you have multiple Azure subscriptions, set your active subscription explicitly:

```bash
az account set --subscription "<YOUR_SUBSCRIPTION_ID>"

```

Verify your active account details:

```bash
az account show

```

---

### Step 2: Initialize Terraform

Initialize the working directory to download the required Azure provider (`azurerm`) plugins:

```bash
terraform init

```

---

### Step 3: Validate and Format Configurations

Ensure your configuration files are syntactically valid and formatted:

```bash
# Check formatting compliance
terraform fmt -check

# Validate configuration syntax
terraform validate

```

---

### Step 4: Preview the Execution Plan

Generate and inspect the execution plan:

```bash
terraform plan

```

Optionally save the plan file:

```bash
terraform plan -out=tfplan

```

---

### Step 5: Provision Infrastructure

Apply the configuration to deploy the Virtual Machine to Azure:

```bash
terraform apply

```

If you saved a plan file in Step 4, apply it directly:

```bash
terraform apply tfplan

```

Otherwise, review the proposed resources and type `yes` when prompted.

---

### Step 6: Connect to the Virtual Machine via SSH

After deployment completes, obtain the VM's public IP address from the output and connect using your SSH private key:

```bash
# Get the Public IP from Terraform outputs
terraform output public_ip_address

# SSH into the VM
ssh -i ~/.ssh/id_rsa azureuser@<VM_PUBLIC_IP>

```

---

### Step 7: Clean Up / Destroy Infrastructure

To delete all resources and stop incurring costs on Azure:

```bash
terraform destroy

```

Review the resource removal plan and type `yes` to confirm.

```

```







configured with github actions


Here is a README.md file tailored for your webtext branch in the web-text repository:

# Azure VM Deployment with Terraform and GitHub Actions

This repository contains Terraform configurations and a GitHub Actions CI/CD pipeline to automatically provision and manage an Azure Linux Virtual Machine.

---

## 🏗 Project Structure

```text
.
├── .github/
│   └── workflows/
│       └── Infra-CICD.yml    # GitHub Actions CI/CD pipeline
├── terraform/
│   ├── main.tf              # Main Terraform resources (VNet, Subnet, NIC, VM)
│   ├── variables.tf         # Input variable definitions
│   └── outputs.tf           # (Optional) Output values
└── README.md
🛠 Infrastructure Overview
The Terraform configuration provisions the following resources on Azure using the azurerm provider:

Resource Group: Hosts all deployment resources.
Virtual Network (VNet): 10.0.0.0/16 CIDR block.
Subnet: Subnet (10.0.2.0/24) for internal VM connectivity.
Network Interface (NIC): Dynamic private IP configuration.
Linux Virtual Machine: Canonical Ubuntu Server 22.04 LTS (Standard_DS1_v2 or configurable via variables).
⚙️ Prerequisites & Setup
1. Azure Service Principal
To allow GitHub Actions to provision resources on your Azure account, create a Service Principal with Contributor access:

az ad sp create-for-rbac \
  --name "github-actions-sp" \
  --role "Contributor" \
  --scopes "/subscriptions/<YOUR_SUBSCRIPTION_ID>" \
  --sdk-auth
2. GitHub Actions Secrets
In your repository settings (Settings > Secrets and variables > Actions), add the following repository secrets:

Secret Name	Description
ARM_CLIENT_ID	Azure Service Principal Application (Client) ID
ARM_CLIENT_SECRET	Azure Service Principal Password / Client Secret
ARM_SUBSCRIPTION_ID	Azure Subscription ID
ARM_TENANT_ID	Azure Directory (Tenant) ID
VM_ADMIN_PASSWORD	Password for the VM Linux admin account
CI/CD Pipeline (GitHub Actions)
The workflow defined in .github/workflows/Infra-CICD.yml runs automatically on push and pull_request to the webtext, test, and main branches, as well as manually via workflow_dispatch.

Pipeline Execution Steps:
Terraform Init: Initializes provider dependencies and working directory.
Terraform Format Check: Ensures code conforms to standard formatting rules (terraform fmt -check).
Terraform Plan: Generates an execution plan to preview infrastructure changes.
Terraform Apply: Applies changes (Runs automatically on main branch or when manually triggered with apply).
Terraform Destroy: Destroys provisioned infrastructure when selected via manual dispatch.
💻 Local Usage
To run this Terraform configuration locally:

# Navigate to the working directory
cd terraform

# Initialize Terraform
terraform init

# Preview execution plan
terraform plan

# Apply infrastructure changes
terraform apply

# Destroy resources when finished
terraform destroy

---

### How to update it in your repository:
1. Go to the [web-text/README.md](https://github.com/sharathp238/web-text/blob/webtext/README.md#web-text) file on the `webtext` branch.
2. Click the **✏️ (Edit file)** icon in the top right.
3. Replace the current text with the Markdown block above and commit changes directly to the `webtext` branch.
