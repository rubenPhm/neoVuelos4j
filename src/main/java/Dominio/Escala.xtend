package Dominio

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Escala {
	
	Aeropuerto destino
	Date horaLlegada
	Date horaSalida
}