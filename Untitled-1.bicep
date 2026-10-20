targetScope = 'resourceGroup'
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'storage-test-bicep'
  location: 'eastus'
  sku: { name: 'Standard_LRS' }
  kind: 'StorageV2'
}
