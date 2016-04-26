package Repositorios

import Dominio.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class UsuarioRepositorio extends RepositorioDefault<Usuario> {
	static UsuarioRepositorio repositorio = null

	//List<Usuario> todosLosUsuarios = new ArrayList<Usuario>

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

	/*def registrarUsuario(String nick, String contrasenia) {
		if (todosLosUsuarios.exists[usr|usr.nick == nick]) {
			throw new UserException("El nombre de usuario: " + nick + " ya existe")
		} else {
			val Usuario usuario = new Usuario(nick, contrasenia)
			todosLosUsuarios.add(usuario)
		}
	} 

	def Usuario obtenerUsuario(String nick, String contrasenia) {
		val Usuario usuario = todosLosUsuarios.findFirst[usr|usr.nick == nick && usr.contrasenia == contrasenia]
		return usuario;
	}*/

}
