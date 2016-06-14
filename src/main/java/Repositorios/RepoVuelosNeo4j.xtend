package Repositorios

import Dominio.Aeropuerto
import Dominio.Asiento
import Dominio.Escala
import Dominio.Tarifa
import Dominio.Vuelo
import java.util.Date
import java.util.Iterator
import org.neo4j.graphdb.Label
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result

class RepoVuelosNeo4j extends AbstractRepoNeo4j {
	
	private static RepoVuelosNeo4j instance
	//public GraphDatabaseService graphDb
	
	def static RepoVuelosNeo4j getInstance() {
		if (instance == null) {
			instance = new RepoVuelosNeo4j
		}
		instance
	}
	
	def Vuelo getVuelo(Long id) {
		val transaction = graphDb.beginTx
		try {
			convertToVuelo(getNodoVuelo(id), true)
		} finally {
			cerrarTransaccion(transaction)
		}
	}
	
	def convertToVuelo(Node nodeVuelo, boolean deep) {
		new Vuelo => [
			idNeo = nodeVuelo.id
			origen = nodeVuelo.getProperty("origen") as Aeropuerto
			destino = nodeVuelo.getProperty("destino") as Aeropuerto
			aerolinea = nodeVuelo.getProperty("aerolinea") as String
			fechaSalida = nodeVuelo.getProperty("fechaSalida") as Date
			fechaLlegada = nodeVuelo.getProperty("fechaLlegada") as Date
			
			if (deep) { 
				val rel_asientos = nodeVuelo.getRelationships(RelacionVueloAsiento.ASIENTO_RESERVADO)
				asientos = rel_asientos.map [
					rel | new Asiento => [
						id = rel.id
						fila = rel.getProperty("fila") as Integer
						ubicacion = rel.getProperty("ubicacion") as String
						disponible = rel.getProperty("disponible") as Boolean
						vuelo = rel.getProperty("vuelo") as Vuelo
						tarifa = rel.getProperty("tarifa") as Tarifa
					]
				].toSet
				
				val rel_escala = nodeVuelo.getRelationships(RelacionVueloEscala.ESCALA_EN)
				escalas = rel_escala.map [
					rel | new Escala => [
						id = rel.id
						destino = rel.getProperty("destino") as Aeropuerto
						horaLlegada = rel.getProperty("horaLlegada") as Date
						horaSalida = rel.getProperty("horaSalida") as Date
					]
				].toSet
			}			
		]
	}
	
	def void eliminarVuelo(Vuelo vuelo) {
		val transaction = graphDb.beginTx
		try {
			getNodoVuelo(vuelo.id).delete
			transaction.success
		} finally {
			cerrarTransaccion(transaction)
		}
	}

	def void saveOrUpdateVuelo (Vuelo vuelo) {
		
		 
		val transaction = graphDb.beginTx
		try {
			var Node nodoVuelo = null
			if (vuelo.id == null) {
				nodoVuelo = graphDb.createNode
				nodoVuelo.addLabel(labelVuelo)
			} else {
				nodoVuelo = getNodoVuelo(vuelo.id)
			}
			actualizarVuelo(vuelo, nodoVuelo)
			transaction.success
			vuelo.id = nodoVuelo.id
		} finally {
			cerrarTransaccion(transaction)
		}
	}

	private def Node getNodoVuelo(Long id) {
		basicSearch("ID(vuelo) = " + id).head
	}
	
	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (vuelo:Vuelo) where " + where + " return vuelo")
		val Iterator<Node> user_column = result.columnAs("vuelo")
		return user_column
	}

	private def void actualizarVuelo(Vuelo vuelo, Node nodeVuelo) {
		nodeVuelo => [
			setProperty("origen", vuelo.origen)
			setProperty("destino", vuelo.destino)
			setProperty("aerolinea",vuelo.aerolinea)
			setProperty("fechaSalida",vuelo.fechaSalida)
			setProperty("fechaLlegada",vuelo.fechaLlegada)
						
			relationships.forEach [it.delete]
			
			vuelo.asientos.forEach [ asiento |
				val Node nodoAsiento = RepoAsientosNeo4j.instance.getNodoAsientoById(asiento.id)
				val relAsiento = nodoAsiento.createRelationshipTo(it, RelacionVueloAsiento.ASIENTO_RESERVADO)
				
			vuelo.escalas.forEach [ escala |
				val Node nodoEscala = RepositorioEscalasNeo4j.instance.getNodoEscalaById(escala.id)
				val relEscala = nodoEscala.createRelationshipTo(it, RelacionVueloEscala.ESCALA_EN)
				
				val asientos = vuelo.asientos		
				var String[] _asientos = #[]
				_asientos = asientos.toArray(_asientos)
				relAsiento.setProperty("asientos", _asientos)
				
				val escalas = vuelo.escalas		
				var String[] _escalas = #[]
				_escalas = escalas.toArray(_escalas)
				relEscala.setProperty("escalas", _escalas)
				]	
			]
		]
	}

	private def Label labelVuelo() {
		Label.label("Vuelo")
	}
	
	
	
}