package Runnable

import Dominio.Usuario
import Vista.BusquedaVuelo
import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import AppModel.BusquedaVueloAppModel

class RunAplication extends Application {

	static def void main(String[] args) {
		new RunAplication().start()
	}

	override protected Window<?> createMainWindow() {
		
		//return new Login(this)
		var Usuario usr = new Usuario("adrian","adrian")
      return new BusquedaVuelo(this, new BusquedaVueloAppModel(usr))
	}

}
