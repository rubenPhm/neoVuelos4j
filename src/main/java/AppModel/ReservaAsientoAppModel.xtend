package AppModel

import Dominio.Asiento
import Dominio.Vuelo
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import Dominio.Usuario

@Observable
@Accessors
class ReservaAsientoAppModel {
	
	Vuelo unVuelo
	Usuario unUsuario
	static List<Asiento> asientos = newArrayList
	Asiento asientoSeleccionado
	
	//public static int MAX_ASIENTO = 10

	new (Usuario usr, Vuelo vuelo, List<Asiento> asientosDisponibles){

      unUsuario = usr
      unVuelo = vuelo
      asientos = asientosDisponibles
	}
	
	def asientosDeFila(int filaPedida) {
		asientos.filter [ it.fila == filaPedida ]
	}
	
	def reservarAsiento (){
		asientoSeleccionado.reservarAsiento(unUsuario)
        unUsuario.actualizarReservas(asientoSeleccionado)
	}
	
	def static cantidadAsientos() {
		asientos.size
	}
	
}
