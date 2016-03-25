package Runnable

import AppModel.ReservaAsientoAppModel
import Dominio.Aeropuerto
import Dominio.Asiento
import Dominio.Tarifa
import Dominio.Usuario
import Dominio.Vuelo
import Vista.ReservaAsiento
import java.util.Calendar
import java.util.List
import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window

class RunAplication extends Application {

	static def void main(String[] args) {
		new RunAplication().start()
	}

	override protected Window<?> createMainWindow() {
		
		
		var ezeiza = new Aeropuerto("ezeiza", "Buenos Aires") 
		var aeroplata = new Aeropuerto ("aeroplata", "Mar del Plata")
		
				
		
		//return new Login(this)
		var Usuario usr = new Usuario("adrian","adrian")

		usr.nombre = "Adrian Barbani"
		var Vuelo vuelo = new Vuelo()
		vuelo.aerolinea = "Aerolineas Argentinas"
		vuelo.origen = ezeiza
		vuelo.destino = aeroplata
		vuelo.fechaSalida = Calendar.getInstance.getTime()
		vuelo.fechaLlegada = Calendar.getInstance.getTime()
		var List<Asiento> asientos = newArrayList
		
		var asiento1 = new Asiento(1, "centro")
		asiento1.duenio = usr
		asientos.add(asiento1)
		var Tarifa tarifa = new Tarifa()
		tarifa.precio = 200
		asiento1.tarifa = tarifa
		
		asientos.add(new Asiento(2, "medio"))
		asientos.add(new Asiento(4, "centro"))
		asientos.add(new Asiento(6, "medio"))
		asientos.add(new Asiento(9, "centro"))
		asientos.add(new Asiento(7, "medio"))
		asientos.add(new Asiento(5, "centro"))
      //return new BusquedaVuelo(this, new BusquedaVueloAppModel(usr))
      return new ReservaAsiento(this, new ReservaAsientoAppModel(usr, vuelo, asientos))
      
	}

}
