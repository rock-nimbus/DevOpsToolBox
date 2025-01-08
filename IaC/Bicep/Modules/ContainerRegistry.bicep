param skuName string = 'Basic'
param projectId string
param environment string
param location_short string
param uniqueId int
param tags object


// Azure Container Registry

resource ACR 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: '${projectId}${environment}${location_short}acr${uniqueId}'
  location: resourceGroup().location
  sku: {
    name: skuName
  }
  properties: {
    adminUserEnabled: false
  }
  tags: tags
}
