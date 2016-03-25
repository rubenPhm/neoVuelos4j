package AppModel

import Dominio.Aeropuerto
import Dominio.Usuario
import Repositorios.AeropuertosRepositorio
import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import scala.Int

@Accessors
@Observable	
class BusquedaVueloAppModel {
	
	Aeropuerto origen
	Aeropuerto destino
	Date fechaDesde
	Date fechaHasta
	Int tarifaMax
	Aeropuerto vueloSeleccionado
	List <Aeropuerto> resultados
	Usuario usr	
	List <Aeropuerto> todosLosAeropuertos
	
	 
	new (Usuario unUsr){
		usr = unUsr
		todosLosAeropuertos = AeropuertosRepositorio.getInstance.todosLosAeropuertos
	}
	
}