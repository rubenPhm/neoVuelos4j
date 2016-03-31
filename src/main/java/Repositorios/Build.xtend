package Repositorios

import Dominio.Aeropuerto
import Dominio.Asiento
import Dominio.Escala
import Dominio.TarifaComun
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
	Aeropuerto gotze
	Aeropuerto ponja

	public Usuario usr
	Usuario gabo
	public Usuario fede

	Vuelo vuelo
	Vuelo vuelo2

	Escala escala1
	Escala escala2

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

		escala2 = new Escala()
		escala2.horaLlegada = Calendar.getInstance.getTime()
		escala2.destino = gotze

	}

	def crearVuelo() {
		vuelo = new Vuelo()
		vuelo.escalas.add(escala1)
		vuelo.aerolinea = "Aerolineas Argentinas"
		vuelo.origen = ezeiza
		vuelo.destino = ricafort
		vuelo.fechaSalida = Calendar.getInstance.getTime()
		vuelo.fechaLlegada = Calendar.getInstance.getTime()

		vuelo2 = new Vuelo()
		vuelo2.escalas.add(escala1)
		vuelo2.escalas.add(escala2)
		vuelo2.aerolinea = "LAN Airlines"
		vuelo2.origen = costanera
		vuelo2.destino = ponja
		vuelo2.fechaSalida = Calendar.getInstance.getTime()
		vuelo2.fechaLlegada = Calendar.getInstance.getTime()

		var List<Asiento> asientos = new ArrayList<Asiento>
		asientos.add(new Asiento(1, "Pasillo", new TarifaComun(150)))
		asientos.add(new Asiento(1, "Centro", new TarifaComun(180)))
		asientos.add(new Asiento(1, "Ventanilla", new TarifaComun(350)))
		asientos.add(new Asiento(2, "Pasillo", new TarifaComun(450)))
		asientos.add(new Asiento(2, "Centro", new TarifaComun(180)))
		asientos.add(new Asiento(2, "Ventanilla", new TarifaComun(350)))
		asientos.add(new Asiento(3, "Pasillo", new TarifaComun(190)))
		asientos.add(new Asiento(3, "Centro", new TarifaComun(460)))
		asientos.add(new Asiento(3, "Ventanilla", new TarifaComun(350)))
		asientos.add(new Asiento(4, "Pasillo", new TarifaComun(150)))
		asientos.add(new Asiento(4, "Centro", new TarifaComun(350)))
		asientos.add(new Asiento(4, "Ventanilla", new TarifaComun(350)))
		asientos.add(new Asiento(5, "Pasillo", new TarifaComun(450)))
		asientos.add(new Asiento(5, "Centro", new TarifaComun(180)))
		asientos.add(new Asiento(5, "Ventanilla", new TarifaComun(350)))
		asientos.add(new Asiento(6, "Pasillo", new TarifaComun(190)))
		asientos.add(new Asiento(6, "Centro", new TarifaComun(460)))
		asientos.add(new Asiento(6, "Ventanilla", new TarifaComun(350)))
		asientos.add(new Asiento(7, "Pasillo", new TarifaComun(150)))
		asientos.add(new Asiento(7, "Centro", new TarifaComun(350)))
		asientos.add(new Asiento(7, "Ventanilla", new TarifaComun(350)))
		asientos.add(new Asiento(8, "Pasillo", new TarifaComun(450)))
		asientos.add(new Asiento(8, "Centro", new TarifaComun(180)))
		asientos.add(new Asiento(8, "Ventanilla", new TarifaComun(350)))
		asientos.add(new Asiento(9, "Pasillo", new TarifaComun(190)))
		asientos.add(new Asiento(9, "Centro", new TarifaComun(460)))
		asientos.add(new Asiento(9, "Ventanilla", new TarifaComun(350)))

		vuelo.asientos = asientos
		vuelo2.asientos = asientos
		VuelosRepositorio.getInstance().todosLosVuelos.add(vuelo)
		VuelosRepositorio.getInstance().todosLosVuelos.add(vuelo2)

	}

	def crearUsuarios() {
		gabo = new Usuario("gabo", "gabo")
		gabo.nombre = "Gabriel Perez"
		usr = new Usuario("adrian", "adrian")
		usr.nombre = "Adrian Barbani"
		fede = new Usuario("fede", "fede")
		fede.nombre = "Federico Peña"

		UsuarioRepositorio.getInstance().todosLosUsuarios.add(usr)
		UsuarioRepositorio.getInstance().todosLosUsuarios.add(fede)
		UsuarioRepositorio.getInstance().todosLosUsuarios.add(gabo)

	}

	def crearAeropuertos() {
		ezeiza = new Aeropuerto("Ezeiza", "Buenos Aires")
		costanera = new Aeropuerto("Aeroparque", "Buenos Aires")
		ricafort = new Aeropuerto("Miami International Airport", "Miami")
		brazuca = new Aeropuerto("Aeroporto Internacional de São Paulo", "San Pablo")
		gotze = new Aeropuerto("Aeropuerto Internacional de Múnich", "Munich")
		ponja = new Aeropuerto("Aeropuerto Internacional Haneda", "Tokio")

		AeropuertosRepositorio.getInstance().todosLosAeropuertos.add(ezeiza)
		AeropuertosRepositorio.getInstance().todosLosAeropuertos.add(costanera)
		AeropuertosRepositorio.getInstance().todosLosAeropuertos.add(ricafort)
		AeropuertosRepositorio.getInstance().todosLosAeropuertos.add(brazuca)
		AeropuertosRepositorio.getInstance().todosLosAeropuertos.add(gotze)
		AeropuertosRepositorio.getInstance().todosLosAeropuertos.add(ponja)

	}

}
