package Repositorios

import Dominio.Busqueda
import Dominio.Vuelo
import java.util.Date
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Criteria
import org.hibernate.FetchMode
import org.hibernate.HibernateException
import org.hibernate.classic.Session
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

	override addQueryByExample(Criteria criteria, Vuelo vuelo) {
		if (vuelo.origen != null) {
			criteria.add(Restrictions.eq("aerolinea", vuelo.aerolinea))
		}
	}
	
	override getEntityType() {
		typeof(Vuelo)
	}
	
	def Set<Vuelo> searchByBusqueda(Busqueda unaBusqueda){
		val session = openSession
		try {
			val vuelos = 	vuelosDesdeFecha(unaBusqueda.desdeFecha,
							vuelosHastaFecha(unaBusqueda.hastaFecha,
							initialCriteria(session)))
////		.add(Restrictions.eq("origen.nombre", unaBusqueda.origen))
//			.add(Restrictions.ge("fechaSalida",unaBusqueda.desdeFecha))
//			.add(Restrictions.le("fechaLlegada",unaBusqueda.hastaFecha))
							.list
			if (vuelos.empty) {
				return newHashSet
			} else {
				vuelos.toSet
			}
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}		
	}
	
	def Criteria initialCriteria(Session session){
		session.createCriteria(Vuelo).setFetchMode("vuelos", FetchMode.JOIN)
	}
	
	def Criteria vuelosDesdeFecha(Date salida, Criteria criteriaVuelos){
		if (salida != null){criteriaVuelos.add(Restrictions.ge("fechaSalida",salida))}
		else{criteriaVuelos}
	}
	
	def vuelosHastaFecha(Date llegada, Criteria criteriaVuelos) {
		if (llegada != null){criteriaVuelos.add(Restrictions.le("fechaLlegada",llegada))}
		else{criteriaVuelos}
	}
	
	
	def buscar(Busqueda unaBusqueda) {
		val List<Vuelo> resultados = this.allInstances
//		iniciarBusqueda()
//		 
//		unaBusqueda.validacionFecha()
//		
		vuelosConDestino(unaBusqueda.destino, resultados)
//		vuelosConOrigen (unaBusqueda.origen)
//		vuelosDesdeFecha(unaBusqueda.desdeFecha)
//		vuelosHastaFecha(unaBusqueda.hastaFecha)
//		vuelosPrecioMax(unaBusqueda.maxPrecio)
//		
//		finalizarBusqueda(unaBusqueda)
//		return	vuelosBuffer
	}
//	
//	def iniciarBusqueda() {
//		vuelosBuffer = todosLosVuelos
//	}
//	
//	def finalizarBusqueda(Busqueda busqueda) {
//		agregarBusqueda(busqueda)
//		busqueda.setResultados(vuelosBuffer)
//	}
//	
	def vuelosConDestino(String destino, List <Vuelo> vuelosBuffer){
		if (destino != null && !destino.equals("TODOS")) 
		{vuelosBuffer.filter[conDestino(destino)].toList}
	}
//	
//	def vuelosConOrigen(String origen){
//		if (origen != null && !origen.equals("TODOS"))
//		{vuelosBuffer = vuelosBuffer.filter[conOrigen(origen)].toSet}
//	}
//	
//	def vuelosDesdeFecha(Date salida){
//		if (salida != null) {vuelosBuffer = vuelosBuffer.filter[!saleAntesQue(salida)].toSet}	
//	}
//	
//	def vuelosHastaFecha(Date llegada){
//		if (llegada != null) {vuelosBuffer = vuelosBuffer.filter[llegaAntesQue(llegada)].toSet}	
//	}
//	
//	def vuelosPrecioMax(String precioMax){
//		if (precioMax != null) {val valor = Float.parseFloat(precioMax)
//			vuelosBuffer = vuelosBuffer.filter[contTarifaMenorA(valor)].toSet
//		}
//	}
//		
//	def agregarBusqueda(Busqueda busqueda) {
//		busquedasRealizadas.add(busqueda)
//	}
//	
//	def limpiarBufferVuelos(){
//		vuelosBuffer = new HashSet<Vuelo>
//	}
//	
//	def busquedasDe(Usuario usr){
//		busquedasRealizadas.filter[realizadoPor(usr)].toList
//	}
//	
//		override getEntityType() {
//		typeof(Vuelo)
//	}
	
}