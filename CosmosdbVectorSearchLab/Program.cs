using Microsoft.Azure.Cosmos;
using System;
using System.Threading.Tasks;

class Program
{
    private static readonly string endpointUri = "<COSMOS_ENDPOINT>";
    private static readonly string primaryKey = "<COSMOS_KEY>";
    private static CosmosClient cosmosClient;
    private static Database database;
    private static Container container;

    static async Task Main(string[] args)
    {
        cosmosClient = new CosmosClient(endpointUri, primaryKey);
        database = await cosmosClient.CreateDatabaseIfNotExistsAsync("VectorLab");
        container = await database.CreateContainerIfNotExistsAsync("Items", "/category");

        // Example vector search query
        var query = new QueryDefinition(
            "SELECT TOP 3 c.id, c.text, c.embedding " +
            "FROM c " +
            "WHERE VectorDistance(c.embedding, @inputEmbedding) < 0.3")
            .WithParameter("@inputEmbedding", new float[] { /* embedding values */ });

        using FeedIterator<dynamic> resultSet = container.GetItemQueryIterator<dynamic>(query);
        while (resultSet.HasMoreResults)
        {
            foreach (var item in await resultSet.ReadNextAsync())
            {
                Console.WriteLine(item);
            }
        }
    }
}