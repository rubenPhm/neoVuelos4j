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
	float maxPrecio
	
	
	new(String inicio, String fin, Date desde, Date hasta, float max){
		origen = inicio
		destino = fin
		desdeFecha = desde
		hastaFecha = hasta
		maxPrecio = max
		resultados = new ArrayList	
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
		if (destino != null){resultados.filter[ conDestino(destino)].toList}
		return this
	}
	
	def Busqueda conOrigen(String origen){
		if (origen != null){resultados.filter[ conOrigen(origen)].toList}
		return this
	}
	
	def Busqueda conPrecioMax(float tarifa){
		if(! tarifa.equals(null)){ resultados.filter[contTarifaMenorA(tarifa)].toList}
		return this
	}
	
	def finBusqueda(Usuario usr){
		usuarioQueRealizaLaBusqueda = usr
		fechaEnLaQueSeRealizoLaBusqueda = Calendar.getInstance().getTime();
	}
	
	
	
	
	
//	new(){
//		resultados = new ArrayList	
//	}
//	
//	def buscarVuelo (Vuelo vuelo, Usuario usr){
//		usuarioQueRealizaLaBusqueda = usr
//		fechaEnLaQueSeRealizoLaBusqueda = Calendar.getInstance().getTime();
//		resultados = VuelosRepositorio.getInstance.obtenerVuelosQueCumplanCon(vuelo);
//		
//		usuarioQueRealizaLaBusqueda.busquedasRealizadas.add(this);
//	}
	
}