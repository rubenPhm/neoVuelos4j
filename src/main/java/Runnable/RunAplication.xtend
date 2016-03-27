package Runnable

import AppModel.BusquedaVueloAppModel
import Repositorios.Build
import Vista.BusquedaVuelo
import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window

class RunAplication extends Application {

	static def void main(String[] args) {
		new RunAplication().start()
	}

	override protected Window<?> createMainWindow() {

		var Build builder = new Build()
	   	return new BusquedaVuelo(this, new BusquedaVueloAppModel(builder.usr))
//     	return new ReservaAsiento(this, new ReservaAsientoAppModel(usr, vuelo, asientos))
      
	}

}
