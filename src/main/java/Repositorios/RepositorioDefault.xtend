package Repositorios

import Dominio.Aeropuerto
import Dominio.Asiento
import Dominio.Busqueda
import Dominio.Escala
import Dominio.Reserva
import Dominio.Tarifa
import Dominio.TarifaBandaNegativa
import Dominio.TarifaComun
import Dominio.TarifaEspecial
import Dominio.Usuario
import Dominio.Vuelo
import java.util.List
import org.hibernate.Criteria
import org.hibernate.HibernateException
import org.hibernate.SessionFactory
import org.hibernate.cfg.AnnotationConfiguration

abstract class RepositorioDefault<T> {
	private static final SessionFactory sessionFactory = new AnnotationConfiguration()
		.configure()
		.addAnnotatedClass(Aeropuerto)
		.addAnnotatedClass(Asiento)
		.addAnnotatedClass(Busqueda)
		.addAnnotatedClass(Escala)
		.addAnnotatedClass(Reserva)
		.addAnnotatedClass(Tarifa)
		.addAnnotatedClass(TarifaBandaNegativa)
		.addAnnotatedClass(TarifaComun)
		.addAnnotatedClass(TarifaEspecial)
		.addAnnotatedClass(Vuelo)
		.addAnnotatedClass(Usuario)
		.buildSessionFactory()

	def List<T> allInstances() {
		val session = openSession
		try {
			return session.createCriteria(getEntityType).list()
		} finally {
			session.close
		}
	}

	def List<T> searchByExample(T t) {
		val session = openSession
		try {
			val criteria = session.createCriteria(getEntityType)
			this.addQueryByExample(criteria, t)
			return criteria.list()
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def void create(T t) {
		val session = openSession
		try {
			session.beginTransaction
			session.save(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def void update(T t) {
		val session = openSession
		try {
			session.beginTransaction
			session.update(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def openSession() {
		sessionFactory.openSession
	}

	def abstract Class<T> getEntityType()

	def abstract void addQueryByExample(Criteria criteria, T t)
}