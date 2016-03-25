package Dominio

import java.util.List
import java.util.Date

class Vuelo {
	
	Aeropuerto origen
	Aeropuerto destino
	String aerolinea
	List <Asiento> asientos
	Date fechaSalida
	Date fechaLlegada
	List<Escala> escalas
}