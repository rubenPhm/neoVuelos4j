package AppModel

import Dominio.Reserva
import Dominio.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import Repositorios.UsuarioRepositorio
import Repositorios.VuelosRepositorio
import Repositorios.RepoUsuariosNeo4j

@Observable
@Accessors
class VerReservasAppModel {

	Usuario usuario

	Reserva reservaSeleccionada = null

	new(Usuario user) {
		usuario = user
	}

	def cancelarReserva(Reserva reserva) { 
		usuario.eliminarReserva(reserva)
		//UsuarioRepositorio.instance.update(usuario)
		RepoUsuariosNeo4j.instance.saveOrUpdateUsuario(usuario)
		VuelosRepositorio.instance.update(reserva.vuelo)
		
	}
	
	def refresh(){}
}
