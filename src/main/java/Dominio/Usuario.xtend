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
import org.mongodb.morphia.annotations.Embedded
import org.mongodb.morphia.annotations.Transient
import org.uqbar.commons.utils.Observable

import static org.uqbar.commons.model.ObservableUtils.firePropertyChanged

@Entity
@Observable
@Accessors
@Embedded
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
	
	@Transient
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
		firePropertyChanged(this,"reservas",reservas)		
	}
	
	def reservar(Reserva reserva){
		reservas.add(reserva)
		firePropertyChanged(this,"reservas",reservas)		
		
	}
	
	def getAsientosReservados() {
		reservas.map [ it.asiento ].toList
	}
	
}
