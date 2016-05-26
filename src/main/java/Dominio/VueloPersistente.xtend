package Dominio

import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id

@Entity
@Accessors
class VueloPersistente {
	

	String nombreOrigen
	String nombreDestino
	String fechaSalidaStr
	String fechaLlegadaStr
	int cantidadEscalas
	int cantidadDeAsientosLibres
	
	@Id ObjectId idMongo
	
	new(){}
	new(VueloPersistenteArena vuelo) {
		nombreDestino = vuelo.nombreDestino
		nombreOrigen = vuelo.nombreOrigen
		fechaSalidaStr = vuelo.fechaSalidaStr
		fechaLlegadaStr = vuelo.fechaLlegadaStr
		cantidadEscalas = vuelo.cantidadEscalas
		cantidadDeAsientosLibres = vuelo.cantidadDeAsientosLibres
	}
	
}