package AppModel

import Dominio.Aeropuerto
import Dominio.Busqueda
import Dominio.Usuario
import Dominio.Vuelo
import Repositorios.AeropuertosRepositorio
import Repositorios.VuelosRepositorio
import java.util.ArrayList
import java.util.Date
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable	
class BusquedaVueloAppModel {
	
	Usuario usr	
	List <Aeropuerto> todosLosAeropuertos = new ArrayList<Aeropuerto>
	
	Aeropuerto origen
	Aeropuerto destino
	Date fechaDesde
	Date fechaHasta
	float tarifaMax
		
	Vuelo vueloSeleccionado
	Set <Vuelo> resultados = newHashSet
	
	new (Usuario unUsr){
		usr = unUsr
//		todosLosAeropuertos.add("TODOS") TODO: Poder poner el campo null en el widget de arena
		todosLosAeropuertos = AeropuertosRepositorio.getInstance.allInstances
	}
		
	def buscar() {
		var Busqueda busqueda = new Busqueda(origen, destino, fechaDesde, fechaHasta, tarifaMax,usr)
		resultados = newHashSet(VuelosRepositorio.getInstance.searchByBusqueda(busqueda))
	}
}