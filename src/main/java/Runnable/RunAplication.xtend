package Runnable

import AppModel.BusquedaVueloAppModel
import Dominio.Aeropuerto
import Dominio.Asiento
import Dominio.Escala
import Dominio.Tarifa
import Dominio.Usuario
import Dominio.Vuelo
import Repositorios.AeropuertosRepositorio
import Repositorios.VuelosRepositorio
import Vista.BusquedaVuelo
import java.util.ArrayList
import java.util.Calendar
import java.util.List
import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window

class RunAplication extends Application {

	static def void main(String[] args) {
		new RunAplication().start()
	}

	override protected Window<?> createMainWindow() {
		
		
		var Aeropuerto ezeiza = new Aeropuerto("Ezeiza", "Buenos Aires") 
		var Aeropuerto costanera = new Aeropuerto("Aeroparque", "Buenos Aires") 
		var Aeropuerto ricafort = new Aeropuerto ("Miami", "EEUU")
		var Aeropuerto brazuca = new Aeropuerto ("San Pablo", "Brasil")
	
		AeropuertosRepositorio.getInstance().todosLosAeropuertos.add(ezeiza)
		AeropuertosRepositorio.getInstance().todosLosAeropuertos.add(costanera)
		AeropuertosRepositorio.getInstance().todosLosAeropuertos.add(ricafort)
		AeropuertosRepositorio.getInstance().todosLosAeropuertos.add(brazuca)
		
		
		var Usuario gabo = new Usuario("gabo","gabo")
			gabo.nombre = "Gabriel Perez"
		var Usuario usr = new Usuario("adrian","adrian")
			usr.nombre = "Adrian Barbani"
		
		
				
		
		//return new Login(this)

		var Vuelo vuelo = new Vuelo()
		var Escala escala1 = new Escala()
		escala1.horaLlegada = Calendar.getInstance.getTime()
		escala1.destino = brazuca
		
		var misEscalas = new ArrayList <Escala>
		
		misEscalas.add(escala1) 
		vuelo.escalas = misEscalas
		vuelo.aerolinea = "Aerolineas Argentinas"
		vuelo.origen = ezeiza
		vuelo.destino = ricafort
		vuelo.fechaSalida = Calendar.getInstance.getTime()
		vuelo.fechaLlegada = Calendar.getInstance.getTime()
		var List<Asiento> asientos = new ArrayList <Asiento>
		
		var asiento1 = new Asiento(1, "centro", new Tarifa(200))
		asiento1.duenio = usr
			
		asientos.add(asiento1)
		asientos.add(new Asiento(2, "medio", new Tarifa(150)))
		asientos.add(new Asiento(4, "centro", new Tarifa(350)))
		asientos.add(new Asiento(6, "medio", new Tarifa(450)))
		asientos.add(new Asiento(9, "centro",new Tarifa(180)))
		asientos.add(new Asiento(7, "medio", new Tarifa(190)))
		asientos.add(new Asiento(5, "centro", new Tarifa(460)))
		
		vuelo.asientos = asientos
		
		VuelosRepositorio.getInstance().todosLosVuelos.add(vuelo)
		
	   	return new BusquedaVuelo(this, new BusquedaVueloAppModel(usr))
//     	return new ReservaAsiento(this, new ReservaAsientoAppModel(usr, vuelo, asientos))
      
	}

}
