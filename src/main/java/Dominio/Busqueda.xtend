package Dominio

import Repositorios.VuelosRepositorio
import java.util.ArrayList
import java.util.Calendar
import java.util.Date
import java.util.List

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
			.conFechaDesde(desdeFecha)
			.conFechaHasta(hastaFecha)
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
	
	def Busqueda conPrecioMax(String valorStr){
		if (valorStr != null){
			val valor = Float.parseFloat(valorStr)
			resultados = resultados.filter[contTarifaMenorA(valor)].toList
		}
		return this
	}
	
	def Busqueda conFechaDesde(Date unaFecha){
		if(unaFecha != null){
			resultados = resultados.filter[!saleAntesQue(unaFecha)].toList
		}
		return this
	}
	
	def Busqueda conFechaHasta(Date unaFecha){
		if(unaFecha != null){
			resultados = resultados.filter[llegaAntesQue(unaFecha)].toList
		}
		return this
	}
	
	def finBusqueda(Usuario usr){
		usuarioQueRealizaLaBusqueda = usr
		fechaEnLaQueSeRealizoLaBusqueda = Calendar.getInstance().getTime();
	}
}