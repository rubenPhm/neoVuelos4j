package Dominio

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.Date

@Observable
@Accessors
class Tarifa {
	
	float precio
	float descuento
	String tipo 

	new(float unValor){
		precio = unValor
	}
	
	new (float unValor, float otroValor){
		precio = unValor
		descuento = otroValor
	}
	
	def precioFinal(Date salidaVuelo, Date reservaAsiento) {
		
	}
	
}