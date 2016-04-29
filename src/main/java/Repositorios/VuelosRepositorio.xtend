package Repositorios

import Dominio.Busqueda
import Dominio.Vuelo
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Criteria
import org.hibernate.HibernateException
import org.hibernate.criterion.Restrictions
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class VuelosRepositorio extends RepositorioDefault<Vuelo> {

//	Set<Vuelo> todosLosVuelos = newHashSet
//	List<Busqueda> busquedasRealizadas = newArrayList
//	Set<Vuelo> vuelosBuffer = newHashSet
	static VuelosRepositorio repositorio = null

	static public def VuelosRepositorio getInstance() {
		if (repositorio == null) {
			repositorio = new VuelosRepositorio()
		}
		repositorio
	}

	def Set<Vuelo> searchByBusqueda(Busqueda unaBusqueda) {
		val session = openSession
		try {
			val criteria = session.createCriteria(entityType)
			if(unaBusqueda.desdeFecha != null){criteria.add(Restrictions.le("fechaSalida", unaBusqueda.desdeFecha))}
			if(unaBusqueda.hastaFecha != null){criteria.add(Restrictions.ge("fechaLlegada", unaBusqueda.hastaFecha))}
			if (unaBusqueda.origen != null) {criteria.add(Restrictions.eq("origen", unaBusqueda.origen))}
			if (unaBusqueda.destino != null) {criteria.add(Restrictions.eq("destino", unaBusqueda.destino))}
			
//			val aliasAsientos = criteria.createAlias("asientos", "asientos")
//			if (unaBusqueda.maxPrecio != 0) {
//				val aliasTarifa = aliasAsientos.createAlias("tarifa", "tarifa")
//				aliasTarifa.add(Restrictions.lt("precio",unaBusqueda.maxPrecio))
//				aliasAsientos.add(Restrictions.lt("tarifa.precio", unaBusqueda.maxPrecio))
//			}
			criteria.list.toSet
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	override getEntityType() { typeof(Vuelo) }

	override addQueryByExample(Criteria criteria, Vuelo vuelo) {
		if (vuelo.origen != null) {
			criteria.add(Restrictions.eq("aerolinea", vuelo.aerolinea))
		}
	}
}

