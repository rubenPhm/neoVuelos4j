package Dominio

import java.util.Date
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
@Entity
@Inheritance(strategy=InheritanceType.JOINED)
abstract class Tarifa {

	@Id
	@GeneratedValue
	private Long id

	@Column
	Double descuento

	@Column
	Double precio

	new() {
	}

	new(Double unValor) {
		precio = unValor
	}

	new(Double unValor, Double otroValor) {
		precio = unValor
		descuento = otroValor
	}

	def Double precioFinal(Date salidaVuelo, Date reservaAsiento) {
		0.0
	}
}
