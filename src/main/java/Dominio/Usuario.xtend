package Dominio

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.ArrayList

@Observable
@Accessors
class Usuario {
	
	String nombre
	String contrasenia;
	String nick;
	List <Asiento> asientosReservados
	List <Busqueda> busquedasRealizadas
	
	new ( String unNick, String unaContrasenia){
		nick = unNick;
		contrasenia = unaContrasenia;
		asientosReservados = new ArrayList<Asiento>
		busquedasRealizadas = new ArrayList<Busqueda>
	}	
}