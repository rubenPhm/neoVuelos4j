package Dominio

import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date
import java.util.HashSet
import java.util.Set
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Embedded
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.mongodb.morphia.annotations.Property
import org.mongodb.morphia.annotations.Transient
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Entity(value="Busquedas")
@Observable
@Accessors
class Busqueda {

	@Id ObjectId idMongo
	
	@Property("fecha")
	Date fechaRealizacion

	@Transient
	public Usuario quienBusca

	@Embedded
	public Set<Vuelo> resultados = new HashSet

	@Embedded
	Aeropuerto origen

	@Embedded
	Aeropuerto destino

	@Property
	Date desdeFecha

	@Property
	Date hastaFecha

	@Property
	Double maxPrecio

	@Property("usuario")
	String nickUsuario
	
	@Transient
	transient static SimpleDateFormat dateToString = new SimpleDateFormat("dd/MM/yyyy - hh:mm 'hs'")
	
	new() {
	}

	new(Aeropuerto inicio, Aeropuerto fin, Date desde, Date hasta, Double max, Usuario usr) {
		origen = inicio
		destino = fin
		desdeFecha = desde
		hastaFecha = hasta
		maxPrecio = max
		quienBusca = usr
		nickUsuario = usr.nick
		fechaRealizacion = Calendar.getInstance.getTime
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
		if(desdeFecha != null){criterio += " salir despues del " + dateToString.format(desdeFecha)}
		if(hastaFecha != null){criterio += " llegar antes del " + dateToString.format(hastaFecha)}
		if(maxPrecio != null){criterio += " pagar menos que " + maxPrecio}
		if(criterio == "Se buscaron vuelos que cumplan con"){criterio = "Se buscaron todos los vuelos"}
		criterio
	}
	
	def getFechaRealizacionStr(){
		dateToString.format(fechaRealizacion)
	}
	
	def getCantidadDeResultados(){
		resultados.size()
	}
}
