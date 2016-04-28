package Runnable

import Dominio.Aeropuerto
import Dominio.Asiento
import Dominio.Escala
import Dominio.Reserva
import Dominio.TarifaComun
import Dominio.Usuario
import Dominio.Vuelo
import Repositorios.AeropuertosRepositorio
import Repositorios.UsuarioRepositorio
import Repositorios.VuelosRepositorio
import java.util.ArrayList
import java.util.Calendar
import java.util.GregorianCalendar
import java.util.HashSet
import java.util.List
import java.util.Set
import org.uqbar.arena.bootstrap.Bootstrap

class AdmVuelosBootstrap implements Bootstrap{
	
	Aeropuerto ezeiza
	Aeropuerto costanera
	Aeropuerto ricafort
	Aeropuerto brazuca
	Aeropuerto gotze
	Aeropuerto ponja
	
	public Usuario usr
	public Usuario gabo
	public Usuario fede
	
	Escala escala1
	Escala escala2
	
	Vuelo vueloAA
	Vuelo vueloLAN
	
	
	override run() {
		initAeropuertos
		initUsuarios
		initVuelos
		initAsientos
		crearEntidades
	}
	
	def crearEntidades() {
		// TODO: Analizar qué tienen que cambiar al sacar el cascade
		// Tarifas?
		crearAeropuerto(ezeiza)
		crearAeropuerto(costanera)
		crearAeropuerto(ricafort)
		crearAeropuerto(brazuca)
		crearAeropuerto(gotze)
		crearAeropuerto(ponja)

		crearVuelo(vueloLAN)
		crearVuelo(vueloAA)

		crearUsuario(gabo)
		crearUsuario(usr)
		crearUsuario(fede)
	}
 
	def initAsientos() {
		val Asiento asiento1 = new Asiento(1, "Pasillo", new TarifaComun(150))
		val Asiento asiento2 = new Asiento(1, "Centro", new TarifaComun(180))
		val Asiento asiento3 = new Asiento(1, "Ventanilla", new TarifaComun(350))
		val Asiento asiento4 = new Asiento(2, "Pasillo", new TarifaComun(450))
		val Asiento asiento5 = new Asiento(4, "Pasillo", new TarifaComun(150))
		val Asiento asiento6 = new Asiento(8, "Ventanilla", new TarifaComun(350))
		val Asiento asiento7 = new Asiento(1, "Ventanilla", new TarifaComun(350))
		
		var Set<Asiento> asientosAA = new HashSet<Asiento>
		asientosAA => [
			add(asiento1)
			add(asiento3)
			add(asiento5)
			add(asiento7)
			add(new Asiento(1, "Pasillo", new TarifaComun(150)))
			add(new Asiento(1, "Centro", new TarifaComun(180)))
			add(new Asiento(2, "Pasillo", new TarifaComun(450)))
			add(new Asiento(2, "Centro", new TarifaComun(180)))
			add(new Asiento(2, "Ventanilla", new TarifaComun(350)))
			add(new Asiento(3, "Pasillo", new TarifaComun(190)))
			add(new Asiento(3, "Centro", new TarifaComun(460)))
			add(new Asiento(3, "Ventanilla", new TarifaComun(350)))
			add(new Asiento(4, "Centro", new TarifaComun(350)))
			add(new Asiento(4, "Ventanilla", new TarifaComun(350)))
			add(new Asiento(5, "Pasillo", new TarifaComun(450)))
			add(new Asiento(5, "Centro", new TarifaComun(180)))
			add(new Asiento(5, "Ventanilla", new TarifaComun(350)))			
			]

		var Set<Asiento> asientosLAN = new HashSet<Asiento>
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
		
	
		var List <Reserva> reservasParaUsr = new ArrayList <Reserva>
		reservasParaUsr => [
			add(new Reserva(asiento1, vueloAA))
			add(new Reserva(asiento2, vueloLAN))
			add(new Reserva(asiento3, vueloAA))
			add(new Reserva(asiento4, vueloLAN))
			]
		reservasParaUsr.forEach[usr.reservar(it)]
			
		var List <Reserva> reservasParaGabo = new ArrayList <Reserva>
			reservasParaGabo =>[
			add(new Reserva(asiento5, vueloAA))
			add(new Reserva(asiento6, vueloLAN))
			add(new Reserva(asiento7, vueloAA))]
		reservasParaGabo.forEach[gabo.reservar(it)]
					
		asientosAA.forEach[setVuelo(vueloAA)]
		asientosLAN.forEach[setVuelo(vueloLAN)]
		vueloLAN.asientos = asientosLAN
		vueloAA.asientos = asientosAA
		
	}
	
	def initVuelos() {
		initEscalas
		
		vueloAA = new Vuelo()
		vueloAA => [
			agregarEscala(escala1)
			aerolinea = "Aerolineas Argentinas"
			origen = ezeiza
			destino = ricafort
			fechaSalida = new GregorianCalendar(2016, Calendar.MARCH, 21).getTime();
			fechaLlegada = new GregorianCalendar(2016, Calendar.MARCH, 22).getTime();
		]

		vueloLAN = new Vuelo()
		vueloLAN => [ 
//			agregarEscala(escala1)  2 vuelos no pueden tener la misma escala.(escala tiene hora de salida, podria tener pista etc)
			agregarEscala(escala2)
			aerolinea = "LAN Airlines"
			origen = costanera
			destino = ponja
			fechaSalida = new GregorianCalendar(2016, Calendar.MARCH, 7).getTime();
			fechaLlegada = new GregorianCalendar(2016, Calendar.MARCH, 15).getTime();
		]
	}
	
	def initEscalas() {
		escala1 = new Escala()
		escala2 = new Escala()

		escala1 => [
			horaLlegada = new GregorianCalendar(2016, Calendar.MARCH, 7).getTime();
			destino = brazuca
		]
		escala2 =>[
			horaLlegada = new GregorianCalendar(2016, Calendar.MARCH, 8).getTime();
			destino = gotze
		]
	}
	
	def initUsuarios() {
		gabo = new Usuario("gabo", "gabo")
		gabo.nombre = "Gabriel Perez"
		usr = new Usuario("adrian", "adrian")
		usr.nombre = "Adrian Barbani"
		fede = new Usuario("fede", "fede")
		fede.nombre = "Federico Peña"
	}
	
	def initAeropuertos() {
		ezeiza = new Aeropuerto("Ezeiza", "Buenos Aires")
		costanera = new Aeropuerto("Aeroparque", "Buenos Aires")
		ricafort = new Aeropuerto("Miami International Airport", "Miami")
		brazuca = new Aeropuerto("Aeroporto Internacional de São Paulo", "San Pablo")
		gotze = new Aeropuerto("Aeropuerto Internacional de Múnich", "Munich")
		ponja = new Aeropuerto("Aeropuerto Internacional Haneda", "Tokio")
	}
	
	def crearVuelo(Vuelo vuelo) {
		val repoVuelos = VuelosRepositorio.instance
		if (repoVuelos.searchByExample(vuelo).isEmpty) {
			repoVuelos.create(vuelo)
			println("Vuelo " + vuelo.nombreOrigen +" a " + vuelo.nombreDestino + " creado")
		}
	}
	
	def crearUsuario(Usuario usuario) {
		val repoUsuarios = UsuarioRepositorio.instance
		if (repoUsuarios.searchByExample(usuario).isEmpty) {
			repoUsuarios.create(usuario)
			println("Usuario " + usuario.nombre + " creado")
		}
	}
	
	def void crearAeropuerto(Aeropuerto aeropuerto) {
		val repoAeropuertos = AeropuertosRepositorio.instance
		if (repoAeropuertos.searchByExample(aeropuerto).isEmpty) {
			repoAeropuertos.create(aeropuerto)
			println("Aeropuerto " + aeropuerto.nombre + " creado")
		}
	}
	
	override isPending() {
		false
	}
}