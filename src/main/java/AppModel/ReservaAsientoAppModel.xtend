package AppModel

import Dominio.Asiento
import Dominio.Reserva
import Dominio.Usuario
import Dominio.Vuelo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class ReservaAsientoAppModel {

	Vuelo unVuelo
	Usuario unUsuario
	Asiento asientoSeleccionado
	String alertaReserva
	
	new(Usuario usr, Vuelo vuelo) {
		unUsuario = usr
		unVuelo = vuelo
	}

	def getAsientos() {
		unVuelo.asientos	
	}
	
	def asientosDeFila(int filaPedida) {
		asientos.filter[it.fila == filaPedida]
	}

	def reservarAsiento() {
		unUsuario.reservar(new Reserva(asientoSeleccionado))
		alertaReserva = "Se reservo con exito el asiento" + asientoSeleccionado.toString()
	}

	def cantidadAsientos() {
		asientos.size
	}

	@Dependencies("asientoSeleccionado")
	def getAsientoSeleccionadoPrecio() {
		if (asientoSeleccionado == null) {
			return "--"
		} else {
			return asientoSeleccionado.getPrecio().toString()
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
