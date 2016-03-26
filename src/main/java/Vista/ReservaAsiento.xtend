package Vista

import AppModel.ReservaAsientoAppModel
import Dominio.Escala
import java.awt.Color
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import Dominio.Vuelo

class ReservaAsiento extends TransactionalDialog <ReservaAsientoAppModel> {

	new(WindowOwner parent, ReservaAsientoAppModel model) {
		super(parent, model)
	}
	
	override protected addActions(Panel actionsPanel) {
	}
	
	
	override protected createFormPanel(Panel mainPanel) {
		
	val linea1 = new Panel(mainPanel).layout = new HorizontalLayout
	val columna1 = new Panel(linea1).layout = new VerticalLayout
	new Label(columna1) => [
			text = "Usuario"]
				
	new Label(columna1).value <=> "unUsuario.nombre"
	
	val columnaX = new Panel(linea1).layout = new VerticalLayout
				
	new Label(columnaX).value <=> "unVuelo.origen.pais"
	new Label(columnaX).value <=> "unVuelo.fechaSalida"
	
	val columnaX2 = new Panel(linea1).layout = new VerticalLayout
				
	new Label(columnaX2).value <=> "unVuelo.destino.pais"
	new Label(columnaX2).value <=> "unVuelo.fechaLlegada"
	
	val linea2 = new Panel(mainPanel).layout = new HorizontalLayout
		val columna2 = new Panel(linea2).layout = new VerticalLayout
	
	new Label(columna2) => [
			text = "Tramos"]	
			
	val table = new Table<Escala>(columna2, typeof(Escala)) => [
			bindItemsToProperty("unVuelo.escalas")
		]

		new Column<Escala>(table) => [
			title = "Destino Intermedio"
			fixedSize = 200
			bindContentsToProperty("destino.pais")
		]

		new Column<Escala>(table) => [
			title = "Llegada"
			fixedSize = 100
			bindContentsToProperty("horaLlegada")
		]	
		
		
		
	val columna3 = new Panel(linea2).layout = new VerticalLayout
	new Label(columna3) => [
			text = "Aerolinea"
		]
	new Label(columna3).value <=> "unVuelo.aerolinea"
	
		
	
	new Label(mainPanel) => [
			text = "Asientos"]	

		(1 .. ReservaAsientoAppModel.MAX_ASIENTO).forEach [ i |
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
					onClick [ | modelObject.asientoSeleccionado = asiento ]
				]
			]
		]
		
		val linea3 = new Panel(mainPanel).layout = new HorizontalLayout
		val columna4 = new Panel(linea3).layout = new VerticalLayout
		
		new Label(columna4) => [
			text = "Asiento seleccionado"
			foreground = Color.BLUE
		]
		new Label(columna4).value <=> "asientoSeleccionado"
		
		
		val linea4 = new Panel(linea3).layout = new VerticalLayout
		
		new Label(linea4) => [
			text = "Monto a Pagar"
			foreground = Color.BLUE
		]
		new Label(linea4).value <=> "asientoSeleccionado.tarifa.precio"
		
		
		val linea5 = new Panel(linea3).layout = new VerticalLayout
		
		new Button(linea5) => [
			caption = "Reservar"
			onClick = [|
				modelObject.reservarAsiento
				this.accept
			]
			setAsDefault
			disableOnError
		]
		
	
		
		
	}

}