
package Repositorios

import Dominio.Aeropuerto
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class AeropuertosRepositorio {
	static AeropuertosRepositorio repositorio = null

	public List<Aeropuerto> todosLosAeropuertos = new ArrayList<Aeropuerto>

	public new() {

	}

	static public def AeropuertosRepositorio getInstance() {
		if (repositorio == null) {
			repositorio = new AeropuertosRepositorio()
		}
      repositorio
	}
	
	def nombreDeTodosLosAeropuertos() {
		todosLosAeropuertos.map[ aeropuerto | aeropuerto.nombre ].toList
	}
	
}

