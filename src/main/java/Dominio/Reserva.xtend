package Dominio

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors

@Observable
@Accessors
class Reserva {
	
	Asiento asiento  
    Vuelo vuelo
    String tramos 
    String fechaReserva  
    String asientoDescripcion 
	
	new(Asiento unAsiento){
		asiento = unAsiento
		asientoDescripcion = asiento.toString
		
	}
}