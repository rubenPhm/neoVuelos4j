package AppModel

import Dominio.Reserva
import Dominio.Usuario
import Repositorios.RepoAeropuertoNeo4j
import Repositorios.RepoUsuariosNeo4j
import Repositorios.RepoVuelosNeo4j
import Repositorios.VuelosRepositorio
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class VerReservasAppModel {

	Usuario usuario

	Reserva reservaSeleccionada = null

	RepoUsuariosNeo4j repoUsuarios = RepoUsuariosNeo4j.instance
	RepoAeropuertoNeo4j repoAeropuertos = RepoAeropuertoNeo4j.instance
	RepoVuelosNeo4j repoVuelos = RepoVuelosNeo4j.instance

	new(Usuario user) {
		usuario = user
	}

	def cancelarReserva(Reserva reserva) {
		usuario.eliminarReserva(reserva)
		repoUsuarios.saveOrUpdateUsuario(usuario)
		repoVuelos.update(reserva.vuelo)
		
	}
	
	def refresh(){}
}
