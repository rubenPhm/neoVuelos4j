package AppModel

import Dominio.Usuario
import Repositorios.UsuarioRepositorio
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable
import Repositorios.RepoUsuariosNeo4j
import Repositorios.UsuarioToNodeConverter
import org.neo4j.graphdb.Node
import Repositorios.GraphDatabaseProvider
import org.neo4j.kernel.impl.factory.GraphDatabaseFacade
import org.neo4j.kernel.impl.factory.GraphDatabaseFacadeFactory
import org.neo4j.graphdb.factory.GraphDatabaseFactory

@Observable
@Accessors
class LoginAppModel {
	
	String contrasenia
	String nick
	Usuario usuario
	
	new (){
	}
	
	def autorizarLogin() {
		//UsuarioRepositorio.getInstance.searchByNickContrasenia(nick, contrasenia)
		usuario = RepoUsuariosNeo4j.getInstance.searchByNickContrasenia(nick, contrasenia)
		//val user = RepoUsuariosNeo4j.getInstance.getUsuario(usuario.id)
	    usuario = RepoUsuariosNeo4j.getInstance.getUsuario(usuario.id)
		//RepoUsuariosNeo4j.getInstance.crearRelaciones(usuario)
		if(usuario == null){
			throw new UserException ("El Usuario o Contraseña ingresados no son correctos")
		}	
	}
}