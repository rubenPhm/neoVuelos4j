package Repositorios

import Dominio.Tarifa
import Dominio.TarifaBandaNegativa
import Dominio.TarifaComun
import Dominio.TarifaEspecial
import java.util.Iterator
import java.util.List
import java.util.Set
import org.neo4j.graphdb.Label
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result

class RepoTarifasNeo4j extends AbstractRepoNeo4j {
	
	private static RepoTarifasNeo4j instance
	
	List<Tarifa> todasLasTarifas = newArrayList
	
	
	def static RepoTarifasNeo4j getInstance() {
		if (instance == null) {
			instance = new RepoTarifasNeo4j
		}
		instance
	}
	
	def Tarifa convertToTarifa(Node nodoTarifa){ 
		var Tarifa tarifa = null

// 		quiero mantener en memoria las tarifas para que sean unicas.
//		hay que ver bien el tema de mantener en memoria y en disco el mismo elemento
//		para que sean consistentes

//		val List<Tarifa> tarifasId = todasLasTarifas.filter[id == nodoTarifa.id ].toList
//		if (!tarifasId.empty){
//			tarifa = tarifasId.last
//		}else{
		
			val String tipo = nodoTarifa.getProperty("tipo") as String
			if (tipo.equals("comun")){
				tarifa = new TarifaComun(nodoTarifa.getProperty("valor") as Double)
			}
			if (tipo.equals("especial")){
				tarifa = new TarifaEspecial(nodoTarifa.getProperty("valor") as Double, nodoTarifa.getProperty("descuento") as Double)
			}
			if (tipo.equals("banda negativa")){
				tarifa = new TarifaBandaNegativa(nodoTarifa.getProperty("valor") as Double)
			}
			tarifa.id = nodoTarifa.id
			todasLasTarifas.add(tarifa)
//		}
		return tarifa
	}
	
	def void saveOrUpdateTarifa (Tarifa tarifa) {
		val transaction = graphDb.beginTx
		try {
			var Node nodoTarifa = null
			if (tarifa.id == null) {
				nodoTarifa = graphDb.createNode
				nodoTarifa.addLabel(labelTarifa)
			} else {
				nodoTarifa = getNodoTarifaById(tarifa.id)
			}
			actualizarTarifa(tarifa, nodoTarifa)
			transaction.success
			tarifa.id = nodoTarifa.id
		} finally {
			cerrarTransaccion(transaction)
		}
	}
	
	public def Node getNodoTarifaById(Long id) {
		basicSearch("ID(tarifa) = " + id).head
	}
	
	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (tarifa:Tarifa) where " + where   + " return tarifa")
		val Iterator<Node> tarifa_column = result.columnAs("tarifa")
		return tarifa_column
	}
	
	public def labelTarifa() {
		Label.label("Tarifa")
	}
	
	def actualizarTarifa(Tarifa tarifa, Node nodoTarifa){
		nodoTarifa => [
			setProperty("tipo", tarifa.tipo)
			setProperty("valor", tarifa.precio)
			if (tarifa.descuento != null){ setProperty("descuento", tarifa.descuento)}
		]
	}
	
	def searchByExample(Tarifa tarifa){ // no funciona para 2 tarifas del mismo precio y tipo (tarifa especial)
		val transaction = graphDb.beginTx
		var Set<Object> resultadosConsulta = newHashSet
		try {
			resultadosConsulta = basicSearch("tarifa.tipo = '"+ tarifa.tipo + "' and tarifa.valor = "+ tarifa.precio).toSet
		}catch(Exception e){
			resultadosConsulta = newHashSet
		}
		finally {
			cerrarTransaccion(transaction)
		}
		return resultadosConsulta
	}
}