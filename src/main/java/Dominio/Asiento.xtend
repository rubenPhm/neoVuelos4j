package Dominio

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.UserException

@Accessors
@Observable	
class Asiento {
	
	int fila
	String ubicacion
	Date fechaDeReserva
	Usuario duenio = null
	Tarifa tarifa
	Vuelo vuelo
	
	new(int fila, String ubicacion, Tarifa unaTarifa) {
		this.fila = fila
		this.ubicacion = ubicacion
		tarifa = unaTarifa
	}
	
	
	new(int fila, String ubicacion) {
		this.fila = fila
		this.ubicacion = ubicacion
	}
	
		override toString() {
		" " + fila + ubicacion.substring(0,1) + " "
	}
	
	def getDisponible() {
		duenio == null
	}
	
	def float getPrecio(){
		100
//		tarifa.precioFinal(vuelo.fechaSalida, fechaDeReserva)
	}
	
	def reservarAsiento(Usuario usuario) {
		if(duenio != null){
			throw new UserException ("Este asiento ya ha sido reservado.")
		}else{
					duenio = usuario
		usuario.asientosReservados.add(this)
		}
	}
	
}