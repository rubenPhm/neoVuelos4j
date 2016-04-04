package AppModel

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import Dominio.Usuario
import java.util.ArrayList
import java.util.List
import Dominio.Reserva
import Dominio.Asiento

@Observable
@Accessors
 
class VerReservasAppModel {
 
 Usuario usuario
 String nombre 
 List <Asiento> asientos = new ArrayList
 List <Reserva>reservas = new ArrayList
 
 Reserva reservaSeleccionada = null		 
	 new(Usuario user){   
	    usuario = user
		nombre = user.nombre
		usuario.agregarModel(this)
		init				
	}
	
	def init(){
	    asientos = usuario.asientosReservados
	    asientos.forEach[a|reservas.add(new Reserva(a))]
	}
	
	def agregarReserva(Asiento asiento){	    
	    reservas.add(new Reserva(asiento))
	}
   
   def cancelarReserva(Reserva reserva){
       usuario.eliminarReserva(reserva.asiento)
       reservaSeleccionada.liberarAsiento
       reservas.remove(reserva)
	}
	
}