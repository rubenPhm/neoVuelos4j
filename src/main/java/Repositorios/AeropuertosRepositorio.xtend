package Repositorios

import Dominio.Aeropuerto
import java.util.ArrayList
import java.util.List

class AeropuertosRepositorio {
	static AeropuertosRepositorio repositorio = null

	List<Aeropuerto> todosLosAeropuertos = new ArrayList<Aeropuerto>

	public new() {
		//seteo de usuario para testing
	}

	static public def AeropuertosRepositorio getInstance() {
		if (repositorio == null) {
			repositorio = new AeropuertosRepositorio()
		}
      repositorio;
	}
}
