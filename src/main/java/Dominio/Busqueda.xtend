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
	
	new(){
		resultados = new ArrayList	
	}
	
	def buscarVuelo (Vuelo vuelo, Usuario usr){
		usuarioQueRealizaLaBusqueda = usr
		fechaEnLaQueSeRealizoLaBusqueda = Calendar.getInstance().getTime();
		resultados = VuelosRepositorio.getInstance.obtenerVuelosQueCumplanCon(vuelo);
		
		usuarioQueRealizaLaBusqueda.busquedasRealizadas.add(this);
	}
	
}