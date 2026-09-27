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
