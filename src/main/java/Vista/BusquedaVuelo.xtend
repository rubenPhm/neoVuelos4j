package Vista

import AppModel.BusquedaVueloAppModel
import Dominio.Vuelo
import Repositorios.AeropuertosRepositorio
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class BusquedaVuelo extends SimpleWindow<BusquedaVueloAppModel> {

	new(WindowOwner owner, BusquedaVueloAppModel model) {
		super(owner, model)
		title = "Busqueda de vuelos"
	}

	override protected addActions(Panel actionsPanel) {
	}

	override protected createFormPanel(Panel mainPanel) {
		this.panelDeBusqueda(mainPanel)
		this.tablaResultados(mainPanel)
	}

	def panelDeBusqueda(Panel mainPanel) {
		val lineaTitulos = new Panel(mainPanel).layout = new HorizontalLayout
		val lineaInputs = new Panel(mainPanel).layout = new HorizontalLayout

		new Label(lineaTitulos).text = "Origen"

		new Selector<String>(lineaInputs) => [
			allowNull = true
			bindValueToProperty = "origen"
			bindItems(new ObservableProperty(AeropuertosRepositorio.getInstance, "todosLosAeropuertos"))
		]

		new Label(lineaTitulos).text = "Destino"

		new Selector<String>(lineaInputs) => [
			allowNull = true
			bindValueToProperty = "destino"
			bindItems(new ObservableProperty(AeropuertosRepositorio.getInstance, "todosLosAeropuertos"))
		]

		new Label(lineaTitulos).text = "Fecha Desde"

		new TextBox(lineaInputs) => [
			bindValueToProperty("fechaDesde")
			width = 150
		]

		new Label(lineaTitulos).text = "Fecha Hasta"

		new TextBox(lineaInputs) => [
			bindValueToProperty("fechaHasta")
			width = 150
		]

		new Label(lineaTitulos).text = "Precio maximo"

		new TextBox(lineaInputs) => [
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
			bindContentsToProperty("origen")
		]

		new Column<Vuelo>(table) => [
			title = "Destino"
			fixedSize = 100
			bindContentsToProperty("destino")
		]

		new Column<Vuelo>(table) => [
			title = "Salida"
			fixedSize = 200
			bindContentsToProperty("fechaSalida")
		]

		new Column<Vuelo>(table) => [
			title = "llegada"
			fixedSize = 200
			bindContentsToProperty("fechaLlegada")
		]

		new Column<Vuelo>(table) => [
			title = "llegada"
			fixedSize = 200
			bindContentsToProperty("tramos.size()")
		]

		new Column<Vuelo>(table) => [
			title = "Asientos Libres"
			fixedSize = 200
			bindContentsToProperty("cantidadDeAsientosLibres")
		]
	}
}
