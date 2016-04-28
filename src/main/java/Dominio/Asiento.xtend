package Dominio

import java.util.Calendar
import java.util.Date
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

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

	@Column
	boolean disponible = true

	@Column
	Date salidaVuelo
	
	//un asiento tiene una tarifa y una tarifa tiene un asiento
	//igual que el punto que sigue si se borra el asiento quiero que se borre la tarifa, no se si el cascade esta bien definido.
	@OneToOne(cascade = CascadeType.ALL)
	Tarifa tarifa

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

	def liberar() {
		 disponible = true
	}

	def conPrecioMaximo(float valor) {
		if (disponible){this.getPrecio(salidaVuelo) <= valor}
		else { true }
	}

	def float getPrecio(Date unaFechaSalida) {
		tarifa.precioFinal(salidaVuelo, Calendar.getInstance.time)
	}
	
	def setVuelo(Vuelo unVuelo){
		salidaVuelo = unVuelo.fechaSalida
	}

	def reservar() {
		disponible = false
	}
}
