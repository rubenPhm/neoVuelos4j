package Dominio

import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Busqueda {

	
	Date fechaRealizacion

	Aeropuerto origen

	Aeropuerto destino

	Date desdeFecha

	Date hastaFecha

	Double maxPrecio

	String nickUsuario
	
	public List<VueloPersistenteArena> resultados = newArrayList
	
	Usuario quienBusca
	
	transient static SimpleDateFormat dateToString = new SimpleDateFormat("dd/MM/yyyy - hh:mm 'hs'")
	
	new() {
	}

	new(BusquedaNoArena busquedaPersist){
		origen = busquedaPersist.origen
		destino = busquedaPersist.destino
		desdeFecha = busquedaPersist.desdeFecha
		hastaFecha = busquedaPersist.hastaFecha
		maxPrecio = busquedaPersist.maxPrecio
		nickUsuario = busquedaPersist.nickUsuario
		fechaRealizacion = busquedaPersist.fechaRealizacion
		busquedaPersist.resultados.forEach[resultados.add(new VueloPersistenteArena(it))]
	}
	
	new(Aeropuerto inicio, Aeropuerto fin, Date desde, Date hasta, Double max, Usuario usr) {
		origen = inicio
		destino = fin
		desdeFecha = desde
		hastaFecha = hasta
		maxPrecio = max
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
