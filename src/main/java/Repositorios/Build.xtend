package Repositorios

import Dominio.Aeropuerto
import Dominio.Asiento
import Dominio.Escala
import Dominio.Tarifa
import Dominio.Usuario
import Dominio.Vuelo
import java.util.ArrayList
import java.util.Calendar
import java.util.List

class Build {

	Aeropuerto ezeiza
	Aeropuerto costanera
	Aeropuerto ricafort
	Aeropuerto brazuca

	public Usuario usr
	Usuario gabo
	Usuario fede

	Vuelo vuelo

	Escala escala1

	new() {
		initData()
	}

	def initData() {
		this.crearAeropuertos
		this.crearUsuarios
		this.crearEscalas
		this.crearVuelo
	}

	def crearEscalas() {
		escala1 = new Escala()
		escala1.horaLlegada = Calendar.getInstance.getTime()
		escala1.destino = brazuca

	}

	def crearVuelo() {
		vuelo = new Vuelo()
		vuelo.escalas.add(escala1)
		vuelo.aerolinea = "Aerolineas Argentinas"
		vuelo.origen = ezeiza
		vuelo.destino = ricafort
		vuelo.fechaSalida = Calendar.getInstance.getTime()
		vuelo.fechaLlegada = Calendar.getInstance.getTime()

		var List<Asiento> asientos = new ArrayList<Asiento>
		asientos.add(new Asiento(1, "medio", new Tarifa(150)))
		asientos.add(new Asiento(1, "centro", new Tarifa(180)))
		asientos.add(new Asiento(1, "ventanilla", new Tarifa(350)))
		asientos.add(new Asiento(2, "medio", new Tarifa(450)))
		asientos.add(new Asiento(2, "centro", new Tarifa(180)))
		asientos.add(new Asiento(2, "ventanilla", new Tarifa(350)))
		asientos.add(new Asiento(3, "medio", new Tarifa(190)))
		asientos.add(new Asiento(3, "centro", new Tarifa(460)))
		asientos.add(new Asiento(3, "ventanilla", new Tarifa(350)))
		asientos.add(new Asiento(4, "medio", new Tarifa(150)))
		asientos.add(new Asiento(4, "centro", new Tarifa(350)))
		asientos.add(new Asiento(4, "ventanilla", new Tarifa(350)))
		asientos.add(new Asiento(5, "medio", new Tarifa(450)))
		asientos.add(new Asiento(5, "centro", new Tarifa(180)))
		asientos.add(new Asiento(5, "ventanilla", new Tarifa(350)))
		asientos.add(new Asiento(6, "medio", new Tarifa(190)))
		asientos.add(new Asiento(6, "centro", new Tarifa(460)))
		asientos.add(new Asiento(6, "ventanilla", new Tarifa(350)))
		asientos.add(new Asiento(7, "medio", new Tarifa(150)))
		asientos.add(new Asiento(7, "centro", new Tarifa(350)))
		asientos.add(new Asiento(7, "ventanilla", new Tarifa(350)))
		asientos.add(new Asiento(8, "medio", new Tarifa(450)))
		asientos.add(new Asiento(8, "centro", new Tarifa(180)))
		asientos.add(new Asiento(8, "ventanilla", new Tarifa(350)))
		asientos.add(new Asiento(9, "medio", new Tarifa(190)))
		asientos.add(new Asiento(9, "centro", new Tarifa(460)))
		asientos.add(new Asiento(9, "ventanilla", new Tarifa(350)))

		vuelo.asientos = asientos
		VuelosRepositorio.getInstance().todosLosVuelos.add(vuelo)
	}

	def crearUsuarios() {
		gabo = new Usuario("gabo", "gabo")
		gabo.nombre = "Gabriel Perez"
		usr = new Usuario("adrian", "adrian")
		usr.nombre = "Adrian Barbani"
		fede = new Usuario ("fede", "fede")
		fede.nombre = "Federico Peña"
	}

	def crearAeropuertos() {
		ezeiza = new Aeropuerto("Ezeiza", "Buenos Aires")
		costanera = new Aeropuerto("Aeroparque", "Buenos Aires")
		ricafort = new Aeropuerto("Miami International Airport", "Miami")
		brazuca = new Aeropuerto("Aeroporto Internacional de São Paulo", "San Pablo")

		AeropuertosRepositorio.getInstance().todosLosAeropuertos.add(ezeiza)
		AeropuertosRepositorio.getInstance().todosLosAeropuertos.add(costanera)
		AeropuertosRepositorio.getInstance().todosLosAeropuertos.add(ricafort)
		AeropuertosRepositorio.getInstance().todosLosAeropuertos.add(brazuca)
	}

}
