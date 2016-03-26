	package Dominio

import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

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
	
	def conDestino(String destinoStr) {
		destino.nombre.equals(destinoStr)
	}
	
	def conOrigen(String origenStr){
		origen.nombre.equals(origenStr)
	}
	
	def contTarifaMenorA(float tarifa){
//		return ((asientos != null) && (0 < this.asientosValorMaximo(tarifa).length))
		true
	}
	
	def asientosValorMaximo (float tarifa){
		asientos.filter[precio() < tarifa].toList
	}
	
	def getNombreOrigen(){
		origen.nombre
	}
	
	def getNombreDestino(){
		destino.nombre
	}
}