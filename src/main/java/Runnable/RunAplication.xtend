package Runnable

import AppModel.ReservaAsientoAppModel
import Dominio.Asiento
import Dominio.Tarifa
import Dominio.Usuario
import Dominio.Vuelo
import Vista.ReservaAsiento
import java.util.List
import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window

class RunAplication extends Application {

	static def void main(String[] args) {
		new RunAplication().start()
	}

	override protected Window<?> createMainWindow() {
		
		//return new Login(this)
		var Usuario usr = new Usuario("adrian","adrian")
		var Vuelo vuelo = new Vuelo()
		var List<Asiento> asientos = newArrayList
		var asiento1 = new Asiento(1, "centro")
		asiento1.duenio = usr
		asientos.add(asiento1)
		var Tarifa tarifa = new Tarifa()
		tarifa.precio = 200
		asiento1.tarifa = tarifa
		
		asientos.add(new Asiento(2, "medio"))
      //return new BusquedaVuelo(this, new BusquedaVueloAppModel(usr))
      return new ReservaAsiento(this, new ReservaAsientoAppModel(usr, vuelo, asientos))
      
	}

}