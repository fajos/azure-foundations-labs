# Key Services Overview
- **VM (Virtual Machine):** An IaaS (Infrastructure-as-a-Service) offering. It provides a virtualized server in the cloud, giving you full control over the OS (Windows/Linux), software, and configurations. You are responsible for managing the server.

- **App Service:** A PaaS (Platform-as-a-Service) offering for hosting web applications, REST APIs, and mobile backends. Azure manages the underlying infrastructure (VMs, networking, OS patches). You simply deploy your code.

- **Containers:** A lightweight, portable method to package and run an application with its dependencies. Azure Container Instances (ACI) is for running single containers, while Azure Kubernetes Service (AKS) manages container orchestration at scale.

## 1. Why VMs are not always the answer
- **Manual Overhead:** Requires OS patching, security hardening, and middleware maintenance.

- **Inefficient Scaling:** Vertical scaling (resizing) requires downtime. Horizontal scaling (adding more VMs) is often manual or slow.

- **Cost:** You pay for the VM 24/7, even when idle.

- **Slower Deployment:** Compared to PaaS or containers, which abstract infrastructure for faster releases.

- **Management Burden:** You are responsible for the OS, runtime, and application—increasing operational load.

## 2. When App Service is the smarter choice
- **Ideal For:** Web apps, APIs, and mobile backends (HTTP-based workloads).

- **Fully Managed:** Azure handles OS, scaling, load balancing, and patching.

- **Rapid Scaling:** Built-in auto-scale based on metrics like CPU or request count.

- **DevOps Integration:** Supports continuous deployment from GitHub, Azure DevOps, etc.

- **Cost-Effective:** Pay only for the compute plan; no VM management costs.

- **Use When:** You want to focus solely on code for standard web workloads without managing servers.

## 3. How regions protect availability
- **Geographic Isolation:** Regions are separate data centers in different locations (e.g., East US, West Europe).

- **Fault Isolation:** A failure in one region (disaster, outage) does not affect others.

- **Data Residency:** Keep data within specific geographic boundaries for compliance.

- **Region Pairs:** Each region is paired with another for controlled platform updates and disaster recovery.

- **Strategy:** Deploy across regions for high availability (active/passive or active/active).

## 4. How you’d design for basic resilience
- **Multi-Region Deployment:** Deploy to at least two regions (primary + secondary).

- **Intelligent Traffic Routing:** Use Azure Front Door (modern) or Traffic Manager (DNS-based) for failover and load balancing.

- **Data Replication:** Use geo-redundant storage (GRS) and SQL geo-replication.

- **Stateless Design:** Store session state externally (e.g., Azure Cache for Redis) to enable seamless failover.

- **Health Monitoring:** Implement health probes to monitor endpoints and automate failover.

- **Backup & DR:** Maintain regular geo-redundant backups and a documented recovery plan.

# LABS
## 1. Create Linux VM using CLI
```
az vm create
  --resource-group MyResourceGroup
  --name MyLinuxVM
  --image Ubuntu2204
  --admin-username azureuser
  --admin-password "YourSecurePassword123!"
  --public-ip-sku Standard
  --size Standard_D2s_v3
```
<img width="1491" height="209" alt="image" src="https://github.com/user-attachments/assets/fd150c81-071c-4abc-8ea2-9acbefea34cd" />

### Resources created
<img width="1412" height="281" alt="image" src="https://github.com/user-attachments/assets/add3dd90-aab0-4d1a-b741-0f6e8cc9d639" />

### VM is running
<img width="1436" height="622" alt="image" src="https://github.com/user-attachments/assets/c971a73a-b367-4ddd-9ebd-a384bb90fece" />

## 2. Create Window VM using CLI
```
az vm create 
  --resource-group MyResourceGroup
  --name MyWindowsVM
  --image Win2022Datacenter
  --admin-username azureuser
  --admin-password "YourSecurePassword123!"
  --public-ip-sku Standard
  --size Standard_D2s_v3
```
<img width="1489" height="213" alt="image" src="https://github.com/user-attachments/assets/cdc08c8a-3569-4f3e-a637-7eb0bd388cee" />

### Resources Created
<img width="1350" height="261" alt="image" src="https://github.com/user-attachments/assets/860a6563-52ac-47db-8d3d-65b85de2507e" />

### VM is running
<img width="1428" height="617" alt="image" src="https://github.com/user-attachments/assets/47b2d2f7-6cee-40ff-8204-ff72fc776aa3" />

## 3. Stop a VM
```
az vm stop --resource-group azurelabs --name MyWindowsVM
```
<img width="642" height="50" alt="image" src="https://github.com/user-attachments/assets/344494b8-43ae-41bc-87ac-485fed5fdd99" />

## 4. Start a VM
```
az vm start --resource-group azurelabs --name MyWindowsVM
```
<img width="663" height="36" alt="image" src="https://github.com/user-attachments/assets/b7de6b6a-ad8b-4ff6-94b8-f144022d69f2" />

## 5. Restart a VM
```
az vm restart --resource-group azurelabs --name MyWindowsVM
```
<img width="663" height="41" alt="image" src="https://github.com/user-attachments/assets/503d2451-a2e8-4929-8570-494e4aa69a59" />

## 6. Get VM Details
```
# List all VMs
az vm list --output table

# Show specific VM details
az vm show --resource-group azurelabs --name MyLinuxVM --show-details

# Get public IP
az vm show --resource-group azurelabs --name MyLinuxVM --query publicIps -o tsv
```
## 7. View current VM size
```
az vm show --resource-group azurelabs  --name MyWindowsVM --query hardwareProfile.vmSize
```
<img width="875" height="35" alt="image" src="https://github.com/user-attachments/assets/34cedcb1-05dd-4a1c-99fe-2f36fd82f55c" />

## 8. Resize VM
```
# Stop VM first (required for resizing)
az vm deallocate --resource-group azurelabs --name MyWindowsVM

# Resize VM
az vm resize --resource-group azurelabs --name MyWindowsVM --size Standard_D2s_v3

# Start VM after resizing
az vm start --resource-group azurelabs --name MyWindowsVM
```
## Current size after resizing
<img width="922" height="37" alt="image" src="https://github.com/user-attachments/assets/9096e549-ec72-4cdf-a787-448260c51e05" />

## 9. Delete a VM
```
# Delete VM and all associated resources
az vm delete --resource-group azurelabs --name MyWindowsVM --yes
```
<img width="673" height="36" alt="image" src="https://github.com/user-attachments/assets/c195c2a4-d7eb-4012-82e6-93cc3cd821b4" />








