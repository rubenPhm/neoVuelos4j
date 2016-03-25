package Dominio

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable	
class Asiento {
	
	int fila
	String ubicacion
	Date fechaDeReserva
	Usuario duenio
	Tarifa tarifa
	Vuelo vuelo
	
	
}