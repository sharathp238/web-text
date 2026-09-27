Here is a comprehensive `README.md` file tailored specifically for your [`ansible`](https://github.com/sharathp238/web-text/tree/webtext/ansible?utm_source=gemini) directory:

```markdown
# Ansible Infrastructure Provisioning & Setup

This directory contains the Ansible playbooks and inventory configurations used to automatically set up, configure, and verify essential DevOps tooling on target Ubuntu environments (such as Azure Virtual Machines or local hosts).

---

## 📁 Directory Structure

```text
ansible/
├── inventory.ini                  # Inventory file defining host groups and SSH connection parameters
└── webtext-soft-requirements.yml  # Main playbook provisioning Docker, Task CLI, Doppler CLI, and dependencies

```

---

## 🛠 Provisioned Software Stack

The [`webtext-soft-requirements.yml`](https://github.com/sharathp238/web-text/blob/webtext/ansible/webtext-soft-requirements.yml?utm_source=gemini) playbook provisions and verifies the following tools on Ubuntu:

1. **System Dependencies & Repositories**: Configures GPG keyrings and official APT repositories for Docker and Doppler.
2. **Docker Engine & CLI**: Installs `docker-ce`, `docker-ce-cli`, `containerd.io`, `docker-buildx-plugin`, and `docker-compose-plugin`, ensuring the service is enabled and started.
3. **Task CLI**: Downloads and installs the official [Taskfile](https://taskfile.dev/?utm_source=gemini) binary into `/usr/local/bin`.
4. **Doppler CLI**: Installs the Doppler CLI for secure environment secret injection.
5. **Post-Deployment Summary**: Validates service availability and displays a formatted summary of all installed tool versions upon completion.

---

## 🚀 Usage Guide

### 1. Configure Host Details (`inventory.ini`)

Update [`inventory.ini`](https://github.com/sharathp238/web-text/blob/webtext/ansible/inventory.ini?utm_source=gemini) with your target machine's public IP address, SSH user, and key location:

```ini
[azure_vm]
azure-devops-vm ansible_host=<TARGET_VM_PUBLIC_IP> ansible_user=azureuser ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_python_interpreter=/usr/bin/python3

```

---

### 2. Run Playbook Locally

To execute the playbook from your terminal against the host defined in your inventory:

```bash
# Execute against the target host in inventory.ini
ansible-playbook -i ansible/inventory.ini ansible/webtext-soft-requirements.yml

```

To test or execute directly on `localhost`:

```bash
ansible-playbook -i "localhost," -c local ansible/webtext-soft-requirements.yml

```

---

### 3. Automated Execution in GitHub Actions

In automated CI/CD pipelines (e.g., `.github/workflows/terraform.yml`), Ansible runs non-interactively using secrets supplied by the GitHub repository:

```bash
# Example step generating a temporary SSH key and executing Ansible
echo "${{ secrets.VM_SSH_PRIVATE_KEY }}" > private_key.pem
chmod 600 private_key.pem

ansible-playbook -i "${{ secrets.VM_PUBLIC_IP }}," \
  -u azureuser \
  --private-key private_key.pem \
  ansible/webtext-soft-requirements.yml

rm -f private_key.pem

```

```

---

### How to add this to your repository:
1. In your GitHub browser window, navigate inside the [`ansible`](https://github.com/sharathp238/web-text/tree/webtext/ansible) folder.
2. Click **Add file > Create new file**.
3. Name the file **`README.md`**.
4. Paste the content above into the editor and click **Commit changes...**.

```
