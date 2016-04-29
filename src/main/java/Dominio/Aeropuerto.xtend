package Dominio

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Entity
@Accessors
@Observable 
class Aeropuerto {
	
	@Id
	@GeneratedValue
	private Long id
	
	@Column (length = 150)
	String nombre
	
	@Column (length = 150)
	String pais
	
	new(){}//Todas las clases tienen que tener el new vacio para hibernet.
	
	new (String unNombre, String unPais){
		nombre = unNombre
		pais = unPais
	} 
	
	override toString(){
		nombre
	}
}