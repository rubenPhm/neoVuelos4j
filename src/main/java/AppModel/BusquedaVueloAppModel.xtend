package AppModel

import Dominio.Aeropuerto
import Dominio.Busqueda
import Dominio.Usuario
import Dominio.Vuelo
import Repositorios.AeropuertosRepositorio
import Repositorios.BusquedaRepositorioMongo
import Repositorios.RepoVuelosNeo4j
import java.util.ArrayList
import java.util.Date
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import Repositorios.RepoAeropuertoNeo4j

@Accessors
@Observable	
class BusquedaVueloAppModel {
	
	Usuario usr	
	List <Aeropuerto> todosLosAeropuertos = new ArrayList<Aeropuerto>
	
	Aeropuerto origen
	Aeropuerto destino
	Date fechaDesde
	Date fechaHasta
	Integer tarifaMax
	
	Vuelo vueloSeleccionado
	Set <Vuelo> resultados = null
	
	RepoVuelosNeo4j vuelosRepo = RepoVuelosNeo4j.instance
	RepoAeropuertoNeo4j repoAeropuertos = RepoAeropuertoNeo4j.instance
	
	
	//Hibernate	
	//VuelosRepositorio vuelosRepo = VuelosRepositorio.instance
	BusquedaRepositorioMongo repoBusqueda = BusquedaRepositorioMongo.instance
	
	new (Usuario unUsr){
		usr = unUsr
		todosLosAeropuertos = repoAeropuertos.allInstances
	}

	def buscar() {
		resultados = newHashSet
		var Double precioMaximo = null
		if(tarifaMax != null){precioMaximo = new Double(tarifaMax)} // para poder limpiar el campo
		var Busqueda busqueda = new Busqueda(origen, destino, fechaDesde, fechaHasta, precioMaximo ,usr)
		vuelosRepo.searchByBusqueda(busqueda)
		resultados = busqueda.resultados.toSet
		if(resultados.isEmpty){resultados = null} // para apagar boton en vista, TODO: arena tiene una mejor solucion
		
		repoBusqueda.createWhenNew(busqueda)
	}
	
	def clear(){
		origen = null
		destino = null
		fechaDesde = null
		fechaHasta = null
		tarifaMax = null
	}
}