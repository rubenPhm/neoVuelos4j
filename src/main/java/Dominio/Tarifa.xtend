package Dominio

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.Date

@Observable
@Accessors
class Tarifa {
	
	float precio
	String tipo 

	new(float unValor){
		precio = unValor
	}
	
	def precioFinal(Date salidaVuelo, Date reservaAsiento) {
		precio
	}
	
}