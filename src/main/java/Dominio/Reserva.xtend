package Dominio

import java.util.Date
import java.util.GregorianCalendar
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

	@OneToOne(cascade=CascadeType.ALL)
	Asiento asiento

	@ManyToOne()
	Vuelo vuelo

	@Column(length=150)
	Date fechaReserva

	new() {
	}
	
	new(Asiento unAsiento, Vuelo unVuelo) {
		fechaReserva = GregorianCalendar.instance.time
		unAsiento.reservar()
		asiento = unAsiento
		vuelo = unVuelo
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
