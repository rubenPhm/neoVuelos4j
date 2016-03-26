package Repositorios

import Dominio.Aeropuerto
import java.util.ArrayList
import java.util.List

class AeropuertosRepositorio {
	static AeropuertosRepositorio repositorio = null

	public List<Aeropuerto> todosLosAeropuertos = new ArrayList<Aeropuerto>

	public new() {
		todosLosAeropuertos.add(new Aeropuerto("Buenos Aires", "Argentina"))
	}

	static public def AeropuertosRepositorio getInstance() {
		if (repositorio == null) {
			repositorio = new AeropuertosRepositorio()
		}
      repositorio;
	}
	
	def nombreDeTodosLosAeropuertos() {
		todosLosAeropuertos.map[ aeropuerto | aeropuerto.nombre ].toList
	}
	
}
