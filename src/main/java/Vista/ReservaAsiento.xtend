package Vista

import AppModel.ReservaAsientoAppModel
import Dominio.Escala
import java.awt.Color
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class ReservaAsiento extends TransactionalDialog<ReservaAsientoAppModel> {

	new(WindowOwner parent, ReservaAsientoAppModel model) {
		super(parent, model)
		title = "Reserva de Asientos"
	}

	override protected addActions(Panel actionsPanel) {
	}

	override protected createFormPanel(Panel mainPanel) {
	
		
		this.labelUsuarioOrigenYDestino(mainPanel)
		
		this.tablaTramosYAerolinea(mainPanel)
		
		this.asientos(mainPanel)
		
		this.ultimaLinea(mainPanel)

	}

	protected def ultimaLinea(Panel mainPanel) {
		val linea = new Panel(mainPanel).layout = new HorizontalLayout
		val columna = new Panel(linea).layout = new VerticalLayout

		new Label(columna) => [
			text = "Asiento seleccionado"
			foreground = Color.BLUE
		]
		new Label(columna).value <=> "asientoSeleccionado"

		val columna2 = new Panel(linea).layout = new VerticalLayout

		new Label(columna2) => [
			text = "Monto a Pagar"
			foreground = Color.BLUE
		]
		new Label(columna2).value <=> "asientoSeleccionado.precio"

		val columna3 = new Panel(linea).layout = new VerticalLayout

		new Button(columna3) => [
			caption = "Reservar"
			onClick [|
				modelObject.reservarAsiento
			]
			setAsDefault
			disableOnError
		]
	}

	protected def asientos(Panel mainPanel) {
		val columna = new Panel(mainPanel).layout = new VerticalLayout

		new Label(columna) => [ value <=>"alertaReserva"
					fontSize = 20
		]
		
		
		new Label(columna) => [text = "Asientos"
			(1 .. ReservaAsientoAppModel.cantidadAsientos).forEach [ i |
				val filaPanel = new Panel(mainPanel)
				filaPanel.layout = new HorizontalLayout
				modelObject.asientosDeFila(i).forEach [ asiento |
					new Button(filaPanel) => [
						if (asiento.disponible) {
							background = Color.GREEN
						} else {
							background = Color.RED
						}
						caption = asiento.toString
						onClick [|modelObject.asientoSeleccionado = asiento]
					]
				]
			]]
	}

	protected def tablaTramosYAerolinea(Panel mainPanel) {
		val linea = new Panel(mainPanel).layout = new HorizontalLayout
		val columna = new Panel(linea).layout = new VerticalLayout

		new Label(columna) => [text = "Tramos"]

		val table = new Table<Escala>(columna, typeof(Escala)) => [
			bindItemsToProperty("unVuelo.escalas")
		]

		new Column<Escala>(table) => [
			title = "Destino Intermedio"
			fixedSize = 200
			bindContentsToProperty("destino.pais")
		]

		new Column<Escala>(table) => [
			title = "Llegada"
			fixedSize = 200
			bindContentsToProperty("horaLlegadaStr")
		]
		
		val columna2 = new Panel(linea).layout = new VerticalLayout
		new Label(columna2) => [
			text = "Aerolinea"
		]
		new Label(columna2).value <=> "unVuelo.aerolinea"
		linea
		
	}

	protected def labelUsuarioOrigenYDestino(Panel mainPanel) {
		val linea = new Panel(mainPanel).layout = new HorizontalLayout
		val columna1 = new Panel(linea).layout = new VerticalLayout
		new Label(columna1) => [text = "Usuario"]
		new Label(columna1).value <=> "unUsuario.nombre"

		val columna2 = new Panel(linea).layout = new VerticalLayout

		new Label(columna2).value <=> "unVuelo.origen.pais"
		new Label(columna2).value <=> "unVuelo.fechaSalidaStr"

		val columna3 = new Panel(linea).layout = new VerticalLayout

		new Label(columna3).value <=> "unVuelo.destino.pais"
		new Label(columna3).value <=> "unVuelo.fechaLlegadaStr"
		linea
	}

}
