param location string
param appServiceAppName string = 'myAppServicePlan${uniqueString(resourceGroup().id)}'

@allowed([
  'dev'
  'prod'
])
param environmentType string

var appServicePlanName = 'MyAppServicePlan'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P1v3' : 'F1'

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

output appServiceAppHostName string = appServiceApp.properties.defaultHostName
