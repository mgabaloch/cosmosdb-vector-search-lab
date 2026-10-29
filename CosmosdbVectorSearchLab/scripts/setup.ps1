# Variables - replace with your own values
$resourceGroup = "CosmosVectorLabRG"
$location = "eastus"
$accountName = "cosmosvectorlabacct"
$databaseName = "VectorLab"
$containerName = "Items"
$partitionKey = "/category"

# Login to Azure
az login

# Create Resource Group
az group create --name $resourceGroup --location $location

# Create Cosmos DB for NoSQL account
az cosmosdb create `
    --name $accountName `
    --resource-group $resourceGroup `
    --kind GlobalDocumentDB `
    --locations regionName=$location failoverPriority=0 isZoneRedundant=False

# Create Database
az cosmosdb sql database create `
    --account-name $accountName `
    --resource-group $resourceGroup `
    --name $databaseName

# Create Container with vector indexing enabled
az cosmosdb sql container create `
    --account-name $accountName `
    --resource-group $resourceGroup `
    --database-name $databaseName `
    --name $containerName `
    --partition-key-path $partitionKey `
    --idx @"
{
  "indexingMode": "consistent",
  "includedPaths": [
    {
      "path": "/*"
    }
  ],
  "vectorIndexes": [
    {
      "path": "/embedding",
      "type": "flat",
      "dimensions": 8,
      "metric": "cosine"
    }
  ]
}
"@
