package Repositorios

import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result
import java.util.Iterator

class RepoAsientosNeo4j extends AbstractRepoNeo4j {
	
	private static RepoAsientosNeo4j instance

	def static RepoAsientosNeo4j getInstance() {
		if (instance == null) {
			instance = new RepoAsientosNeo4j
		}
		instance
	}
	
	 def Node getNodoAsientoById(Long id) {
		basicSearch("ID(asiento) = " + id).head
	}
	
	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (asiento:Asiento) where " + where + " return asiento")
		val Iterator<Node> asiento_column = result.columnAs("asiento")
		return asiento_column
	}
}