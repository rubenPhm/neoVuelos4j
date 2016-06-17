package Repositorios

import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result
import java.util.Iterator
import Dominio.Asiento
import org.neo4j.graphdb.Label

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
	
	def void saveOrUpdateUsuario (Asiento asiento) {
		
		// falta validar el usuario para que no se repita
		 
		val transaction = graphDb.beginTx
		try {
			var Node nodoAsiento = null
			if (asiento.id == null) {
				nodoAsiento= graphDb.createNode
				nodoAsiento.addLabel(labelAsiento)
			} else {
				nodoAsiento = getNodoAsientoById(asiento.id)
			}
			actualizarAsiento(asiento, nodoAsiento)
			transaction.success
			asiento.id = nodoAsiento.id
		} finally {
			cerrarTransaccion(transaction)
		}
			
	}
	
	private def void actualizarAsiento(Asiento asiento, Node nodeAsiento) {
		nodeAsiento => [
			setProperty("fila", asiento.fila)
			setProperty("ubicacion", asiento.ubicacion)
			setProperty("disponible",asiento.disponible)
			// Borro las relaciones que tenga ese nodo
			
		]
	}
	
	private def Label labelAsiento() {
		Label.label("Asiento")
	}
}