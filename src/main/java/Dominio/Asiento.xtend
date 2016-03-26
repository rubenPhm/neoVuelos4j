package Dominio

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import AppModel.ReservaAsientoAppModel

@Accessors
@Observable	
class Asiento {
	
	int fila
	String ubicacion
	Date fechaDeReserva
	Usuario duenio = null
	Tarifa tarifa
	Vuelo vuelo
	
	
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
	
	def float precio(){
		tarifa.getPrecio
	}
	
}