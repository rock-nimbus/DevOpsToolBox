param projectId string
param environment string
param location_short string
param uniqueId int
param tags object
param accessTier string = 'Hot'
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
])
param skuName string = 'Standard_LRS'


resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: '${projectId}${environment}${location_short}sa${uniqueId}'
  location: resourceGroup().location
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: accessTier
  }
  tags: tags
}
