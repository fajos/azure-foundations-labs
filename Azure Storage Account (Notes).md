# Azure Storage Accounts - Concise Notes

## What are Azure Storage Accounts?
**Storage accounts** are Azure resources that provide scalable, durable cloud storage for:

**Blobs:** Unstructured data (documents, images, videos)

**Files:** SMB/NFS file shares

**Queues:** Messaging between app components

**Tables:** NoSQL key-value storage

**Disks:** Managed disks for VMs

## Key Characteristics

## Types of Storage Accounts

| Type	| Best For	| Features |
|-------|-----------|----------|
| **Standard**	| General purpose	| Blobs, Files, Queues, Table |
| **Premium**	| High-performance	| Block blobs, File shares |
| **BlobStorage**	| Blob-only storage	| Cool/Hot access tiers |

## Access Tiers

**Hot:** Frequently accessed data

**Cool:** Infrequent access (30+ days)

**Archive:** Rare access (180+ days)

**Cold:** New tier between Cool/Archive

## Redundancy Options

**LRS (Local)** - 3 copies in one datacenter

**ZRS (Zone)** - Copies across availability zones

**GRS (Geo)** - Copies to secondary region

**GZRS (Geo-zone)** - Zone + geo-redundant

## Creating Storage Account via CLI

1. Prerequisites
```
az login  # Login to Azure
az account set --subscription "Your-Subscription-Name"
```
3. Create Basic Storage Account

<img width="1236" height="39" alt="image" src="https://github.com/user-attachments/assets/afc71bdd-1e55-4567-8ef5-823fd455e7ea" />
  
5. Create with Advanced Options
```
az storage account create \
  --name "mystorageaccount" \
  --resource-group "MyResourceGroup" \
  --location "westeurope" \
  --sku "Standard_GRS" \
  --kind "StorageV2" \
  --access-tier "Hot" \
  --https-only true \
  --min-tls-version "TLS1_2" \
  --allow-blob-public-access false \
  --tags "Environment=Prod" "Project=MyApp"
```
<img width="1905" height="119" alt="image" src="https://github.com/user-attachments/assets/9dd6017b-587d-4ac4-85dc-05d7d742b2f3" />

6. Create Premium File Share Account
```
az storage account create \
  --name "mypremiumfiles" \
  --resource-group "MyResourceGroup" \
  --location "eastus" \
  --sku "Premium_LRS" \
  --kind "FileStorage"
```
<img width="1898" height="126" alt="image" src="https://github.com/user-attachments/assets/bbc39795-ebc6-4f9a-b80f-be74a732b7b6" />

  
## Common Management Commands

### List Storage Accounts
```
az storage account list --resource-group "MyResourceGroup"
az storage account list --output table  # Table format
```
### Show Account Details
```
az storage account show \
  --name "mystorageaccount" \
  --resource-group "MyResourceGroup"
```
### Get Connection String
```
az storage account show-connection-string \
  --name "mystorageaccount" \
  --resource-group "MyResourceGroup"
```
### Regenerate Keys
```
az storage account keys renew \
  --account-name "mystorageaccount" \
  --resource-group "MyResourceGroup" \
  --key "primary"
```
### Update Storage Account
```
az storage account update \
  --name "mystorageaccount" \
  --resource-group "MyResourceGroup" \
  --access-tier "Cool" \
  --enable-large-file-share
```  
### Delete Storage Account
```
az storage account delete \
  --name "mystorageaccount" \
  --resource-group "MyResourceGroup" \
  --yes  # Skip confirmation
```
## Quick Reference Table
Component	CLI Parameter	Example Values
---
Name	--name	mystorage123
Resource Group	--resource-group	my-rg
Location	--location	eastus, westeurope
SKU/Tier	--sku	Standard_LRS, Premium_LRS
Kind	--kind	StorageV2, BlockBlobStorage
Access Tier	--access-tier	Hot, Cool, Archive
TLS Version	--min-tls-version	TLS1_0, TLS1_2

## Best Practices Summary

**Naming:** Global unique name (3-24 chars, lowercase)

**Security:** Enable HTTPS-only, disable public access by default

**Networking:** Use private endpoints for sensitive data

**Lifecycle:** Set access tiers based on usage patterns

**Monitoring:** Enable logging and metrics

## Quick Start Example

### Create resource group
```
az group create --name "Storage-RG" --location "eastus"
```
### Create storage account
```
az storage account create \
  --name "mystore$(date +%s)" \
  --resource-group "Storage-RG" \
  --location "eastus" \
  --sku "Standard_LRS" \
  --kind "StorageV2"
```
### Get connection string for apps
```
az storage account show-connection-string \
  --name "mystorageaccount" \
  --resource-group "Storage-RG" \
  --query "connectionString"
```

### **Note:** Always delete unused resources to avoid charges:
```
az group delete --name "Storage-RG" --yes --no-wait
```
