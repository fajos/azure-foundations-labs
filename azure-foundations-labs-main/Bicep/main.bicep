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
