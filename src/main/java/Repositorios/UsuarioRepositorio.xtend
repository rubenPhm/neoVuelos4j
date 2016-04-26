package Repositorios

import Dominio.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Criteria
import org.hibernate.FetchMode
import org.hibernate.HibernateException
import org.hibernate.criterion.Restrictions
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class UsuarioRepositorio extends RepositorioDefault<Usuario> {
	static UsuarioRepositorio repositorio = null

	static public def UsuarioRepositorio getInstance() {
		if (repositorio == null) {
			repositorio = new UsuarioRepositorio()
		}
      repositorio
	}
	
	override getEntityType() {
		typeof(Usuario)
	}

	override addQueryByExample(Criteria criteria, Usuario usuario) {
		if (usuario.nombre != null) {
			criteria.add(Restrictions.eq("nombre", usuario.nombre))
		}
	}
	
	def Usuario searchByNickContrasenia(String nick, String contrasenia) {
		val session = openSession
		try {
			val usuarios = session.createCriteria(Usuario).setFetchMode("usuarios", FetchMode.JOIN).add(
				Restrictions.eq("nick", nick)).add( Restrictions.eq("contrasenia", contrasenia)).list
			if (usuarios.empty) {
				return null
			} else {
				return usuarios.head
			}
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
		
		}

	/*def registrarUsuario(String nick, String contrasenia) {
		if (todosLosUsuarios.exists[usr|usr.nick == nick]) {
			throw new UserException("El nombre de usuario: " + nick + " ya existe")
		} else {
			val Usuario usuario = new Usuario(nick, contrasenia)
			todosLosUsuarios.add(usuario)
		}
	} */


}
