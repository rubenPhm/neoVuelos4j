package Repositorios

import Dominio.Aeropuerto
import java.util.Iterator
import org.neo4j.graphdb.Label
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result

class RepoAeropuertoNeo4j extends AbstractRepoNeo4j {
	
		private static RepoAeropuertoNeo4j instance

	def static RepoAeropuertoNeo4j getInstance() {
		if (instance == null) {
			instance = new RepoAeropuertoNeo4j
		}
		instance
	}
	
	 def Node getNodoAeropuertoById(Long id) {
		basicSearch("ID(aeropuerto) = " + id).head
	}
	
	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (aeropuerto:Aeropuerto) where " + where + " return aeropuerto")
		val Iterator<Node> aeropuerto_column = result.columnAs("aeropuerto")
		return aeropuerto_column
	}
	
	def void saveOrUpdateAeropuerto (Aeropuerto aeropuerto) {
		
		// falta validar el usuario para que no se repita
		 
		val transaction = graphDb.beginTx
		try {
			var Node nodoAeropuerto = null
			if (aeropuerto.id == null) {
				nodoAeropuerto= graphDb.createNode
				nodoAeropuerto.addLabel(labelAeropuerto)
			} else {
				nodoAeropuerto = getNodoAeropuertoById(aeropuerto.id)
			}
			actualizarAsiento(aeropuerto, nodoAeropuerto)
			transaction.success
			aeropuerto.id = nodoAeropuerto.id
		} finally {
			cerrarTransaccion(transaction)
		}
			
	}
	
	private def void actualizarAsiento(Aeropuerto aeropuerto, Node nodeAeropuerto) {
		nodeAeropuerto => [
			setProperty("nombre", aeropuerto.nombre)
			setProperty("pais", aeropuerto.pais)
			
		]
	}
	
	private def Label labelAeropuerto() {
		Label.label("Aeropuerto")
	}
	
}