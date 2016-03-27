package Dominio

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.text.SimpleDateFormat

@Observable
@Accessors
class Escala {
	
	Aeropuerto destino
	Date horaLlegada
	Date horaSalida
	
	
	SimpleDateFormat dateToString = new SimpleDateFormat("dd/MM/yyyy - hh:mm 'hs'")
	
	def getHoraSalidaStr(){ dateToString.format(horaSalida)}
	def getHoraLlegadaStr(){ dateToString.format(horaLlegada)}
}