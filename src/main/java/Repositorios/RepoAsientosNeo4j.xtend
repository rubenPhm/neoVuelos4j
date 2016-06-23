package Repositorios

import Dominio.Asiento
import java.util.Iterator
import java.util.Set
import org.neo4j.graphdb.Label
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result

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
	
	def void saveOrUpdateAsiento (Asiento asiento) {
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
		val RepoTarifasNeo4j repoTarifas = RepoTarifasNeo4j.instance
		nodeAsiento => [
			setProperty("fila", asiento.fila)
			setProperty("ubicacion", asiento.ubicacion)
			var String disponibilidad
			if(asiento.disponible){disponibilidad = "true"} else{disponibilidad = "false"}
			setProperty("disponible",disponibilidad)
			// me ocupo de las relaciones
			relationships.forEach [it.delete ]
			val Node nodoTarifa = repoTarifas.getNodoTarifaById(asiento.tarifa.id)
			createRelationshipTo(nodoTarifa, RelacionAsientoTarifa.CUESTA)
		]
	}
	
	private def Label labelAsiento() {
		Label.label("Asiento")
	}
	
	def Asiento convertToAsiento(Node nodoAsiento, boolean deep) {
		
		val RepoVuelosNeo4j repoVuelos = RepoVuelosNeo4j.instance
		val RepoTarifasNeo4j repoTarifas =  RepoTarifasNeo4j.instance
		var asiento = new Asiento
		asiento => [
			id = nodoAsiento.id
			ubicacion = nodoAsiento.getProperty("ubicacion") as String
			fila = nodoAsiento.getProperty("fila") as Integer
			val disponibilidad = nodoAsiento.getProperty("disponible") as String
			if (disponibilidad.equals("true")){	disponible = true} else{ disponible = false}
			val rel_tarifa = nodoAsiento.getRelationships(RelacionAsientoTarifa.CUESTA)
			tarifa = repoTarifas.convertToTarifa(rel_tarifa.last.endNode)
			
			if(deep){
				val rel_vuelo = nodoAsiento.getRelationships(RelacionVueloAsiento.EN_VUELO)
				vuelo = repoVuelos.convertToVuelo(rel_vuelo.last.endNode, true)

			}
		]
	}
	
	private def busquedaRelacionada(String whereAsiento, String whereVuelo) {
		val Result result = graphDb.execute("match (a:Asiento)-[EN_VUELO]->(v:Vuelo) where " + whereAsiento + " and "+ whereVuelo + " return a")
		val Iterator<Node> asiento_column = result.columnAs("a")
		return asiento_column
	}
	
	def searchByExample(Asiento asiento){
		val transaction = graphDb.beginTx
		var Set<Object> resultadosConsulta = newHashSet
		try {
			resultadosConsulta = busquedaRelacionada("a.fila = "+ asiento.fila + " and a.ubicacion = '"+ asiento.ubicacion + "'", "v.aerolinea = '" + asiento.vuelo.aerolinea + "'" ).toSet
		}catch(Exception e){resultadosConsulta = newHashSet	}
		finally {
			cerrarTransaccion(transaction)
		}
		return resultadosConsulta
	}
}