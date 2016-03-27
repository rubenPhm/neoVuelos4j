package Dominio

import java.util.ArrayList
import java.util.Calendar
import java.util.Date
import java.util.List
import Repositorios.VuelosRepositorio

class Busqueda {
	
	Date fechaEnLaQueSeRealizoLaBusqueda
	Usuario usuarioQueRealizaLaBusqueda
	public List <Vuelo> resultados
	
	String origen
	String destino
	Date desdeFecha
	Date hastaFecha
	String maxPrecio 
	
	
	new(String inicio, String fin, Date desde, Date hasta, String max){
		origen = inicio
		destino = fin
		desdeFecha = desde
		hastaFecha = hasta
		maxPrecio = max
		resultados = new ArrayList <Vuelo>
	}
	
	def buscar(Usuario usr){
				
		resultados = VuelosRepositorio.getInstance.getTodosLosVuelos
		
		this.conDestino(destino)
			.conOrigen(origen)
			.conPrecioMax(maxPrecio)
			.finBusqueda(usr)
			
		return resultados
	}
	
	def Busqueda conDestino(String destino){
		if (destino != null){resultados = resultados.filter[ conDestino(destino)].toList}
		return this
	}
	
	def Busqueda conOrigen(String origen){
		if (origen != null){resultados = resultados.filter[ conOrigen(origen)].toList}
		return this
	}
	
	def Busqueda conPrecioMax(String tarifaStr){
		if( tarifaStr != null){ 
			val float tarifa = Float.parseFloat(tarifaStr)
			resultados = resultados.filter[contTarifaMenorA(tarifa)].toList
		}
		return this
	}
	
	def finBusqueda(Usuario usr){
		usuarioQueRealizaLaBusqueda = usr
		fechaEnLaQueSeRealizoLaBusqueda = Calendar.getInstance().getTime();
	}
}