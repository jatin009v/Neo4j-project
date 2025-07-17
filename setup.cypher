// setup.cypher
// Clear existing data
MATCH (n) DETACH DELETE n;

// Create constraints for uniqueness
CREATE CONSTRAINT person_id IF NOT EXISTS FOR (p:Person) REQUIRE p.id IS UNIQUE;
CREATE CONSTRAINT location_id IF NOT EXISTS FOR (l:Location) REQUIRE l.id IS UNIQUE;
CREATE CONSTRAINT crime_id IF NOT EXISTS FOR (c:Crime) REQUIRE c.id IS UNIQUE;

// Create sample Persons
CREATE (p1:Person {id: 'p1', name: 'John Doe', alias: 'The Fox', age: 42, status: 'Wanted'})
CREATE (p2:Person {id: 'p2', name: 'Jane Smith', alias: 'Shadow', age: 35, status: 'Suspected'})
CREATE (p3:Person {id: 'p3', name: 'Mike Johnson', alias: 'Big Mike', age: 38, status: 'In Custody'})
CREATE (p4:Person {id: 'p4', name: 'Sarah Williams', alias: 'Silent Sarah', age: 29, status: 'Wanted'})
CREATE (p5:Person {id: 'p5', name: 'Robert Brown', alias: 'Bobby', age: 45, status: 'Cleared'})

// Create sample Locations
CREATE (l1:Location {id: 'l1', name: 'Central Bank', type: 'Bank', address: '123 Main St'})
CREATE (l2:Location {id: 'l2', name: 'Diamond District', type: 'Commercial', address: '456 Jewel Ave'})
CREATE (l3:Location {id: 'l3', name: 'Harbor Warehouse', type: 'Warehouse', address: '789 Dock St'})
CREATE (l4:Location {id: 'l4', name: 'Downtown Apartment', type: 'Residential', address: '101 City View'})

// Create sample Crimes
CREATE (c1:Crime {id: 'c1', type: 'Robbery', date: '2023-05-15', status: 'Open', description: 'Bank heist'})
CREATE (c2:Crime {id: 'c2', type: 'Burglary', date: '2023-06-20', status: 'Closed', description: 'Jewelry store break-in'})
CREATE (c3:Crime {id: 'c3', type: 'Smuggling', date: '2023-07-10', status: 'Open', description: 'Illegal goods shipment'})

// Create relationships
// KNOWS relationships
MATCH (p1:Person {id: 'p1'}), (p2:Person {id: 'p2'}) CREATE (p1)-[:KNOWS {since: '2020-01-15', relationship: 'Associate'}]->(p2)
MATCH (p1:Person {id: 'p1'}), (p3:Person {id: 'p3'}) CREATE (p1)-[:KNOWS {since: '2019-05-22', relationship: 'Partner'}]->(p3)
MATCH (p2:Person {id: 'p2'}), (p4:Person {id: 'p4'}) CREATE (p2)-[:KNOWS {since: '2021-03-10', relationship: 'Cousin'}]->(p4)
MATCH (p3:Person {id: 'p3'}), (p5:Person {id: 'p5'}) CREATE (p3)-[:KNOWS {since: '2018-11-05', relationship: 'Friend'}]->(p5)

// WAS_AT relationships
MATCH (p1:Person {id: 'p1'}), (l1:Location {id: 'l1'}) CREATE (p1)-[:WAS_AT {timestamp: '2023-05-15T14:30:00', duration: 30}]->(l1)
MATCH (p2:Person {id: 'p2'}), (l1:Location {id: 'l1'}) CREATE (p2)-[:WAS_AT {timestamp: '2023-05-15T14:25:00', duration: 45}]->(l1)
MATCH (p3:Person {id: 'p3'}), (l2:Location {id: 'l2'}) CREATE (p3)-[:WAS_AT {timestamp: '2023-06-20T23:15:00', duration: 120}]->(l2)
MATCH (p4:Person {id: 'p4'}), (l3:Location {id: 'l3'}) CREATE (p4)-[:WAS_AT {timestamp: '2023-07-10T03:45:00', duration: 90}]->(l3)

// INVOLVED_IN relationships
MATCH (p1:Person {id: 'p1'}), (c1:Crime {id: 'c1'}) CREATE (p1)-[:INVOLVED_IN {role: 'Mastermind', status: 'Wanted'}]->(c1)
MATCH (p2:Person {id: 'p2'}), (c1:Crime {id: 'c1'}) CREATE (p2)-[:INVOLVED_IN {role: 'Getaway Driver', status: 'Suspected'}]->(c1)
MATCH (p3:Person {id: 'p3'}), (c2:Crime {id: 'c2'}) CREATE (p3)-[:INVOLVED_IN {role: 'Lookout', status: 'In Custody'}]->(c2)
MATCH (p4:Person {id: 'p4'}), (c3:Crime {id: 'c3'}) CREATE (p4)-[:INVOLVED_IN {role: 'Smuggler', status: 'Wanted'}]->(c3)
MATCH (p1:Person {id: 'p1'}), (c3:Crime {id: 'c3'}) CREATE (p1)-[:INVOLVED_IN {role: 'Financier', status: 'Wanted'}]->(c3)
