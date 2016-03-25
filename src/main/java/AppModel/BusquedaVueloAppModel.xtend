package AppModel

import Dominio.Aeropuerto
import Dominio.Asiento
import Dominio.Busqueda
import Dominio.Usuario
import Dominio.Vuelo
import Repositorios.AeropuertosRepositorio
import java.util.Date
import java.util.List
import java.util.Map
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable	
class BusquedaVueloAppModel {
	
	String origen
	String destino
	Date fechaDesde
	Date fechaHasta
	int tarifaMax
	Aeropuerto vueloSeleccionado
	List <Vuelo> resultados
	Usuario usr	
	List <String> todosLosAeropuertos
	Map <Vuelo, List<Asiento> > asientosPorVuelo
	
	 
	new (Usuario unUsr){
		usr = unUsr
		todosLosAeropuertos = AeropuertosRepositorio.getInstance.nombreDeTodosLosAeropuertos
	}
	
	def buscar() {
		var vuelo = new Vuelo()
		vuelo.origen = origen
		vuelo.destino = destino
		vuelo.fechaLlegada = fechaHasta
		vuelo.fechaSalida = fechaDesde
		
		val busqueda = new Busqueda()
		busqueda.buscarVuelo(vuelo, usr)
		resultados = busqueda.resultados
		
		resultados.filter[ unVuelo | unVuelo.obtenerAsientosQueValganMenosQue(tarifaMax).size() > 0].toList
		
		for(Vuelo unVuelo: resultados){
			asientosPorVuelo.put(vuelo, vuelo.obtenerAsientosQueValganMenosQue(tarifaMax)) 
			
		}
		
	}
	
}