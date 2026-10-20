targetScope = 'resourceGroup'

// Parameters
param vnetName string = 'myVnet'
param vnetLocation string = resourceGroup().location
param vnetAddressPrefix string = '10.0.0.0/16'

param subnet1Name string = 'frontend'
param subnet1Prefix string = '10.0.1.0/24'
param subnet2Name string = 'backend'
param subnet2Prefix string = '10.0.2.0/24'

param nsg1Name string = 'frontend-nsg'
param nsg2Name string = 'backend-nsg'

// Resource: Virtual Network
resource vnet 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: vnetName
  location: vnetLocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnet1Name
        properties: {
          addressPrefix: subnet1Prefix
          networkSecurityGroup: {
            id: nsg1.id
          }
        }
      }
      {
        name: subnet2Name
        properties: {
          addressPrefix: subnet2Prefix
          networkSecurityGroup: {
            id: nsg2.id
          }
        }
      }
    ]
  }
}

// Resource: NSG for Subnet 1
resource nsg1 'Microsoft.Network/networkSecurityGroups@2022-07-01' = {
  name: nsg1Name
  location: vnetLocation
  properties: {
    securityRules: [
      {
        name: 'AllowHTTP'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

// Resource: NSG for Subnet 2
resource nsg2 'Microsoft.Network/networkSecurityGroups@2022-07-01' = {
  name: nsg2Name
  location: vnetLocation
  properties: {
    securityRules: [
      {
        name: 'AllowSQL'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '1433'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}
