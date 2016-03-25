package AppModel

import Dominio.Asiento
import Dominio.Vuelo
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import Dominio.Usuario

@Observable
@Accessors
class ReservaAsientoAppModel {
	
	Vuelo unVuelo
	Usuario unUsuario
	List<Asiento> asientos = newArrayList
	Asiento asientoSeleccionado
	
	public static int MAX_ASIENTO = 10

	new (Usuario usr, Vuelo vuelo){

      unUsuario = usr
      unVuelo = vuelo
      this.initAsientos()
}
	
	new() {
		this.initAsientos()
	}

	def void initAsientos() {
		(1..MAX_ASIENTO).forEach [ i |
			asientos.add(new Asiento(i, "Pasillo"))
			asientos.add(new Asiento(i, "Centro"))
			asientos.add(new Asiento(i, "Ventanilla"))
		]
	}
	
	def asientosDeFila(int filaPedida) {
		asientos.filter [ it.fila == filaPedida ]
	}
	
	def reservarAsiento (){
		
	}
	
}
