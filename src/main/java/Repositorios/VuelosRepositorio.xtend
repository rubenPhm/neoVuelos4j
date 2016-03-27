package Repositorios

import Dominio.Vuelo
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable 
class VuelosRepositorio {
	static VuelosRepositorio repositorio = null

// public para poder forzar los datos
	public List<Vuelo> todosLosVuelos = new ArrayList<Vuelo>

	protected new() {
		
	}


	static public def VuelosRepositorio getInstance() {
		if (repositorio == null) {
			repositorio = new VuelosRepositorio()
		}
      repositorio;
	}
	
//	def obtenerVuelosQueCumplanCon(Vuelo vuelo) {
//		//testear esto por que si yo le ingreso un vuelo con algunos datos null no se si me devuelve lo que espero.
//		val List<Vuelo> vuelos = todosLosVuelos.filter[ unVuelo | unVuelo.equals(vuelo)].toList
//		return vuelos
//	}
	
}