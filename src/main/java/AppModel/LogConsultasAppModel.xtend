package AppModel

import Dominio.Busqueda
import Dominio.Usuario
import Repositorios.BusquedasRepositorio
import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class LogConsultasAppModel {

	Date fechaDesde
	Date fechaHasta

	Usuario usr

	Busqueda busquedaSeleccionada = null

	List<Busqueda> resultados = newArrayList
	
	new(Usuario usuario) {
		usr = usuario
	}

	def clear() {
		fechaDesde = null
		fechaHasta = null
	}
	
	def buscar(){
		resultados = BusquedasRepositorio.getInstance.buscar(usr, fechaDesde, fechaHasta)
		println(resultados.get(0).resultados.size())
	}
}
