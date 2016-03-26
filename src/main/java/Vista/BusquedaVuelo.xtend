package Vista

import AppModel.BusquedaVueloAppModel
import AppModel.ReservaAsientoAppModel
import Dominio.Vuelo
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.VerticalLayout

class BusquedaVuelo extends SimpleWindow<BusquedaVueloAppModel> {

	new(WindowOwner owner, BusquedaVueloAppModel model) {
		super(owner, model)
		title = "Busqueda de vuelos"
	}

	override protected addActions(Panel actionsPanel) {
		this.botonera(actionsPanel)
	}

	override protected createFormPanel(Panel mainPanel) {
		this.panelDeBusqueda(mainPanel)
		this.tablaResultados(mainPanel)
	}

	def panelDeBusqueda(Panel mainPanel) {
		
		val lineaTitulos = new Panel(mainPanel).layout = new HorizontalLayout
		
		val colOrigen = new Panel(lineaTitulos).layout = new VerticalLayout
		val colDestino = new Panel(lineaTitulos).layout = new VerticalLayout
		val colDesde = new Panel(lineaTitulos).layout = new VerticalLayout
		val colHasta = new Panel(lineaTitulos).layout = new VerticalLayout
		val colMax = new Panel(lineaTitulos).layout = new VerticalLayout
		
		new Label(colOrigen).text = "Origen"

		new Selector<String>(colOrigen) => [
			allowNull = true
			bindValueToProperty = "origen"
			bindItems(new ObservableProperty(modelObject, "todosLosAeropuertos"))
		]

		new Label(colDestino).text = "Destino"

		new Selector<String>(colDestino) => [
			allowNull = true
			bindValueToProperty = "destino"
			bindItems(new ObservableProperty(modelObject, "todosLosAeropuertos"))
		]

		new Label(colDesde).text = "Fecha Desde"

		new TextBox(colDesde) => [
			bindValueToProperty("fechaDesde")
			width = 150
		]

		new Label(colHasta).text = "Fecha Hasta"

		new TextBox(colHasta) => [
			bindValueToProperty("fechaHasta")
			width = 150
		]

		new Label(colMax).text = "Precio maximo"

		new TextBox(colMax) => [
			bindValueToProperty("tarifaMax")
			width = 150
		]
	}

	def tablaResultados(Panel mainPanel) {

		val table = new Table<Vuelo>(mainPanel, typeof(Vuelo)) => [
			bindItemsToProperty("resultados")
			bindValueToProperty("vueloSeleccionado")
		]

		new Column<Vuelo>(table) => [
			title = "Origen"
			fixedSize = 200
			bindContentsToProperty("nombreOrigen")
		]

		new Column<Vuelo>(table) => [
			title = "Destino"
			fixedSize = 100
			bindContentsToProperty("nombreDestino")
		]

		new Column<Vuelo>(table) => [
			title = "Salida"
			fixedSize = 200
			bindContentsToProperty("fechaSalida")
		]

		new Column<Vuelo>(table) => [
			title = "Llegada"
			fixedSize = 200
			bindContentsToProperty("fechaLlegada")
		]

		new Column<Vuelo>(table) => [
			title = "Escalas"
			fixedSize = 200
			bindContentsToProperty("cantidadEscalas")
		]

		new Column<Vuelo>(table) => [
			title = "Asientos Libres"
			fixedSize = 200
			bindContentsToProperty("cantidadDeAsientosLibres")
		]
	}
	
		def botonera(Panel mainPanel) {
		val panel = new Panel(mainPanel).layout = new HorizontalLayout

		new Button(panel) => [
			caption = "Buscar"
			onClick = [|
				modelObject.buscar
			]
			setAsDefault
		]
		
		new Button(panel) => [
			caption = "Reservas"
			onClick = [|
				this.reservas
			]
			setAsDefault
		]
	}
	
	def reservas() {
		modelObject.separarAsientos()
		val proxModel = new ReservaAsientoAppModel(modelObject.usr, modelObject.vueloSeleccionado, modelObject.asientosDisponibles)
			
//		this.openDialog( new ReservaAsiento( this, proxModel) )
	}
	
}
