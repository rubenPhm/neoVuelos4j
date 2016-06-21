package Repositorios

import Dominio.Aeropuerto
import Dominio.Asiento
import Dominio.Busqueda
import Dominio.Escala
import Dominio.Tarifa
import Dominio.Vuelo
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Iterator
import org.neo4j.graphdb.Label
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result
import java.util.List

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
			val Vuelo este = it
			id = nodeVuelo.id
			aerolinea = nodeVuelo.getProperty("aerolinea") as String
			fechaSalida = new Date(nodeVuelo.getProperty("fechaSalida") as String)
			fechaLlegada = new Date(nodeVuelo.getProperty("fechaLlegada") as String)
			if (deep) {

				val rel_origen = nodeVuelo.getRelationships(RelacionVueloAeropuertoOrigen.AEROPUERTO_ORIGEN)
				origen = rel_origen.map [ rel |
					new Aeropuerto => [
						id = rel.id
						nombre = rel.getProperty("nombre") as String
						pais = rel.getProperty("pais") as String
					]
				].last

				val rel_destino = nodeVuelo.getRelationships(RelacionVueloAeropuertoDestino.AEROPUERTO_DESTINO)
				destino = rel_destino.map [ rel |
					new Aeropuerto => [
						id = rel.id
						nombre = rel.getProperty("nombre") as String
						pais = rel.getProperty("pais") as String
					]
				].last

				val rel_asientos = nodeVuelo.getRelationships(RelacionVueloAsiento.EN_VUELO)
				asientos = rel_asientos.map [ rel |
					new Asiento => [
						id = rel.id
						fila = rel.getProperty("fila") as Integer
						ubicacion = rel.getProperty("ubicacion") as String
						disponible = rel.getProperty("disponible") as Boolean
						vuelo = este
					//						tarifa = rel.getProperty("tarifa") as Tarifa
					]
				].toSet

				val rel_escala = nodeVuelo.getRelationships(RelacionVueloEscala.ESCALA_EN)
				escalas = rel_escala.map [ rel |
					new Escala => [
						id = rel.id
						destino = RepoAeropuertoNeo4j.instance.convertToAeropuerto(rel.endNode)
						horaLlegada = new Date(rel.getProperty("horaLlegada")as String)
						horaSalida = new Date(rel.getProperty("horaSalida") as String)
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
			setProperty("fechaSalida", vuelo.fechaSalida.toString)
			setProperty("fechaLlegada", vuelo.fechaLlegada.toString)
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
				if (escala.horaSalida != null) {
					rel_escala.setProperty("horaSalida", escala.horaSalida.toString)
				}
				if (escala.horaLlegada != null) {
					rel_escala.setProperty("horaLlegada", escala.horaLlegada.toString)
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

		var List <String> condiciones = newArrayList
		
		if(busqueda.origen != null){
			condiciones.add("ID(origen) = "+busqueda.origen.id)	
		}
		if(busqueda.destino != null){
			condiciones.add("ID(destino) = "+busqueda.destino.id)
		}
		//ver lo de las tarifas
//		if(busqueda.maxPrecio != null){
//			condiciones.add("")
//		}
		//ver como comparar las fechas al ser strings.
		if(busqueda.desdeFecha != null){
			//condiciones.add("")
		}
		if(busqueda.hastaFecha != null){
			//condiciones.add("")
		}
		
		var String query = ""
		var String where = ""
		if(busqueda.origen == null && busqueda.destino == null && busqueda.maxPrecio == null && busqueda.desdeFecha == null && busqueda.hastaFecha == null){
				query = "match (vuelo:Vuelo)-[:AEROPUERTO_ORIGEN]-(origen:Aeropuerto), (vuelo)-[:AEROPUERTO_DESTINO]-(destino:Aeropuerto) return vuelo"
		}else{
			for(var Integer i=0; i<condiciones.size; i++){
				
				if(i == 0){
					where = condiciones.get(i)
				}else{
					where = "and " + condiciones.get(i)
				}	

			}
			
			query = "match (vuelo:Vuelo)-[:AEROPUERTO_ORIGEN]-(origen:Aeropuerto), (vuelo)-[:AEROPUERTO_DESTINO]-(destino:Aeropuerto) where"+where+" return vuelo"
		}
		
		val Result result = graphDb.execute(query)

		val Iterator<Node> vuelos_column = result.columnAs("vuelo")
		vuelos_column.forEach[vuelo|busqueda.resultados.add(convertToVuelo(vuelo, true))]
	}

}
