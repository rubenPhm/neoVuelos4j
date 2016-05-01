package Dominio

import java.util.Calendar
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
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

	@Column
	boolean disponible = true

	@ManyToOne
	Vuelo vuelo
	
	@ManyToOne
	Tarifa tarifa

	new(){}
	
	new(int fila, String ubicacion, Tarifa unaTarifa) {
		this.fila = fila
		this.ubicacion = ubicacion
		setTarifa(unaTarifa)
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
		if (disponible){this.getPrecio() <= valor}
		else { true }
	}

	def float getPrecio() {
		tarifa.precioFinal(vuelo.fechaSalida, Calendar.getInstance.time)
	}
	
	def setVuelo(Vuelo unVuelo){
		vuelo = unVuelo
	}

	def reservar() {
		disponible = false
	}
}
