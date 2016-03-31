package AppModel

import Dominio.Usuario
import Repositorios.UsuarioRepositorio
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class LoginAppModel {
	
	String contrasenia
	String nick
	Usuario usuario
	
//	new(Usuario unUsuario) {
//		contrasenia = unUsuario.contrasenia
//		nick = unUsuario.nick
//		usuario = unUsuario
//		
//	}
	
	new (){
		
	}
	
	def autorizarLogin() {
		usuario = UsuarioRepositorio.getInstance.obtenerUsuario(nick, contrasenia);
		
		if(usuario == null){
			throw new UserException ("El Usuario o Contraseña ingresados no son correctos")
		}	
	}
	
	
	
}