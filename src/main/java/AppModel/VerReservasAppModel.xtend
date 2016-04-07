package AppModel

import Dominio.Reserva
import Dominio.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

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
	}
	
}
