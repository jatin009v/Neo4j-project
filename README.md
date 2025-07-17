# 🕵️‍♂️ Crime Network Analyzer using Neo4j

A powerful and interactive graph-based application to explore and analyze crime networks using **Neo4j**. Designed for law enforcement and intelligence analysis, this tool allows users to visualize relationships between **People**, **Crimes**, and **Locations**, run predefined or custom queries, and uncover hidden patterns.

---

## 🚀 Why Neo4j?

Traditional SQL databases struggle with deep relationship-based queries. Here’s why **Neo4j** is the best fit for this project:

- **🔗 Native Relationship Handling**: Traversing connections like "who knows whom" is fast and efficient.
- **⚡ Performance with Deep Queries**: Complex multi-hop queries are drastically faster.
- **📐 Flexible Schema**: Add new properties and relationships without schema migrations.
- **🔎 Pattern Matching**: Cypher makes it intuitive to search for relationship patterns.
- **📊 Visualization Tools**: Instantly grasp complex networks with built-in graph visualizers.

---

## 🧠 Key Features

### 📌 Interactive Graph Visualization
- View and explore nodes (People, Locations, Crimes) and their relationships
- Hover to see properties, drag to rearrange

### 🔍 Predefined Analysis Queries
- Find all people involved in a specific crime
- Track movement history of suspects
- Identify co-conspirators and indirect links
- Discover hotspot locations with suspect activity

### 💡 Custom Query Interface
- Enter your own Cypher queries from the UI
- View structured results instantly

---

## 📂 Project Structure

Crime-Network-Analyzer/
│
├── app.py # Flask web app with Neo4j integration
├── setup.cypher # Graph schema and sample data
├── queries.cypher # Predefined analysis queries
├── requirements.txt # Python dependencies
├── .env # Neo4j credentials
└── README.md # Project documentation




---

## 🛠 How to Use This Application

### 1. 🧠 Set up Neo4j
- Download **Neo4j Desktop** or use **Neo4j Aura**
- Create a database and note the credentials

### 2. 🐍 Set up the Python Environment

```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt

3. ⚙️ Configure Environment Variables
Create a .env file in the project root:

ini
Copy
Edit
NEO4J_URI=bolt://localhost:7687
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=your_password
4. 📥 Load Sample Data
Open the Neo4j Browser

Paste and run the contents of setup.cypher

5. ▶️ Run the Application
bash
Copy
Edit
python app.py
Open http://localhost:5000 in your browser to access the dashboard

📊 Example Analysis Scenarios
Potential Suspects: Find indirect links to known criminals

Temporal Analysis: Track suspects’ locations around crime times

Network Centrality: Identify key players in the network

Sub-network Detection: Uncover isolated criminal groups

📜 Certification
✅ Certified in Neo4j from Graph Academy
Successfully completed the Neo4j Professional Certification, gaining practical skills in Cypher query language, graph modeling, and real-world graph analytics.

📧 Contact
Developer: Jatin Gupta

🏁 Conclusion
This Crime Network Analyzer showcases the power of graph databases for complex, real-world investigations. Whether you’re visualizing data or discovering criminal patterns, Neo4j makes it fast, flexible, and intuitive.
