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
	public Usuario gabo
	public Usuario fede

	Vuelo vueloAA
	Vuelo vueloLAN

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
		this.relacionarAsientosVuelosUsuarios
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
		vueloAA = new Vuelo()
		vueloAA.escalas.add(escala1)
		vueloAA.aerolinea = "Aerolineas Argentinas"
		vueloAA.origen = ezeiza
		vueloAA.destino = ricafort
		vueloAA.fechaSalida = Calendar.getInstance.getTime()
		vueloAA.fechaLlegada = Calendar.getInstance.getTime()

		vueloLAN = new Vuelo()
		vueloLAN.escalas.add(escala1)
		vueloLAN.escalas.add(escala2)
		vueloLAN.aerolinea = "LAN Airlines"
		vueloLAN.origen = costanera
		vueloLAN.destino = ponja
		vueloLAN.fechaSalida = Calendar.getInstance.getTime()
		vueloLAN.fechaLlegada = Calendar.getInstance.getTime()
}
	def relacionarAsientosVuelosUsuarios(){
		
					
		val Asiento asiento1 = new Asiento(1, "Pasillo", new TarifaComun(150))
		val Asiento asiento2 = new Asiento(1, "Centro", new TarifaComun(180))
		val Asiento asiento3 = new Asiento(1, "Ventanilla", new TarifaComun(350))
		val Asiento asiento4 = new Asiento(2, "Pasillo", new TarifaComun(450))
		val Asiento asiento5 = new Asiento(4, "Pasillo", new TarifaComun(150))
		val Asiento asiento6 = new Asiento(8, "Ventanilla", new TarifaComun(350))
		val Asiento asiento7 = new Asiento(1, "Ventanilla", new TarifaComun(350))
		
		
		var List<Asiento> asientosAA = new ArrayList<Asiento>
		asientosAA.add(new Asiento(1, "Pasillo", new TarifaComun(150)))
		asientosAA.add(new Asiento(1, "Centro", new TarifaComun(180)))
		asientosAA.add(new Asiento(2, "Pasillo", new TarifaComun(450)))
		asientosAA.add(new Asiento(2, "Centro", new TarifaComun(180)))
		asientosAA.add(new Asiento(2, "Ventanilla", new TarifaComun(350)))
		asientosAA.add(new Asiento(3, "Pasillo", new TarifaComun(190)))
		asientosAA.add(new Asiento(3, "Centro", new TarifaComun(460)))
		asientosAA.add(new Asiento(3, "Ventanilla", new TarifaComun(350)))
		asientosAA.add(new Asiento(4, "Centro", new TarifaComun(350)))
		asientosAA.add(new Asiento(4, "Ventanilla", new TarifaComun(350)))
		asientosAA.add(new Asiento(5, "Pasillo", new TarifaComun(450)))
		asientosAA.add(new Asiento(5, "Centro", new TarifaComun(180)))
		asientosAA.add(new Asiento(5, "Ventanilla", new TarifaComun(350)))
		asientosAA => [
			add(asiento1)
			add(asiento3)
			add(asiento5)
			add(asiento7)]
		asientosAA.forEach[setVuelo(vueloAA)]
		
		var List<Asiento> asientosLAN = new ArrayList<Asiento>
		asientosLAN => [
			add(new Asiento(6, "Pasillo", new TarifaComun(190)))
			add(new Asiento(6, "Centro", new TarifaComun(460)))
			add(new Asiento(6, "Ventanilla", new TarifaComun(350)))
			add(new Asiento(7, "Pasillo", new TarifaComun(1)))
			add(new Asiento(7, "Centro", new TarifaComun(350)))
			add(new Asiento(7, "Ventanilla", new TarifaComun(350)))
			add(new Asiento(8, "Pasillo", new TarifaComun(450)))
			add(new Asiento(8, "Centro", new TarifaComun(180)))
			add(new Asiento(9, "Pasillo", new TarifaComun(190)))
			add(new Asiento(9, "Centro", new TarifaComun(460)))
			add(new Asiento(9, "Ventanilla", new TarifaComun(350)))
			add(asiento2)
			add(asiento4)
			add(asiento6)]
			
			asientosLAN.forEach[setVuelo(vueloLAN)]
		
		var List <Asiento> asientosAReservarUSR = new ArrayList <Asiento>
		asientosAReservarUSR => [
			add(asiento1)
			add(asiento2)
			add(asiento3)
			add(asiento4) ]
		asientosAReservarUSR.forEach[reservarAsiento(usr)]
			
		var List <Asiento> asientosAReservarGABO = new ArrayList <Asiento>
			asientosAReservarGABO =>[
				add(asiento5)
				add(asiento6)
				add(asiento7)]
		asientosAReservarGABO.forEach[reservarAsiento(gabo)]		
				
		vueloAA.asientos = asientosAA
		vueloLAN.asientos = asientosLAN
		
		VuelosRepositorio.getInstance().todosLosVuelos.add(vueloAA)
		VuelosRepositorio.getInstance().todosLosVuelos.add(vueloLAN)

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
