package Dominio

import java.util.Calendar
import java.util.Date
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
@Entity
class TarifaBandaNegativa extends Tarifa {
	
	new() {
	}

	new(Double unValor) {
		super(unValor)
	}

	override precioFinal(Date fechaReserva, Date fechaVuelo) {

		//20% si se reserva 72 horas antes o 10% en caso contrario
		if (fechaReserva <= sumarDiasFecha(fechaVuelo, -3)) {
			precio * 0.2
		} else {
			precio * 0.1
		}
	}

	def Date sumarDiasFecha(Date unaFecha, int dias) {
		var Calendar calendar = Calendar.getInstance()
		calendar.setTime(unaFecha)
		calendar.add(Calendar.DAY_OF_YEAR, dias)
		calendar.getTime()
	}

}
