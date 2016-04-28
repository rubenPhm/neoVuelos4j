package Dominio

import java.util.HashSet
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Entity
@Observable
@Accessors
class Usuario {
	
	@Id
	@GeneratedValue
	private Long id
	
	@Column (length = 150) 
	String nombre
	
	@Column (length = 150)
	String contrasenia
	
	@Column (length = 150)
	String nick
	
	//Un usr puede tener muchas reservas y una reserva un solo usr. cascade para que se borre la reserva cuando el usuario la borra.
	//cambio list  a set.
	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	Set<Reserva> reservas = new HashSet
	
	new(){}
	
	new ( String unNick, String unaContrasenia){
		nick = unNick
		contrasenia = unaContrasenia
	}
	
	def void eliminarReserva(Reserva reserva){
		reservas.remove(reserva)
		reserva.liberarAsiento
	}
	
	def reservar(Reserva reserva){
		reservas.add(reserva)
	}
	
	def getAsientosReservados() {
		reservas.map [ it.asiento ].toList
	}
	
}
