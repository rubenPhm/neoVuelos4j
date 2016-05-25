package Dominio

import java.util.Calendar
import java.util.Date
import java.util.HashSet
import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.ManyToMany
import javax.persistence.ManyToOne
import org.bson.types.ObjectId
import org.mongodb.morphia.annotations.Property
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable
import org.mongodb.morphia.annotations.Embedded

@Entity
@org.mongodb.morphia.annotations.Entity(value="Busquedas")
@Observable
@Accessors
class Busqueda {

	@Id ObjectId idMongo

	@javax.persistence.Id
	@GeneratedValue
	private Long id

	@Column
	@Property("fechaRealizacion")
	Date fechaRealizacion

	@Embedded
	@ManyToOne()
	public Usuario quienBusca

	@Embedded
	@ManyToMany()
	public Set<Vuelo> resultados = new HashSet

	@Embedded
	@ManyToOne
	Aeropuerto origen

	@Embedded
	@ManyToOne
	Aeropuerto destino

	@Column
	Date desdeFecha

	@Column
	Date hastaFecha

	@Column(length=150)
	Double maxPrecio

	new() {
	}

	new(Aeropuerto inicio, Aeropuerto fin, Date desde, Date hasta, Double max, Usuario usr) {
		origen = inicio
		destino = fin
		desdeFecha = desde
		hastaFecha = hasta
		maxPrecio = max
		quienBusca = usr
		fechaRealizacion = Calendar.getInstance.getTime
	}

	new(Date desde, Date hasta, Usuario usr) {
		desdeFecha = desde
		hastaFecha = hasta
		quienBusca = usr
	}

	def validacionFecha() {
		if (desdeFecha != null && hastaFecha != null) {
			if (desdeFecha > hastaFecha) {
				throw new UserException("La 'Fecha Desde' no puede ser menor que 'Fecha Hasta' ")
			}
		}
	}

	def realizadoPor(Usuario unUsr) {
		quienBusca == unUsr
	}
	
	def getCriterioDeBusqueda(){
		var String criterio = "Se buscaron vuelos que cumplan con"
		
		if(origen != null){criterio += " haber partido de " + origen}
		if(destino != null){criterio += " tener como destino " + destino}
		if(desdeFecha != null){criterio += " salir despues del " + desdeFecha}
		if(hastaFecha != null){criterio += " llegar antes del " + hastaFecha}
		if(maxPrecio != null){criterio += " pagar menos que " + maxPrecio}
		if(criterio == "Se buscaron vuelos que cumplan con"){criterio = "Se buscaron todos los vuelos"}
		criterio
	}
	
	def getCantidadDeResultados(){
		resultados.size()
	}
}
