package Dominio

import java.text.SimpleDateFormat
import java.util.Date
import java.util.GregorianCalendar
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

	@OneToOne
	Asiento asiento

	@ManyToOne
	Vuelo vuelo

	@Column
	Date fechaReserva
	
	transient static SimpleDateFormat dateToString = new SimpleDateFormat("dd/MM/yyyy - hh:mm 'hs'")

	new() {
	}
	
	new(Asiento unAsiento) {
		fechaReserva = GregorianCalendar.instance.time
		unAsiento.reservar()
		asiento = unAsiento
		vuelo = unAsiento.vuelo
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
	
	def getFechaReservaStr() { dateToString.format(fechaReserva) }
}
