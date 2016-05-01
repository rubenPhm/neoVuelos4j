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
	float descuento

	@Column
	float precio

	new() {
	}

	new(float unValor) {
		precio = unValor
	}

	new(float unValor, float otroValor) {
		precio = unValor
		descuento = otroValor
	}

	def float precioFinal(Date salidaVuelo, Date reservaAsiento) {
		0
	}
}
