package Dominio

import java.util.Date
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
@Entity

class TarifaEspecial extends Tarifa {
	
	new(){}
	
	new(Double unValor) {
		super(unValor)
	}
	
	new (Double unValor, Double unDescuento){
		super (unValor, unDescuento)
	}
	
	override precioFinal(Date salidaVuelo, Date reservaAsiento){
		precio - descuento
	}
	
}