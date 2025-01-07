param projectId string
param environment string
param location_short string
param tags object


// Storage Account 

module StorageAccount './Modules/StorageAccount.bicep' = {
  name: 'StorageAccount'
  params: {
    projectId: projectId
    environment: environment
    location_short: location_short
    uniqueId: 01
    tags: tags
  }
}

module StorageAccount2 './Modules/StorageAccount.bicep' = {
  name: 'StorageAccount2'
  params: {
    projectId: projectId
    environment: environment
    location_short: location_short
    uniqueId: 02
    tags: tags
    accessTier: 'Cool'
  }
}


