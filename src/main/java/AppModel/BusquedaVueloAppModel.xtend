package AppModel

import Dominio.Asiento
import Dominio.Busqueda
import Dominio.Usuario
import Dominio.Vuelo
import Repositorios.AeropuertosRepositorio
import Repositorios.VuelosRepositorio
import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable	
class BusquedaVueloAppModel {
	
	Usuario usr	
	List <String> todosLosAeropuertos
	
	String origen
	String destino
	Date fechaDesde
	Date fechaHasta
	String tarifaMax
		
	Vuelo vueloSeleccionado
	List <Vuelo> resultados = newArrayList
	List<Asiento> asientosDisponibles = newArrayList
	
	new (Usuario unUsr){
		usr = unUsr
		todosLosAeropuertos = AeropuertosRepositorio.getInstance.nombreDeTodosLosAeropuertos
	}
	
	def buscar() {
		var Busqueda busqueda = new Busqueda(origen, destino, fechaDesde, fechaHasta, tarifaMax,usr)
		resultados = VuelosRepositorio.getInstance.buscar(busqueda)
	}
	
	def separarAsientos() { 
	// la parte comentada de este metodo,debe ofrecer solamente los asientos con precio menor al buscado
							
//		if(tarifaMax != null){
//			val valor = Float.parseFloat(tarifaMax)
//			asientosDisponibles = vueloSeleccionado.asientosValorMaximo(valor)
//		}else { asientosDisponibles = vueloSeleccionado.asientos }
		asientosDisponibles = vueloSeleccionado.asientos
		
	}
}