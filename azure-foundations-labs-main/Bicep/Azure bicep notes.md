# Azure Bicep

## What is Bicep?
Azure Bicep is a Domain-Specific Language (DSL) for deploying Azure resources declaratively. It's a transparent abstraction over ARM templates with cleaner syntax.

### 📊 Bicep vs ARM Templates

| Feature	| Bicep	| ARM Templates |
|-----------|-------|--------------|
| **Syntax**	| Clean, simplified	| JSON verbose
| **Parameters**	| Type-safe, IntelliSense	| Limited validation
| **Reusability**	| Modules	| Linked templates
| **Readability**	| High	| Low
| **Lines of Code**	| ~50% fewer	| More verbose


## 🛠️ Core Concepts

### 1. Parameters
```
param storageAccountName string
param location string = resourceGroup().location
param sku string = 'Standard_LRS'
param tags object = {
  environment: 'dev'
  project: 'myapp'
}
```

### 2. Variables

```
var storageAccountProperties = {
  accessTier: 'Hot'
  supportsHttpsTrafficOnly: true
}
```

### 3. Resources
```
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: sku
  }
  properties: storageAccountProperties
}
```

### 4. Outputs
```
output storageId string = storageAccount.id
output primaryEndpoint string = storageAccount.properties.primaryEndpoints.blob
```

## 5. Modules (Key Feature!)
```
module storageModule './modules/storage.bicep' = {
  name: 'storageDeployment'
  params: {
    storageName: storageAccountName
    location: location
    sku: 'Premium_LRS'
  }
}
```

# Sample Template that deploys Storage account, App Service Plan and App Service App

```
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'storageaccount20251220'
  location: 'canadacentral'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'myAppServicePlan'
  location: 'canadacentral'
  sku: {
    name: 'S1'
    tier: 'Standard'
    capacity: 1
  }
}

resource appServiceApp 'Microsoft.Web/sites@2021-02-01' = {
  name: 'myAppServiceApp'
  location: 'canadacentral'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    
  }
  
}
```

### 1. Install Bicep (if not already installed)
```
az bicep install && az bicep upgrade
```

### 2. Login to your account 
```
az Login
```

### 3. Set your subscription if you have more than one
```
az account set --subscription {your subscription ID}
```

### 4. Set your resource group
```
az configure --defaults group="[resource group name]"
```

### 5. Deploy the Bicep file to Azure
```
az deployment group create --name main --template-file main.bicep
```

### 6. Verify the deployment

- Go to the Azure portal and make sure you're in the correct subscription

- On the left-side panel, select Resource groups.

- Select [resource group name].

- In Overview, you can see that one deployment succeeded (I have two because I have another deployment earlier. You might need to expand the Essentials area to see the deployment.

<img width="1462" height="388" alt="image" src="https://github.com/user-attachments/assets/ba28867a-a71b-47f9-a1de-c4a9e2001a5b" />





