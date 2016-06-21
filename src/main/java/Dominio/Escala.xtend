package Dominio

import java.text.SimpleDateFormat
import java.util.Date
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Embedded
import org.uqbar.commons.utils.Observable

@Entity
@Observable
@Accessors
@Embedded
class Escala {

	@Id
	@GeneratedValue
	private Long id
	
	//una escala tiene un aeropueto, pero un aeropueto puede tener muchas escalas
	@ManyToOne
	Aeropuerto destino

	@Column
	Date horaLlegada

	@Column
	Date horaSalida
	
	transient static SimpleDateFormat dateToString = new SimpleDateFormat("dd/MM/yyyy - hh:mm 'hs'")

	new(){}

	def getHoraSalidaStr() { dateToString.format(horaSalida) }

	def getHoraLlegadaStr() { dateToString.format(horaLlegada) }
}
