package Dominio

import java.util.Date
import javax.persistence.Column
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.annotations.Entity
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
@Entity
@Inheritance(strategy=InheritanceType.JOINED)
class Tarifa {

	@Id
	@GeneratedValue
	private Long id

	@Column
	float descuento

	@Column
	float precio

	@Column(length=150)
	String tipo

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
