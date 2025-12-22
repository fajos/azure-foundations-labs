param location string = 'canadacentral'
param storageAccountName string = 'mystorage${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'myAppServicePlan${uniqueString(resourceGroup().id)}'
@allowed([
  'dev'
  'prod'
])
param environmentType string

var appServicePlanName = 'MyAppServicePlan'
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var servicePlanSkuName = (environmentType == 'prod') ? 'P1v3' : 'F1'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: servicePlanSkuName
    tier: 'Standard'
    capacity: 1
  }
}

resource appServiceApp 'Microsoft.Web/sites@2021-02-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    
  }
  
}
