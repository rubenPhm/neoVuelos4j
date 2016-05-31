package Repositorios

import Dominio.Busqueda
import Dominio.Usuario
import java.util.Date

class BusquedaRepositorioMongo extends RepositorioDefaultMongo<Busqueda>{
	static BusquedaRepositorioMongo repositorio = null
	
	static public def BusquedaRepositorioMongo getInstance() {
		if (repositorio == null) {
			repositorio = new BusquedaRepositorioMongo()
		}
		repositorio
	}
	
	private new(){}
	
	override getEntityType() {
		typeof(Busqueda)
	}
	
	def createWhenNew(Busqueda busqueda) {
			this.create(busqueda)
	}
	
	def buscarPor (Usuario usr,Date fechaDesde,Date fechaHasta){
		val query = ds.createQuery(entityType)
		if (fechaDesde != null) {
			query.field("fecha").greaterThanOrEq(fechaDesde)
		}
		if (fechaHasta != null) {
			query.field("fecha").lessThanOrEq(fechaHasta)
		}
		if (usr != null) {
			query.field("quienBusca.nick").equal(usr.nick)
		}
		query.asList
	}
	
	override searchByExample(Busqueda example) {
		val query = ds.createQuery(entityType)
		//voy a tener que definir esto para las fechas desde y la fecha hasta
		if (example.quienBusca.nick != null) {
			query.field("quienBusca.nick").equal(example.quienBusca.nick)
		}
		query.asList
	}
	
	override defineUpdateOperations(Busqueda busqueda) {
		ds.createUpdateOperations(entityType)
			// las busquedas nunca se updatean, es por eso que no defino una forma de updatearlas por ahora.
	}
	
}