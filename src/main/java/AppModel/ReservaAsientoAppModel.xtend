package AppModel

import Dominio.Asiento
import Dominio.Reserva
import Dominio.Usuario
import Dominio.Vuelo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable
import Repositorios.UsuarioRepositorio
import Repositorios.VuelosRepositorio

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
		if(asientoSeleccionado.disponible){
		  unUsuario.reservar(new Reserva(asientoSeleccionado))
		  alertaReserva = "Se reservo con exito el asiento" + asientoSeleccionado.toString()
		  UsuarioRepositorio.instance.update(unUsuario)
		  VuelosRepositorio.instance.update(unVuelo)
		}
	}

	def cantidadAsientos() {
		asientos.size
	}
	
	def filas(){
		asientos.map[fila].toSet.sort
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
