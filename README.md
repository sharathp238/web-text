Here is a complete, clean **`README.md`** file tailored specifically for the root of your repository on the [`webtext`](https://github.com/sharathp238/web-text/tree/webtext?utm_source=gemini) branch:

```markdown
# Azure Infrastructure & DevOps Automation Pipeline

This repository contains the complete Infrastructure-as-Code (IaC) and Configuration Management workflow for provisioning an Azure Virtual Machine and deploying containerized services.

---

## 📁 Repository Structure

```text
.
├── .github/
│   └── workflows/
│       └── Infra-CICD.yml    # Main CI/CD pipeline for Terraform & Ansible
├── ansible/
│   ├── inventory.ini                  # Inventory template for target Azure VM
│   ├── webtext-soft-requirements.yml  # Playbook provisioning Docker, Task, and Doppler
│   └── README.md                      # Detailed Ansible documentation
├── project/
│   ├── app.js                         # Node.js application service
│   ├── Dockerfile                     # Multi-stage, rootless Docker container build
│   ├── Taskfile.yml                   # Task automation configuration
│   └── README.md                      # Detailed project documentation
├── terraform/
│   ├── main.tf                        # Azure infrastructure definitions
│   ├── variables.tf                   # Input variable definitions
│   ├── outputs.tf                     # Output definitions (e.g. public_ip_address)
│   └── README.md                      # Detailed Terraform documentation
└── README.md                          # Repository overview

```

---

## 🛠 Tech Stack & Services

* **Infrastructure Management**: [Terraform](https://www.terraform.io/?utm_source=gemini) (Azure Provider)
* **Configuration Management**: [Ansible](https://www.ansible.com/?utm_source=gemini)
* **Containerization**: [Docker Engine & Compose](https://www.docker.com/?utm_source=gemini)
* **Secret Management**: [Doppler CLI](https://www.doppler.com/?utm_source=gemini)
* **Task Runner**: [Task CLI](https://taskfile.dev/?utm_source=gemini)
* **CI/CD Pipeline**: GitHub Actions

---

## ⚙️ Prerequisites & GitHub Repository Secrets

To run the automated CI/CD pipeline, configure the following secrets in your repository under **Settings > Secrets and variables > Actions**:

| Secret Name | Description |
| --- | --- |
| `ARM_CLIENT_ID` | Azure Service Principal Application (Client) ID |
| `ARM_CLIENT_SECRET` | Azure Service Principal Client Secret / Password |
| `ARM_SUBSCRIPTION_ID` | Azure Subscription ID |
| `ARM_TENANT_ID` | Azure Tenant / Directory ID |
| `VM_ADMIN_PASSWORD` | Admin password for the Azure Linux VM |
| `VM_SSH_PRIVATE_KEY` | Private SSH key matching the VM's authorized key |
| `VM_PUBLIC_IP` | Public IP address of the target Azure VM |
| `DOPPLER_TOKEN` | Doppler Service Token for fetching runtime application secrets |

---

## 🚀 CI/CD Pipeline Workflow

The primary pipeline ([`.github/workflows/Infra-CICD.yml`](https://github.com/sharathp238/web-text/tree/webtext/.github/workflows?utm_source=gemini)) handles infrastructure execution and provisioning:

1. **Terraform Validation & Planning**: Runs `init`, `fmt -check`, and `plan` on pull requests and pushes to `main` and `webtext`.
2. **Terraform Apply**: Provisions resources on Azure when changes are merged into `main` or triggered manually via `workflow_dispatch`.
3. **Ansible Provisioning**: Connects to the target Azure VM to install Docker, Task CLI, and Doppler CLI using `ansible-playbook`.
4. **Manual Workflows**:
* **Infrastructure Destruction**: Triggered via `workflow_dispatch` with the destroy flag enabled.
* **Doppler Deployment**: Executes `task deploywithdoppler` directly on demand.



```

---

### How to update it in your repository:
1. Go to the root [`README.md`](https://github.com/sharathp238/web-text/blob/webtext/README.md) file on your `webtext` branch.
2. Click the **✏️ (Edit file)** icon.
3. Replace the current text with the block above and commit your changes.

```
======================================================================================================================
'''''''''''''''''''''STEPS TO EXECUTE TERRAFORM AND ANSIBLE AFTER CLONING'''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
======================================================================================================================
To run both **Terraform** and **Ansible** locally from your workstation to manage and provision your Azure infrastructure, follow this detailed step-by-step guide.

---

## 📋 Prerequisites

Before starting, make sure you have the following tools installed on your local machine:

* **[Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli?utm_source=gemini)** (to authenticate with Azure)
* **[Terraform CLI](https://developer.hashicorp.com/terraform/downloads?utm_source=gemini)** (v1.7.0 or higher)
* **[Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html?utm_source=gemini)** (v2.10 or higher)
* **OpenSSH Client** (for SSH key generation and host connection)

---

## Step 1: Clone the Repository & Authenticate with Azure

1. **Clone the project repository** and switch to your working branch:
```bash
git clone https://github.com/sharathp238/web-text.git
cd web-text
git checkout webtext

```


2. **Log into your Azure account** using the Azure CLI:
```bash
az login

```


*If you have multiple subscriptions, set the target subscription:*
```bash
az account set --subscription "<YOUR_AZURE_SUBSCRIPTION_ID>"

```



---

## Step 2: Provision Infrastructure using Terraform

1. **Navigate to the Terraform directory:**
```bash
cd terraform

```


2. **Initialize Terraform:**
This downloads required provider plugins (such as `azurerm`).
```bash
terraform init

```


3. **Format and Validate Configurations:**
```bash
terraform fmt
terraform validate

```


4. **Preview the Execution Plan:**
Supply your required environment variables or variable inputs (e.g., `admin_password`):
```bash
terraform plan -var="admin_password=YourSecurePassword123!"

```


5. **Apply the Changes to Create Resources:**
```bash
terraform plan -var="ssh_public_key=$(cat ~/.ssh/id_rsa.pub)"
terraform apply -var="ssh_public_key=$(cat ~/.ssh/id_rsa.pub)"

```


*Type `yes` when prompted to confirm.*
6. **Retrieve the VM Public IP Address Output:**
Once applied, copy the generated public IP from the output:
```bash
terraform output -raw public_ip_address

```



---

## Step 3: Configure Local SSH Access

Ensure your local SSH public key matches the key injected during the VM deployment, or verify you have the private SSH key corresponding to `azureuser`:

1. Set correct permissions on your local private key:
```bash
chmod 600 ~/.ssh/id_rsa

```


2. Test SSH connectivity to the deployed VM:
```bash
ssh -i ~/.ssh/id_rsa azureuser@<VM_PUBLIC_IP>

```



---

## Step 4: Provision VM Tooling using Ansible

1. **Navigate to the Ansible directory:**
```bash
cd ../ansible

```


2. **Update the `inventory.ini` file:**
Open [`inventory.ini`](https://github.com/sharathp238/web-text/blob/webtext/ansible/inventory.ini?utm_source=gemini) and replace `<TARGET_VM_PUBLIC_IP>` with the public IP address obtained from Terraform output:
```ini
[azure_vm]
azure-devops-vm ansible_host=<VM_PUBLIC_IP> ansible_user=azureuser ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_python_interpreter=/usr/bin/python3

```


3. **Verify Connectivity with Ansible Ping:**
```bash
ansible azure_vm -i inventory.ini -m ping

```


4. **Run the Playbook:**
Execute the playbook to install Docker, Task CLI, and Doppler CLI on the remote VM:
```bash
ansible-playbook -i inventory.ini webtext-soft-requirements.yml

```



---

## Step 5: (Optional) Cleanup Resources

When you are finished testing and want to destroy all provisioned Azure resources locally to avoid unexpected charges:

```bash
cd ../terraform
terraform destroy -var="ssh_public_key=$(cat ~/.ssh/id_rsa.pub)"

```
