package Dominio

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable 
class Aeropuerto {
	
	String nombre
	String pais
	
	new (String unNombre, String unPais){
		nombre = unNombre
		pais = unPais
	} 
}