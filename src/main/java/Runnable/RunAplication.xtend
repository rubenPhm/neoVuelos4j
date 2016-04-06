package Runnable

import AppModel.LoginAppModel
import Repositorios.Build
import Vista.Login
import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window

class RunAplication extends Application {

	static def void main(String[] args) {
		new RunAplication().start()
	}

	override protected Window<?> createMainWindow() {
		new Build()
		return new Login(this, new LoginAppModel())
	}

}
