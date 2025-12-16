# RESOURCE GROUP

Resource groups are logical containers in Azure that hold related resources for an Azure solution. They serve as an organizational and management unit rather than a physical grouping.

## Key Characteristics:

### Logical Container
Groups resources that share the same lifecycle, like an application and its components (VM, database, storage, networking)

Resources can exist in only one resource group at a time

Resources can be in different physical regions than their resource group

### Management Boundary
Access Control: Apply Azure RBAC (Role-Based Access Control) permissions at the resource group level

Policies: Apply Azure Policy definitions to govern resources within the group

Tags: Apply metadata tags to all resources within the group for organization and billing

Deployments: Manage as a unit for deployment and deletion

### Lifecycle Management
Deploy, update, or delete all resources in the group together

Simplifies cleanup - deleting a resource group removes all contained resources

Group resources that should be managed together

## Common Use Cases:

Application grouping: Web app + database + storage account

Environment separation: Dev, Test, Prod environments in separate resource groups

Departmental organization: Resources owned by different teams/departments

Project-based grouping: All resources for a specific project


# Resource group administration using Azure CLI

### Prerequisites
1. Install Azure CLI if not already installed

2. Login to your Azure account:
az login


## Basic Resource Group Creation
### Create a simple resource group
az group create --name MyResourceGroup --location eastus

### Create with specific location/region
az group create --name MyResourceGroup --location "West Europe"

## Common Parameters & Options
### Add tags during creation

az group create \
  --name MyResourceGroup \
  --location eastus \
  --tags Environment=Dev Project=MyApp
  
### Create with managedBy (for managed applications)

az group create \
  --name MyManagedResourceGroup \
  --location eastus \
  --managed-by "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

## Verification & Management Commands

### List all resource groups
az group list

### List in table format
az group list --output table

### Show specific resource group details
az group show --name MyResourceGroup

### Update/Add tags to existing resource group
az group update --name MyResourceGroup --set tags.CostCenter=IT

## Delete a resource group (CAREFUL!)

### Show what will be deleted first
az group show --name MyResourceGroup

### Delete (this deletes ALL resources inside!)
az group delete --name MyResourceGroup

### Delete with confirmation prompt
az group delete --name MyResourceGroup --yes

### Delete without confirmation

az group delete --name MyResourceGroup --no-wait
