-- queries.cypher
-- 1. Find all people involved in a specific crime
MATCH (p:Person)-[r:INVOLVED_IN]->(c:Crime {id: 'c1'})
RETURN p.name, r.role, r.status;

-- 2. Find all locations a person has been to
MATCH (p:Person {id: 'p1'})-[r:WAS_AT]->(l:Location)
RETURN p.name, l.name, r.timestamp, r.duration
ORDER BY r.timestamp DESC;

-- 3. Find connections between two people (up to 3 degrees of separation)
MATCH path = shortestPath((p1:Person {id: 'p1'})-[*..3]-(p2:Person {id: 'p5'}))
RETURN [n IN nodes(path) | 
  CASE WHEN n:Person THEN 'Person: ' + n.name 
       WHEN n:Location THEN 'Location: ' + n.name 
       ELSE 'Crime: ' + n.type 
  END] AS path;

-- 4. Find potential co-conspirators (people who know people involved in crimes)
MATCH (suspect:Person)-[:KNOWS]-(accomplice:Person)-[:INVOLVED_IN]->(crime:Crime)
WHERE NOT (suspect)-[:INVOLVED_IN]->(crime)
RETURN suspect.name AS potential_suspect, 
       collect(DISTINCT {name: accomplice.name, crime: crime.type}) AS connections_to_crimes;

-- 5. Find locations where multiple suspects were present around the same time
MATCH (p1:Person)-[r1:WAS_AT]->(l:Location)<-[r2:WAS_AT]-(p2:Person)
WHERE p1 <> p2 
  AND datetime(r1.timestamp) > datetime(r2.timestamp) - duration('PT1H')
  AND datetime(r1.timestamp) < datetime(r2.timestamp) + duration('PT1H')
RETURN l.name AS location, 
       p1.name AS person1, r1.timestamp AS time1,
       p2.name AS person2, r2.timestamp AS time2
ORDER BY l.name, r1.timestamp;
