package Repositorios

import Dominio.Busqueda
import Dominio.BusquedaNoArena
import Dominio.Usuario
import java.util.Date
import java.util.List

class BusquedaRepositorioMongo extends RepositorioDefaultMongo<BusquedaNoArena>{
	
	override getEntityType() {
		typeof(BusquedaNoArena)
	}
	
	def createWhenNew(Busqueda busqueda) {
		//if (searchByExample(busqueda).isEmpty) {
			
//			this.create(new BusquedaNoArena(busqueda))
			ds.save(new BusquedaNoArena(busqueda))
		//}
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
			query.field("usuario").equal(usr.nick)
		}
		val List <Busqueda> busquedasRealizadas = newArrayList
		query.asList.forEach[
			busquedasRealizadas.add(new Busqueda(it))
		]
		
		busquedasRealizadas
	}
	
	override searchByExample(BusquedaNoArena example) {
		val query = ds.createQuery(entityType)
		//voy a tener que definir esto para las fechas desde y la fecha hasta
		if (example.nickUsuario != null) {
			query.field("usuario").equal(example.nickUsuario)
		}
		query.asList
	}
	
	override defineUpdateOperations(BusquedaNoArena busqueda) {
		ds.createUpdateOperations(entityType)
			// las busquedas nunca se updatean, es por eso que no defino una forma de updatearlas por ahora.
	}
	
}