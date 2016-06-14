package Dominio

import java.text.SimpleDateFormat
import java.util.Date
import java.util.HashSet
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Embedded
import org.mongodb.morphia.annotations.Transient
import org.uqbar.commons.utils.Observable

@Entity
@Accessors
@Observable
@Embedded	
class Vuelo {
	@org.mongodb.morphia.annotations.Id ObjectId 
	idMongo
	
	Long idNeo
	
	@Id
	@GeneratedValue
	private Long id
	
	@ManyToOne
	Aeropuerto origen

	@ManyToOne
	Aeropuerto destino

	@Column(length=150)
	String aerolinea
	
	@Transient
	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	Set<Asiento> asientos = new HashSet

	@Column
	Date fechaSalida

	@Column
	Date fechaLlegada
	
	@Transient
	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	Set<Escala> escalas = new HashSet
	
	@Transient
	transient static SimpleDateFormat dateToString = new SimpleDateFormat("dd/MM/yyyy - hh:mm 'hs'")

//	estas 2 se crean para persistir en mongo, ya que las escalas y los asientos son transient
	int asientosLibres
	int numEscalas

	new() {
	}

	def agregarEscala(Escala escala) {
		escalas.add(escala)
	}

	def conDestino(String destinoStr) {
		destino.nombre.equals(destinoStr)
	}

	def conOrigen(String origenStr) {
		origen.nombre.equals(origenStr)
	}

	def conTarifaMenorA(Double valor) {
		asientos.exists[conPrecioMaximo(valor)]
	}

	def asientosValorMaximo(Double valor) {
		asientos.filter[conPrecioMaximo(valor)].toList
	}

	def llegaAntesQue(Date unaFecha) {
		fechaLlegada.before(unaFecha)
	}

	def saleAntesQue(Date unaFecha) {
		fechaSalida.before(unaFecha)
	}

	def getNombreOrigen() { origen.nombre }

	def getNombreDestino() { destino.nombre }

	def getCantidadEscalas() { escalas.size }
	
	def getCantidadDeAsientosLibres() {	asientos.filter[disponible].toList.size()}

	def getFechaSalidaStr() { dateToString.format(fechaSalida) }

	def getFechaLlegadaStr() { dateToString.format(fechaLlegada) }
	
	def calcularAsientosDisponibles(){	asientosLibres = this.getCantidadDeAsientosLibres()	}
	
	def calcularEscalas(){numEscalas = this.getCantidadEscalas()}

}
