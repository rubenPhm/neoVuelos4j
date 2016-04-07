package Dominio

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Usuario {
	
	String nombre
	String contrasenia
	String nick
	List<Reserva> reservas = newArrayList
	
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
