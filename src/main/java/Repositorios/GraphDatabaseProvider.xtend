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
		graphDb = dbFactory.newEmbeddedDatabase(new File("/Users/Gabo/Documents/Neo4j/default.graphdb"))
}
	
	def static instance() {
		if (instance == null) {
			instance = new GraphDatabaseProvider		
		}
		instance
	}
}