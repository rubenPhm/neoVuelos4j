package Dominio

import java.util.Calendar
import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class TarifaBandaNegativa extends Tarifa {
	
	new(float unValor) {
		super(unValor)
	}
	
	override precioFinal(Date fechaReserva, Date fechaVuelo) {
		//20% si se reserva 72 horas antes o 10% en caso contrario
		if(fechaReserva <= sumarDiasFecha(fechaVuelo, -3)){
			precio * new Float (0.2)
		}else{precio * new Float (0.1)}
	}
	
	def Date sumarDiasFecha(Date unaFecha, int dias){
      var Calendar calendar = Calendar.getInstance()
      calendar.setTime(unaFecha)
      calendar.add(Calendar.DAY_OF_YEAR, dias)
      calendar.getTime()
	 }
	
}