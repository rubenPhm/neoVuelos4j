package Dominio

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors

@Observable
@Accessors
class Reserva {
	
	Asiento asiento
	
    Vuelo vuelo
    String fechaReserva  
    String asientoDescripcion 
    
    String origen
	String destino
	String fechaSalida
	String fechaLlegada
	
	
	new(Asiento unAsiento){
		asiento = unAsiento
		asientoDescripcion = asiento.toString
		vuelo = asiento.vuelo
		
		origen = vuelo.nombreOrigen
		destino = vuelo.nombreDestino
		fechaSalida = vuelo.fechaSalidaStr
		fechaLlegada = vuelo.fechaLlegadaStr
	}
	
	def getTramos(){
		vuelo.cantidadEscalas
	}	
}