package Dominio

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import AppModel.VerReservasAppModel

@Observable
@Accessors
class Usuario {
	
	String nombre
	String contrasenia;
	String nick;
	List <Asiento> asientosReservados
	VerReservasAppModel model
	
	new ( String unNick, String unaContrasenia){
		nick = unNick;
		contrasenia = unaContrasenia;
		asientosReservados = newArrayList
	}
	
	def void eliminarReserva(Asiento asiento){
		asientosReservados.remove(asiento)
		
	}
	
	def reservaAsiento(Asiento unAsiento){
		asientosReservados.add(unAsiento)
	}
	
	def agregarModel(VerReservasAppModel unModel){
		model = unModel
	}
	
	def actualizarReservas(Asiento asiento){
		model.agregarReserva(asiento)
	}
}
