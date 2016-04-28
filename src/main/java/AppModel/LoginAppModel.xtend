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
	
	new (){
	}
	
	def autorizarLogin() {
		usuario = UsuarioRepositorio.getInstance.searchByNickContrasenia(nick, contrasenia)
		if(usuario == null){
			throw new UserException ("El Usuario o Contraseña ingresados no son correctos")
		}	
	}
}