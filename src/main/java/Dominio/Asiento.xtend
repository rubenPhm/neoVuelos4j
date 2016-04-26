package Dominio

import java.util.Calendar
import javax.persistence.Column
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.annotations.Entity
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable
import javax.persistence.CascadeType

@Entity
@Accessors
@Observable
class Asiento {

	@Id
	@GeneratedValue
	private Long id

	@Column
	int fila

	@Column(length=150)
	String ubicacion
	
	//un asiento tiene un usr y un usr puede tener muchos asientos.
	@ManyToOne()
	Usuario duenio

	//un asiento tiene una tarifa y una tarifa tiene un asiento
	//igual que el punto que sigue si se borra el asiento quiero que se borre la tarifa, no se si el cascade esta bien definido.
	@OneToOne(cascade = CascadeType.ALL)
	Tarifa tarifa

	//un asiento tiene un vuelo y un vuelo puede tener muchso asientos.
	@ManyToOne()
	Vuelo vuelo

	new(){}
	
	new(int fila, String ubicacion, Tarifa unaTarifa) {
		this.fila = fila
		this.ubicacion = ubicacion
		tarifa = unaTarifa
	}

	new(int fila, String ubicacion) {
		this.fila = fila
		this.ubicacion = ubicacion
	}

	override toString() {
		" " + fila + ubicacion.substring(0, 1) + " "
	}

	def getDisponible() {
		duenio == null
	}

	def liberar() {
		duenio = null
	}

	def conPrecioMaximo(float valor) {
		this.getPrecio <= valor
	}

	def float getPrecio() {
		tarifa.precioFinal(vuelo.fechaSalida, Calendar.getInstance.time)
	}

	def reservarAsiento(Usuario usuario) {
		if (duenio != null) {
			throw new UserException("Este asiento ya ha sido reservado.")
		} else {
			duenio = usuario
			usuario.reservar(new Reserva(this))
		}
	}
}
