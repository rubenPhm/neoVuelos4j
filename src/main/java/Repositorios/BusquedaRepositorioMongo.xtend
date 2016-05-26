package Repositorios

import Dominio.Busqueda
import Dominio.Usuario
import java.util.Date

class BusquedaRepositorioMongo extends RepositorioDefaultMongo<Busqueda>{
	
	override getEntityType() {
		typeof(Busqueda)
	}
	
	def createWhenNew(Busqueda busqueda) {
		//if (searchByExample(busqueda).isEmpty) {
			this.create(busqueda)
		//}
	}
	
	def buscarPor (Usuario usr,Date fechaDesde,Date fechaHasta){
		val query = ds.createQuery(entityType)
		//voy a tener que definir esto para las fechas desde y la fecha hasta
		if (fechaDesde != null) {
			query.field("fecha").greaterThanOrEq(fechaDesde)
		}
		if (fechaHasta != null) {
			query.field("fecha").lessThanOrEq(fechaHasta)
		}
		if (usr != null) {
			query.field("usuario").equal(usr.nick)
		}
		query.asList				
	}
	
	override searchByExample(Busqueda example) {
		val query = ds.createQuery(entityType)
		//voy a tener que definir esto para las fechas desde y la fecha hasta
		if (example.nickUsuario != null) {
			query.field("usuario").equal(example.nickUsuario)
		}
		query.asList
	}
	
	override defineUpdateOperations(Busqueda busqueda) {
		ds.createUpdateOperations(entityType)
			// las busquedas nunca se updatean, es por eso que no defino una forma de updatearlas por ahora.
			//.set("fechaDevolucion", prestamo.fechaDevolucion)
	}
	
}