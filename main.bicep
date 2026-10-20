targetScope = 'resourceGroup'

param vnetName string
param vnetLocation string
param vnetAddressPrefix string

param subnet1Name string
param subnet1Prefix string
param subnet2Name string
param subnet2Prefix string

param nsg1Name string
param nsg2Name string

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
