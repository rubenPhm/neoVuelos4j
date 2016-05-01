 	package Runnable

import Dominio.Aeropuerto
import Dominio.Asiento
import Dominio.Escala
import Dominio.Reserva
import Dominio.Tarifa
import Dominio.TarifaBandaNegativa
import Dominio.TarifaComun
import Dominio.TarifaEspecial
import Dominio.Usuario
import Dominio.Vuelo
import Repositorios.AeropuertosRepositorio
import Repositorios.TarifasRepositorio
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
	
	TarifaComun tarifa_1
	TarifaComun tarifa_2
	TarifaComun tarifa_3
	TarifaEspecial tEspecial_1
	TarifaEspecial tEspecial_2
	TarifaEspecial tEspecial_3
	TarifaBandaNegativa tBNegativa_1
	TarifaBandaNegativa tBNegativa_2
	TarifaBandaNegativa tBNegativa_3
	
	override run() {
		initAeropuertos
		initUsuarios
		initVuelos
		initTarifas
		initAsientos
		
		crearEntidades
	}
	
	def initTarifas() {
		tarifa_1 = new TarifaComun(150)
		tarifa_2 = new TarifaComun(1)
		tarifa_3 = new TarifaComun(532)
		tEspecial_1 = new TarifaEspecial(543,44)
		tEspecial_2 = new TarifaEspecial(56,8)
		tEspecial_3 = new TarifaEspecial(742,345)
		tBNegativa_1 = new TarifaBandaNegativa(99)
		tBNegativa_2 = new TarifaBandaNegativa(1235)
		tBNegativa_3 = new TarifaBandaNegativa(6)	
	}
	
	def crearEntidades() {
		// TODO: Analizar qué tienen que cambiar al sacar el cascade
		// Tarifas?
		crearTarifa(tBNegativa_3)
		crearTarifa(tarifa_1)
		crearTarifa(tarifa_2)
		crearTarifa(tarifa_3)
		crearTarifa(tEspecial_1)
		crearTarifa(tEspecial_2)
		crearTarifa(tEspecial_3)
		crearTarifa(tBNegativa_1)
		crearTarifa(tBNegativa_2)
		
		
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
		val Asiento asiento1 = new Asiento(1, "Pasillo", tarifa_1)
		val Asiento asiento2 = new Asiento(1, "Centro", tEspecial_1)
		val Asiento asiento3 = new Asiento(1, "Ventanilla", tBNegativa_1)
		val Asiento asiento4 = new Asiento(2, "Pasillo", tarifa_2)
		val Asiento asiento5 = new Asiento(4, "Pasillo", tarifa_1)
		val Asiento asiento6 = new Asiento(8, "Ventanilla", tBNegativa_2)
		val Asiento asiento7 = new Asiento(1, "Ventanilla", tEspecial_2)
		
		var Set<Asiento> asientosAA = new HashSet<Asiento>
		asientosAA => [
			add(asiento1)
			add(asiento3)
			add(asiento5)
			add(asiento7)
			add(new Asiento(1, "Pasillo", tarifa_1))
			add(new Asiento(1, "Centro", tBNegativa_1))
			add(new Asiento(2, "Pasillo", tEspecial_2))
			add(new Asiento(2, "Centro", tBNegativa_3))
			add(new Asiento(2, "Ventanilla", tEspecial_1))
			add(new Asiento(3, "Pasillo", tarifa_1))
			add(new Asiento(3, "Centro", tBNegativa_2))
			add(new Asiento(3, "Ventanilla", tEspecial_3))
			add(new Asiento(4, "Centro", tBNegativa_1))
			add(new Asiento(4, "Ventanilla", tarifa_2))
			add(new Asiento(5, "Pasillo", tEspecial_1))
			add(new Asiento(5, "Centro", tarifa_1))
			add(new Asiento(5, "Ventanilla", tarifa_3))			
			]

		var Set<Asiento> asientosLAN = new HashSet<Asiento>
		asientosLAN => [
			add(new Asiento(6, "Pasillo", tarifa_3))
			add(new Asiento(6, "Centro", tBNegativa_3))
			add(new Asiento(6, "Ventanilla", tEspecial_2))
			add(new Asiento(7, "Pasillo", tBNegativa_2))
			add(new Asiento(7, "Centro", tarifa_1))
			add(new Asiento(7, "Ventanilla", tarifa_3))
			add(new Asiento(8, "Pasillo", tBNegativa_1))
			add(new Asiento(8, "Centro", tEspecial_1))
			add(new Asiento(9, "Pasillo", tarifa_2))
			add(new Asiento(9, "Centro", tEspecial_2))
			add(new Asiento(9, "Ventanilla", tarifa_1))
			add(asiento2)
			add(asiento4)
			add(asiento6)]
		
	
		var List <Reserva> reservasParaUsr = new ArrayList <Reserva>
		reservasParaUsr => [
			add(new Reserva(asiento1))
			add(new Reserva(asiento2))
			add(new Reserva(asiento3))
			add(new Reserva(asiento4))
			]
		reservasParaUsr.forEach[usr.reservar(it)]
			
		var List <Reserva> reservasParaGabo = new ArrayList <Reserva>
			reservasParaGabo =>[
			add(new Reserva(asiento5))
			add(new Reserva(asiento6))
			add(new Reserva(asiento7))]
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
		
	def crearTarifa(Tarifa tarifa) {
		val repoTarifas = TarifasRepositorio.instance
		if (repoTarifas.searchByExample(tarifa).isEmpty) {
			repoTarifas.create(tarifa)
			println("Tarifa con valor " + tarifa.id.toString + " creada")
		}
	}
	
	override isPending() {
		false
	}
}