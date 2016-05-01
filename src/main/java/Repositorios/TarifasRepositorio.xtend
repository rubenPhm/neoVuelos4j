package Repositorios

import Dominio.Tarifa
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions

class TarifasRepositorio extends RepositorioDefault <Tarifa> {
	static TarifasRepositorio repositorio = null
	
	static public def TarifasRepositorio getInstance() {
		if (repositorio == null) {
			repositorio = new TarifasRepositorio()
		}
      repositorio
	}
	
	override getEntityType() {
		typeof(Tarifa)
	}

	override addQueryByExample(Criteria criteria, Tarifa tarifa) {
		if (tarifa.precio != 0) {
			criteria.add(Restrictions.eq("precio", tarifa.precio))
		}
	}
}