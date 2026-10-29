# 🚀 Azure Cosmos DB for NoSQL – Vector Search Lab

## 📖 Introduction
This lab demonstrates how to implement **vector search** in Azure Cosmos DB for NoSQL. You’ll learn how to:
- Create a Cosmos DB account and container with vector indexing.
- Generate embeddings for text data.
- Insert documents with embeddings.
- Run similarity search queries using the .NET SDK.
- Combine vector search with metadata filters.

---

## 🛠️ Prerequisites
- Azure subscription
- Azure Cosmos DB for NoSQL account
- [.NET 6+ SDK](https://dotnet.microsoft.com/download)
- Visual Studio or VS Code
- Basic knowledge of C# and Azure

---

## ⚙️ Setup
1. **Provision Cosmos DB**
   - Create a Cosmos DB for NoSQL account in the Azure portal.
   - Create a database named `VectorLab`.
   - Create a container named `Items` with partition key `/category`.

2. **Enable Vector Indexing**
   - In the container settings, define a vector index on the `embedding` field.

---

## 📂 Data Ingestion
- Use the provided `data/sample.json` file (FAQ dataset).
- Generate embeddings using Azure OpenAI or Hugging Face.
- Insert documents with embeddings into Cosmos DB using `Program.cs`.

---

## 🔍 Vector Search Queries
Examples:
- **Cosine similarity search**
```sql
SELECT TOP 3 c.id, c.text
FROM c
WHERE VectorDistance(c.embedding, @inputEmbedding) < 0.3
```

- **Hybrid search (vector + filter)**
```sql
SELECT TOP 5 c.id, c.text
FROM c
WHERE c.category = "faq"
AND VectorDistance(c.embedding, @inputEmbedding) < 0.4
```

---

## 💻 Hands-On Exercises
1. Insert new FAQ entries and run similarity search.
2. Combine vector search with category filters.
3. Measure RU consumption and discuss optimization.

---

## 📊 Architecture
![Architecture Diagram](https://github.com/mgabaloch/cosmosdb-vector-search-lab/blob/main/CosmosdbVectorSearchLab/diagrams/architecture.png)

---

## ✅ Expected Output
- Query results showing top‑K matches with similarity scores.
- Demonstration of hybrid search combining metadata + vector similarity.

---

## 📎 Resources
- [Azure Cosmos DB Documentation](https://learn.microsoft.com/azure/cosmos-db/)
- Vector Search Overview [(learn.microsoft.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Flearn.microsoft.com%2Fazure%2Fcosmos-db%2Fnosql%2Fvector-search-overview")
- Azure OpenAI Embeddings [(learn.microsoft.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Flearn.microsoft.com%2Fazure%2Fcognitive-services%2Fopenai%2F")

---