package AppModel

import Dominio.Asiento
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
	List <String> todosLosAeropuertos = new ArrayList<String>
	
	String origen
	String destino
	Date fechaDesde
	Date fechaHasta
	String tarifaMax
		
	Vuelo vueloSeleccionado
	Set <Vuelo> resultados = newHashSet
	Set<Asiento> asientosDisponibles = newHashSet
	
	new (Usuario unUsr){
		usr = unUsr
		todosLosAeropuertos.add("TODOS")
		todosLosAeropuertos.addAll(AeropuertosRepositorio.getInstance.nombreDeTodosLosAeropuertos)
	}
		
	def buscar() {
		var Busqueda busqueda = new Busqueda(origen, destino, fechaDesde, fechaHasta, tarifaMax,usr)
		resultados = VuelosRepositorio.getInstance.buscar(busqueda)
	}
	
	def separarAsientos() { 
		asientosDisponibles = vueloSeleccionado.asientos
		
	}
}