package Dominio

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class TarifaBandaNegativa extends Tarifa {
	
	new(float unValor) {
		super(unValor)
	}
	
	override precioFinal(Date salidaVuelo, Date reservaAsiento){
		//20% si se reserva 72 horas antes o 10% en caso contrario
	}
	
}