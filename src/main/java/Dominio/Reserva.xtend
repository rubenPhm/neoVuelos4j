package Dominio

import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Entity
@Observable
@Accessors
class Reserva {

	@Id
	@GeneratedValue
	private Long id

	//una reserva tiene un asiento y un asiento puede tener una sola reserva.
	//si se borra el asiento que se borre la reserva. lo que no quiero es que si se borra la reserva se borre el asiento. por eso no se si esta bien puesto los cascade.
	@OneToOne(cascade=CascadeType.ALL)
	Asiento asiento

	//una reserva tiene un vuelo, pero un vuelo puede tener muchas reservas
	//si se borra el vuelo, los asientos del vuelo se tienen que borrar. por esto es que estan configurado tipo cascade(ver en Asiento (no se si esta bien hecho))por lo tanto se borraria aca tambien.
	@ManyToOne()
	Vuelo vuelo

	@Column(length=150)
	String fechaReserva

	new() {
	}

	new(Asiento unAsiento) {
		asiento = unAsiento
		vuelo = asiento.vuelo
	}

	def getTramos() {
		vuelo.cantidadEscalas
	}

	def void liberarAsiento() {
		asiento.liberar
	}

	def getAsientoDescripcion() {
		asiento.toString
	}

	def getOrigen() {
		vuelo.nombreOrigen
	}

	def getDestino() {
		vuelo.nombreDestino
	}

	def getFechaSalida() {
		vuelo.fechaSalidaStr
	}

	def getFechaLlegada() {
		vuelo.fechaLlegadaStr
	}
}
