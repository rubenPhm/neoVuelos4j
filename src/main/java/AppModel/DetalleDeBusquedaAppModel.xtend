package AppModel

import Dominio.Busqueda
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class DetalleDeBusquedaAppModel {
	
	Busqueda busqueda
	
	new(Busqueda unaBusqueda) {
		busqueda = unaBusqueda
	}
	
	def getCriterio(){
		busqueda.criterioDeBusqueda
	}
	
	def getHorarioConsulta(){
		busqueda.fechaRealizacion
	}
}