from flask import Flask, render_template, jsonify, request
from neo4j import GraphDatabase
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

# Neo4j connection
URI = os.getenv("NEO4J_URI", "bolt://localhost:7687")
AUTH = (
    os.getenv("NEO4J_USERNAME", "neo4j"),
    os.getenv("NEO4J_PASSWORD", "password")
)

def get_db():
    return GraphDatabase.driver(URI, auth=AUTH)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/graph', methods=['GET'])
def get_graph():
    limit = request.args.get('limit', 50)
    query = """
    MATCH (n)-[r]->(m)
    RETURN n, r, m
    LIMIT $limit
    """
    
    with get_db().session() as session:
        result = session.run(query, limit=int(limit))
        nodes = set()
        links = []
        
        for record in result:
            source = record['n']
            target = record['m']
            rel = record['r']
            
            nodes.add((source.id, source.labels, dict(source)))
            nodes.add((target.id, target.labels, dict(target)))
            links.append({
                'source': source.id,
                'target': target.id,
                'type': type(rel).__name__,
                'properties': dict(rel)
            })
            
    return jsonify({
        'nodes': [{'id': n[0], 'labels': list(n[1]), 'properties': n[2]} for n in nodes],
        'links': links
    })

@app.route('/api/query', methods=['POST'])
def run_query():
    data = request.json
    query = data.get('query', '')
    params = data.get('params', {})
    
    try:
        with get_db().session() as session:
            result = session.run(query, **params)
            return jsonify({
                'success': True,
                'records': [dict(record) for record in result]
            })
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 400

if __name__ == '__main__':
    app.run(debug=True)
