package Dominio

import java.util.Calendar
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Accessors
@Observable	
class Asiento {
	
	int fila
	String ubicacion
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
	
	def liberar(){
		duenio = null
	}
	
	
	def conPrecioMaximo(float valor){
		this.getPrecio <= valor
	}
	
	def float getPrecio(){
		tarifa.precioFinal(vuelo.fechaSalida, Calendar.getInstance.time)
	}
	
	def reservarAsiento(Usuario usuario) {
		if(duenio != null){
			throw new UserException ("Este asiento ya ha sido reservado.")
		} else {
				duenio = usuario
				usuario.reservar(new Reserva(this))
		}
	}
}