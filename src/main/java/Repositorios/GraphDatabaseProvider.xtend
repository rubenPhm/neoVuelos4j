package Repositorios

import org.neo4j.graphdb.GraphDatabaseService
import org.neo4j.graphdb.factory.GraphDatabaseFactory
import java.io.File
import org.uqbar.commons.model.UserException

class GraphDatabaseProvider {
	static GraphDatabaseProvider instance
	
	public GraphDatabaseService graphDb
	
	private new() {
		val GraphDatabaseFactory dbFactory = new GraphDatabaseFactory
		graphDb = dbFactory.newEmbeddedDatabase(new File("/Users/Barbani/Documents/Neo4j/default.graphdb"))
		//new File("/Users/ruben/Documents/Neo4j/default.graphdb")
		///home/ruben/apps/neo4j-community-3.0.1/data/databases/graph.db	
		//graphDb.shutdown
		//graphDb.execute("CREATE CONSTRAINT ON (u:Usuario) ASSERT u.nick IS UNIQUE")
   
}
	
	def static instance() {
		if (instance == null) {
			instance = new GraphDatabaseProvider		
		}
		instance
	}
}