package Repositorios

import Dominio.Busqueda
import Dominio.Usuario
import Dominio.Vuelo
import java.util.ArrayList
import java.util.Date
import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions
import org.uqbar.commons.utils.Observable

@Accessors
@Observable 
class VuelosRepositorio extends RepositorioDefault<Vuelo> {

//	Set<Vuelo> todosLosVuelos = newHashSet
//	List<Busqueda> busquedasRealizadas = newArrayList
//	Set<Vuelo> vuelosBuffer = newHashSet
	
	static VuelosRepositorio repositorio = null
	
	static public def VuelosRepositorio getInstance() {
		if (repositorio == null) {
			repositorio = new VuelosRepositorio()}
		repositorio
	}

	def buscar(Busqueda unaBusqueda) {
//		iniciarBusqueda()
//		
//		unaBusqueda.validacionFecha()
//		
//		vuelosConDestino(unaBusqueda.destino)
//		vuelosConOrigen (unaBusqueda.origen)
//		vuelosDesdeFecha(unaBusqueda.desdeFecha)
//		vuelosHastaFecha(unaBusqueda.hastaFecha)
//		vuelosPrecioMax(unaBusqueda.maxPrecio)
//		
//		finalizarBusqueda(unaBusqueda)
//		return	vuelosBuffer
	}
	
	def iniciarBusqueda() {
//		vuelosBuffer = todosLosVuelos
	}
	
	def finalizarBusqueda(Busqueda busqueda) {
//		agregarBusqueda(busqueda)
//		busqueda.setResultados(vuelosBuffer)
	}
	
	def vuelosConDestino(String destino){
//		if (destino != null && !destino.equals("TODOS")) 
//		{vuelosBuffer = vuelosBuffer.filter[conDestino(destino)].toSet}
	}
	
	def vuelosConOrigen(String origen){
//		if (origen != null && !origen.equals("TODOS"))
//		{vuelosBuffer = vuelosBuffer.filter[conOrigen(origen)].toSet}
	}
	
	def vuelosDesdeFecha(Date salida){
//		if (salida != null) {vuelosBuffer = vuelosBuffer.filter[!saleAntesQue(salida)].toSet}	
	}
	
	def vuelosHastaFecha(Date llegada){
//		if (llegada != null) {vuelosBuffer = vuelosBuffer.filter[llegaAntesQue(llegada)].toSet}	
	}
	
	def vuelosPrecioMax(String precioMax){
//		if (precioMax != null) {val valor = Float.parseFloat(precioMax)
//			vuelosBuffer = vuelosBuffer.filter[contTarifaMenorA(valor)].toSet
//		}
	}
		
	def agregarBusqueda(Busqueda busqueda) {
//		busquedasRealizadas.add(busqueda)
	}
	
	def limpiarBufferVuelos(){
//		vuelosBuffer = new HashSet<Vuelo>
	}
	
	def busquedasDe(Usuario usr){
//		busquedasRealizadas.filter[realizadoPor(usr)].toList
//	}
//	
//		override getEntityType() {
//		typeof(Vuelo)
	}

	override addQueryByExample(Criteria criteria, Vuelo vuelo) {
		if (vuelo.origen != null) {
			criteria.add(Restrictions.eq("aerolinea", vuelo.aerolinea))
		}
	}
	
	override getEntityType() {
		typeof(Vuelo)
	}
	
}