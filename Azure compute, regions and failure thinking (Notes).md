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

