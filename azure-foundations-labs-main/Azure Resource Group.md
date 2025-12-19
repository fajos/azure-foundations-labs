# RESOURCE GROUP

Resource groups are logical containers in Azure that hold related resources for an Azure solution. They serve as an organizational and management unit rather than a physical grouping.

## Key Characteristics:

### Logical Container
- Groups resources that share the same lifecycle, like an application and its components (VM, database, storage, networking)

- Resources can exist in only one resource group at a time

- Resources can be in different physical regions than their resource group

### Management Boundary
- Access Control: Apply Azure RBAC (Role-Based Access Control) permissions at the resource group level

- Policies: Apply Azure Policy definitions to govern resources within the group

- Tags: Apply metadata tags to all resources within the group for organization and billing

- Deployments: Manage as a unit for deployment and deletion

### Lifecycle Management
- Deploy, update, or delete all resources in the group together

- Simplifies cleanup - deleting a resource group removes all contained resources

- Group resources that should be managed together

## Common Use Cases:

- Application grouping: Web app + database + storage account

- Environment separation: Dev, Test, Prod environments in separate resource groups

- Departmental organization: Resources owned by different teams/departments

- Project-based grouping: All resources for a specific project


# Resource group administration using Azure CLI

### Prerequisites
#### Install Azure CLI if not already installed

#### Login to your Azure account:
```
az login
```

## Basic Resource Group Creation
### Create a simple resource group
```
az group create --name MyResourceGroup --location eastus
```
<img width="635" height="187" alt="image" src="https://github.com/user-attachments/assets/a8a81a46-6c30-4e70-aea5-809249e52e74" />


### Create with specific location/region
```
az group create --name MyResourceGroup --location "West Europe"
```

## Common Parameters & Options
### Add tags during creation
```
az group create \
  --name MyResourceGroup \
  --location eastus \
  --tags Environment=Dev Project=MyApp
```
  
### Create with managedBy (for managed applications)
```
az group create \
  --name MyManagedResourceGroup \
  --location eastus \
  --managed-by "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

## Verification & Management Commands

### List all resource groups
```
az group list
```
<img width="660" height="381" alt="image" src="https://github.com/user-attachments/assets/c2f34b12-181b-465d-97f1-b1d850ea6fce" />


### List in table format
```
az group list --output table
```

### Show specific resource group details
```
az group show --name MyResourceGroup
```

### Update/Add tags to existing resource group
```
az group update --name MyResourceGroup --set tags.CostCenter=IT
```

## Delete a resource group (CAREFUL!)

### Show what will be deleted first
```
az group show --name MyResourceGroup
```

### Delete (this deletes ALL resources inside!)
```
az group delete --name MyResourceGroup
```
<img width="423" height="50" alt="image" src="https://github.com/user-attachments/assets/f1b8aa9a-8ea4-4aaf-8436-ae4acfc35187" />


### Delete with confirmation prompt
```
az group delete --name MyResourceGroup --yes
```

### Delete without confirmation
```
az group delete --name MyResourceGroup --no-wait
```


# Creating Resource Group Using Azure Portal

## Choose resource group name and location

<img width="869" height="418" alt="rg-1" src="https://github.com/user-attachments/assets/494fc15a-64de-4ded-b299-a42b97172537" />

## Add tags if necessary

<img width="750" height="342" alt="rg-2" src="https://github.com/user-attachments/assets/27a9af57-554a-42a6-836e-078bbbee3da9" />

## Review and create the resource group

<img width="472" height="379" alt="rg-3" src="https://github.com/user-attachments/assets/9d0b9b09-0568-4349-9aef-c69d9a41de69" />




