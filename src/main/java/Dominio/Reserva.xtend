package Dominio

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors

@Observable
@Accessors
class Reserva {
	
	Asiento asiento
	
    Vuelo vuelo
    String fechaReserva  
    
	new(Asiento unAsiento){
		asiento = unAsiento
		vuelo = asiento.vuelo
	}
	
	def getTramos(){
		vuelo.cantidadEscalas
	}	
	
	def void liberarAsiento(){
		asiento.liberar
	}
	
	def getAsientoDescripcion() {
		asiento.toString
	}
	
	def getOrigen() {
		vuelo.nombreOrigen
	}
	
	def getDestino() {
		vuelo.nombreDestino
	}
	
	def getFechaSalida() {
		vuelo.fechaSalidaStr
	}
	
	def getFechaLlegada() {
		vuelo.fechaLlegadaStr
	}
}