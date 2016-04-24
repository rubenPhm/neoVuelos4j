package Dominio

import java.util.Date
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
@Entity
abstract class TarifaEspecial extends Tarifa {
	
	new(){}
	
	new(float unValor) {
		super(unValor)
	}
	
	new (float unValor, float unDescuento){
		super (unValor, unDescuento)
	}
	
	override precioFinal(Date salidaVuelo, Date reservaAsiento){
		precio - descuento
	}
	
}