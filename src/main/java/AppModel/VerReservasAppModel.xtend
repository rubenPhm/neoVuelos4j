package AppModel

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import Dominio.Usuario
import java.util.ArrayList
import java.util.List
import Dominio.Reserva

@Observable
@Accessors
 

class VerReservasAppModel {

 Usuario usuario
 String nombre 
 List asientos = new ArrayList
 List reservas = new ArrayList
 
 Reserva reservaSeleccionada = null	
	
	new(Usuario user){
		usuario = user
		nombre = user.nombre
		init				
	}
	
	def private init(){
	    asientos = usuario.asientosReservados
	    asientos.forEach[a|reservas.add(new Reserva(a))]
	}
   
   def cancelarReserva(Reserva reserva){
       usuario.eliminarReserva(reserva.asiento)
       reservas.remove(reserva)
       
}
	
}