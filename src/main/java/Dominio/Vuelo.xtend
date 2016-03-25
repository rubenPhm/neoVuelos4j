package Dominio

import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import scala.Int

@Accessors
@Observable
class Vuelo {
	
	Aeropuerto origen
	Aeropuerto destino
	String aerolinea
	List <Asiento> asientos
	Date fechaSalida
	Date fechaLlegada
	List<Escala> escalas
	
	def getCantidadDeAsientosLibres(){
		asientos.filter[ asiento | asiento.duenio == null].toList.size()
	}
	
	def obtenerAsientosQueValganMenosQue(int precio) {
		asientos.filter[ asiento | asiento.tarifa.precio < precio].toList
	}
	
}