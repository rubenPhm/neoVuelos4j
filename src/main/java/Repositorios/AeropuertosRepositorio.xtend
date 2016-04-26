
package Repositorios

import Dominio.Aeropuerto
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class AeropuertosRepositorio extends RepositorioDefault<Aeropuerto> {
	static AeropuertosRepositorio repositorio = null
	
	/*public List<Aeropuerto> todosLosAeropuertos = new ArrayList<Aeropuerto>
	
		def nombreDeTodosLosAeropuertos() {
		todosLosAeropuertos.map[ aeropuerto | aeropuerto.nombre ].toList
	}*/
	
	static public def AeropuertosRepositorio getInstance() {
		if (repositorio == null) {
			repositorio = new AeropuertosRepositorio()
		}
      repositorio
	}
	
	override getEntityType() {
		typeof(Aeropuerto)
	}

	override addQueryByExample(Criteria criteria, Aeropuerto aeropuerto) {
		if (aeropuerto.nombre != null) {
			criteria.add(Restrictions.eq("nombre", aeropuerto.nombre))
		}
	}
	
	
}

