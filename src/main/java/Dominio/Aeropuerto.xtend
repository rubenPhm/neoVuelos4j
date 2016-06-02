package Dominio

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Embedded
import org.uqbar.commons.utils.Observable

@Entity
@Embedded
@Accessors
@Observable 
class Aeropuerto {
	
	@org.mongodb.morphia.annotations.Id ObjectId 
	idMongo
	
	@javax.persistence.Id
	@GeneratedValue
	private Long id
	
	@Column (length = 150)
	String nombre
	
	@Column (length = 150)
	String pais
	
	new(){}
	
	new (String unNombre, String unPais){
		nombre = unNombre
		pais = unPais
	} 
	
	override toString(){
		nombre
	}
}