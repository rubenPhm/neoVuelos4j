package AppModel

import Dominio.Asiento
import Dominio.Usuario
import Dominio.Vuelo
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class ReservaAsientoAppModel {

	Vuelo unVuelo
	Usuario unUsuario
	static List<Asiento> asientos = newArrayList
	Asiento asientoSeleccionado
	String alertaReserva
	//public static int MAX_ASIENTO = 10
	new(Usuario usr, Vuelo vuelo, List<Asiento> asientosDisponibles) {

		unUsuario = usr
		unVuelo = vuelo
		asientos = asientosDisponibles
	}

	def asientosDeFila(int filaPedida) {
		asientos.filter[it.fila == filaPedida]
	}

	def reservarAsiento() {
		asientoSeleccionado.reservarAsiento(unUsuario)
		unUsuario.actualizarReservas(asientoSeleccionado)
		alertaReserva = "Se reservo con exito el asiento" + asientoSeleccionado.toString()
	}

	def static cantidadAsientos() {
		asientos.size
	}

	@Dependencies("asientoSeleccionado")
	def getAsientoSeleccionadoPrecio() {

		if (asientoSeleccionado == null) {
			return "--"
		} else {
			return asientoSeleccionado.precio.toString()
		}
	}

	@Dependencies("asientoSeleccionado")
	def getNombreAsientoSeleccionado() {
		if (asientoSeleccionado == null) {
			return "--"
		} else {
			return asientoSeleccionado.toString()
		}
	}

}
