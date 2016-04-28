package Dominio

import java.text.SimpleDateFormat
import java.util.Date
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Entity
@Observable
@Accessors
class Escala {

	@Id
	@GeneratedValue
	private Long id
	
	//una escala tiene un aeropueto, pero un aeropueto puede tener muchas escalas
	@ManyToOne()
	Aeropuerto destino

	@Column
	Date horaLlegada

	@Column
	Date horaSalida
	
	@Column(length=150)
	String formatoVerFechas = "dd/MM/yyyy - hh:mm 'hs'"
//	SimpleDateFormat dateToString = new SimpleDateFormat("dd/MM/yyyy - hh:mm 'hs'")

	new(){}

	def getHoraSalidaStr() { new SimpleDateFormat(formatoVerFechas).format(horaSalida) }

	def getHoraLlegadaStr() { new SimpleDateFormat(formatoVerFechas).format(horaLlegada) }
}
