package Repositorios

import java.util.Iterator
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result

class RepositorioEscalasNeo4j extends AbstractRepoNeo4j {
	
	private static RepositorioEscalasNeo4j instance

	def static RepositorioEscalasNeo4j getInstance() {
		if (instance == null) {
			instance = new RepositorioEscalasNeo4j
		}
		instance
	}
	
	 def Node getNodoEscalaById(Long id) {
		basicSearch("ID(escala) = " + id).head
	}
	
	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (escala:Escala) where " + where + " return escala")
		val Iterator<Node> escala_column = result.columnAs("escala")
		return escala_column
	}
}