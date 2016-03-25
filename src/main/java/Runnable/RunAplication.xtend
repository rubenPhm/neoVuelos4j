package Runnable

import Dominio.Usuario
import Vista.BusquedaVuelo
import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import AppModel.BusquedaVueloAppModel
import Dominio.Vuelo
import AppModel.ReservaAsientoAppModel
import Vista.ReservaAsiento

class RunAplication extends Application {

	static def void main(String[] args) {
		new RunAplication().start()
	}

	override protected Window<?> createMainWindow() {
		
		//return new Login(this)
		var Usuario usr = new Usuario("adrian","adrian")
		var Vuelo vuelo = new Vuelo()
      //return new BusquedaVuelo(this, new BusquedaVueloAppModel(usr))
      return new ReservaAsiento(this, new ReservaAsientoAppModel(usr, vuelo))
      
	}

}