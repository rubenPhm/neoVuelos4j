package Repositorios

import Dominio.Busqueda
import Dominio.Usuario
import Dominio.Vuelo
import java.util.ArrayList
import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable 
class VuelosRepositorio {
	static VuelosRepositorio repositorio = null

	List<Vuelo> todosLosVuelos
	List<Busqueda> busquedasRealizadas
	
	List<Vuelo> vuelosBuffer


	protected  new(){
		todosLosVuelos = new ArrayList<Vuelo>
		busquedasRealizadas = new ArrayList<Busqueda>
		vuelosBuffer = new ArrayList<Vuelo>
	}
	
	static public def VuelosRepositorio getInstance() {
		if (repositorio == null) {
			repositorio = new VuelosRepositorio()
		}
      repositorio
	}
	
	def buscar(Busqueda unaBusqueda) {
		iniciarBusqueda()
		
		unaBusqueda.validacionFecha()
		
		vuelosConDestino(unaBusqueda.destino)
		vuelosConOrigen (unaBusqueda.origen)
		vuelosDesdeFecha(unaBusqueda.desdeFecha)
		vuelosHastaFecha(unaBusqueda.hastaFecha)
		vuelosPrecioMax(unaBusqueda.maxPrecio)
		
		finalizarBusqueda(unaBusqueda)
		return	vuelosBuffer
	}
	
	def iniciarBusqueda() {
		vuelosBuffer = todosLosVuelos
	}
	
	def finalizarBusqueda(Busqueda busqueda) {
		agregarBusqueda(busqueda)
		busqueda.setResultados(vuelosBuffer)
	}
	
	def vuelosConDestino(String destino){
		if (destino != null && !destino.equals("TODOS")) 
		{vuelosBuffer = vuelosBuffer.filter[conDestino(destino)].toList}
	}
	
	def vuelosConOrigen(String origen){
		if (origen != null && !origen.equals("TODOS"))
		{vuelosBuffer = vuelosBuffer.filter[conOrigen(origen)].toList}
	}
	
	def vuelosDesdeFecha(Date salida){
		if (salida != null) {vuelosBuffer = vuelosBuffer.filter[!saleAntesQue(salida)].toList}	
	}
	
	def vuelosHastaFecha(Date llegada){
		if (llegada != null) {vuelosBuffer = vuelosBuffer.filter[llegaAntesQue(llegada)].toList}	
	}
	
	def vuelosPrecioMax(String precioMax){
		if (precioMax != null) {val valor = Float.parseFloat(precioMax)
			vuelosBuffer = vuelosBuffer.filter[contTarifaMenorA(valor)].toList
		}
	}
		
	def agregarBusqueda(Busqueda busqueda) {
		busquedasRealizadas.add(busqueda)
	}
	
	def limpiarBufferVuelos(){
		vuelosBuffer = new ArrayList<Vuelo>
	}
	
	def busquedasDe(Usuario usr){
		busquedasRealizadas.filter[realizadoPor(usr)].toList
	}
	
	def public agregarVuelo(Vuelo vuelo) {
		todosLosVuelos.add(vuelo)
	}
}