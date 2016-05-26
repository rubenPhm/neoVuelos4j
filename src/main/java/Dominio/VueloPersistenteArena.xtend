package Dominio

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class VueloPersistenteArena {
	String nombreOrigen
	String nombreDestino
	String fechaSalidaStr
	String fechaLlegadaStr
	int cantidadEscalas
	int cantidadDeAsientosLibres
	
	new(){}
	new(VueloPersistente vuelo) {
		nombreDestino = vuelo.nombreDestino
		nombreOrigen = vuelo.nombreOrigen
		fechaSalidaStr = vuelo.fechaSalidaStr
		fechaLlegadaStr = vuelo.fechaLlegadaStr
		cantidadEscalas = vuelo.cantidadEscalas
		cantidadDeAsientosLibres = vuelo.cantidadDeAsientosLibres
	}
	new(Vuelo vuelo) {
		nombreDestino = vuelo.nombreDestino
		nombreOrigen = vuelo.nombreOrigen
		fechaSalidaStr = vuelo.fechaSalidaStr
		fechaLlegadaStr = vuelo.fechaLlegadaStr
		cantidadEscalas = vuelo.cantidadEscalas
		cantidadDeAsientosLibres = vuelo.cantidadDeAsientosLibres
	}
}