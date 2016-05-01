package Dominio

import java.util.Date
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Entity
@Accessors
@Observable

class TarifaComun extends Tarifa {
	
	new(){}
		
	new(float unValor) {
		super(unValor)
	}
	
	override precioFinal(Date salidaVuelo, Date reservaAsiento){
		return precio
	}
	
}