param projectId string
param environment string
param location_short string
param tags object


// Azure Container Registry

module ACR './Modules/ContainerRegistry.bicep' = {
  name: 'ACR'
  params: {
    projectId: projectId
    environment: environment
    location_short: location_short
    tags: tags
    uniqueId: 1
    skuName: 'Basic'
  }
}


