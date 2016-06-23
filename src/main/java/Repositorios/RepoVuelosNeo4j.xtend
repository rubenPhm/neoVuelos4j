package Repositorios

import Dominio.Busqueda
import Dominio.Escala
import Dominio.Vuelo
import java.util.Date
import java.util.Iterator
import java.util.Set
import org.neo4j.graphdb.Label
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result

class RepoVuelosNeo4j extends AbstractRepoNeo4j {

	private static RepoVuelosNeo4j instance

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
		
		val RepoAeropuertoNeo4j repoAeropuertos = RepoAeropuertoNeo4j.instance
		val RepoAsientosNeo4j repoAsientos = RepoAsientosNeo4j.instance
		
		new Vuelo => [
			val Vuelo este = it
			id = nodeVuelo.id
			aerolinea = nodeVuelo.getProperty("aerolinea") as String
			fechaSalida = new Date (nodeVuelo.getProperty("fechaSalida")as Long)
			fechaLlegada = new Date(nodeVuelo.getProperty("fechaLlegada") as Long)
			if (deep) {

				val rel_origen = nodeVuelo.getRelationships(RelacionVueloAeropuertoOrigen.AEROPUERTO_ORIGEN)
				origen = rel_origen.map [repoAeropuertos.convertToAeropuerto(it.endNode)].last
				
				val rel_destino = nodeVuelo.getRelationships(RelacionVueloAeropuertoDestino.AEROPUERTO_DESTINO)
				destino = rel_destino.map[repoAeropuertos.convertToAeropuerto(it.endNode)].last
				
				
				val rel_asientos = nodeVuelo.getRelationships(RelacionVueloAsiento.EN_VUELO)
				asientos = rel_asientos.map [repoAsientos.convertToAsiento(it.startNode, false)].toSet // quiero zafar del loop infinito
				asientos.forEach[setVuelo(este)]

				val rel_escala = nodeVuelo.getRelationships(RelacionVueloEscala.ESCALA_EN)
				escalas = rel_escala.map [ rel |
					new Escala => [
						id = rel.id
						destino = repoAeropuertos.convertToAeropuerto(rel.endNode)
						horaLlegada = new Date(rel.getProperty("horaLlegada")as Long)
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

	def void saveOrUpdateVuelo(Vuelo vuelo) {

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

		val RepoAeropuertoNeo4j repoAeropuertos = RepoAeropuertoNeo4j.instance
		val RepoAsientosNeo4j repoAsientos = RepoAsientosNeo4j.instance

		nodeVuelo => [
			val este = it
			setProperty("aerolinea", vuelo.aerolinea)
			setProperty("fechaSalida", vuelo.fechaSalida.getTime)
			setProperty("fechaLlegada", vuelo.fechaLlegada.getTime)
			relationships.forEach[it.delete]
			val nodeOrigen = repoAeropuertos.getNodoAeropuertoById(vuelo.origen.id)
			createRelationshipTo(nodeOrigen, RelacionVueloAeropuertoOrigen.AEROPUERTO_ORIGEN)
			val nodeDestino = repoAeropuertos.getNodoAeropuertoById(vuelo.destino.id)
			createRelationshipTo(nodeDestino, RelacionVueloAeropuertoDestino.AEROPUERTO_DESTINO)
			vuelo.escalas.forEach [ escala |
				val nodoEscala = repoAeropuertos.getNodoAeropuertoById(escala.destino.id)
				var rel_escala = este.createRelationshipTo(nodoEscala, RelacionVueloEscala.ESCALA_EN)
				if (escala.id != null) {
					rel_escala.setProperty("id", escala.id)
				}

				if (escala.horaLlegada != null) {
					rel_escala.setProperty("horaLlegada", escala.horaLlegada.getTime)
				}
			]
			vuelo.asientos.forEach [ asiento |
				val Node nodoAsiento = repoAsientos.getNodoAsientoById(asiento.id)
				nodoAsiento.createRelationshipTo(este, RelacionVueloAsiento.EN_VUELO)
			]
		]
	}

	private def Label labelVuelo() {
		Label.label("Vuelo")
	}

	def searchByBusqueda(Busqueda busqueda) {
		var String query = "match (vuelo:Vuelo)-[:AEROPUERTO_ORIGEN]-(origen:Aeropuerto), (vuelo)-[:AEROPUERTO_DESTINO]-(destino:Aeropuerto) where 1=1"

		if (busqueda.origen != null) {
			query += " AND ID(origen) = " + busqueda.origen.id
		}
		if (busqueda.destino != null) {
			query += " AND ID(destino) = " + busqueda.destino.id
		}
		if(busqueda.desdeFecha != null){
			query += " AND (vuelo.fechaSalida >= " + busqueda.desdeFecha.getTime + ")"
		}
		if(busqueda.hastaFecha != null){
			query += " AND (vuelo.fechaLlegada <= " + busqueda.hastaFecha.getTime + ")"
		}
		
		val Result result = graphDb.execute(query + " return(vuelo);")
		val Iterator<Node> vuelos_column = result.columnAs("vuelo")
		vuelos_column.forEach[vuelo|busqueda.resultados.add(convertToVuelo(vuelo, true))]
		
	}
	
	def searchByExample(Vuelo vuelo){
		val transaction = graphDb.beginTx
		var Set<Object> resultadosConsulta = newHashSet
		try {
			resultadosConsulta = basicSearch("vuelo.aerolinea = '"+ vuelo.aerolinea + "'").toSet
		}catch(Exception e){
			resultadosConsulta = newHashSet
		}
		finally {
			cerrarTransaccion(transaction)
		}
		return resultadosConsulta
	}


	def update(Vuelo vuelo){
		saveOrUpdateVuelo(vuelo)
	}


}
