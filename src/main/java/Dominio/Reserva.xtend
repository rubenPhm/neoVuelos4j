package Dominio

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors

@Observable
@Accessors
class Reserva {
	
	Asiento asiento
   
    Vuelo vuelo
    String origen
    String destino 
    String salida
    String llegada
    String tramos
    String asientoReservado 
    String fechaReserva  
    String asientoDescripcion 
	
	new(Asiento unAsiento){
		asiento = unAsiento
		asientoDescripcion = asiento.toString
		vuelo = asiento.vuelo
		asientoReservado = asiento.fila.toString
		//origen = vuelo.origen.nombre
		//destino = vuelo.destino.nombre
		//salida = vuelo.fechaSalidaStr
		//llegada = vuelo.fechaLlegadaStr
	}
}