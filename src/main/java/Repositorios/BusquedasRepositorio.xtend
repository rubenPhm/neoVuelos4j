package Repositorios

import Dominio.Busqueda
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import Dominio.Usuario
import java.util.Date

@Accessors
@Observable
class BusquedasRepositorio {
	static BusquedasRepositorio repositorio = null

	List<Busqueda> todasLasBusquedas = new ArrayList<Busqueda>

	static public def BusquedasRepositorio getInstance() {
		if (repositorio == null) {
			repositorio = new BusquedasRepositorio()
		}
		repositorio
	}

	def guardarBusquedas(Busqueda busqueda) {
		println(busqueda.resultados.size())
		todasLasBusquedas.add(busqueda)
	}

	def buscar(Usuario usr, Date fechaDesde, Date fechaHasta) {

		var List<Busqueda> busquedasAFiltrar = newArrayList

		busquedasAFiltrar = filtrarPorUsuario(usr, todasLasBusquedas)
		busquedasAFiltrar = filtrarPorFechaDesde(fechaDesde, busquedasAFiltrar)
		busquedasAFiltrar = filtrarPorFechaHasta(fechaHasta, busquedasAFiltrar)

		busquedasAFiltrar
	}

	def filtrarPorFechaHasta(Date fecha, List<Busqueda> busquedas) {
		if (fecha != null) {
			busquedas.filter[busqueda|busqueda.fechaRealizacion <= fecha].toList
		} else {
			busquedas
		}
	}

	def filtrarPorFechaDesde(Date fecha, List<Busqueda> busquedas) {
		if (fecha != null) {
			busquedas.filter[busqueda|busqueda.fechaRealizacion >= fecha].toList
		} else {
			busquedas
		}
	}

	def filtrarPorUsuario(Usuario usuario, List<Busqueda> busquedas) {
		if (usuario != null) {
			busquedas.filter[busqueda|busqueda.quienBusca == usuario].toList
		} else {
			busquedas
		}
	}

}
