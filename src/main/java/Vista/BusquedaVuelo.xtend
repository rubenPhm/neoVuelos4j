package Vista

import AppModel.BusquedaVueloAppModel
import AppModel.ReservaAsientoAppModel
import Dominio.Vuelo
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class BusquedaVuelo extends TransactionalDialog<BusquedaVueloAppModel> {

	new(WindowOwner owner, BusquedaVueloAppModel model) {
		super(owner, model)
		title = "Busqueda de vuelos"
	}

	override protected createFormPanel(Panel mainPanel) {
		panelDeBusqueda(mainPanel)	
		botoneraAcciones(mainPanel)
		tablaResultados(mainPanel)
//		botoneraAcciones(mainPanel) //si la pongo aca, desaparece un boton, parece ser algo grafico.
	}

	def panelDeBusqueda(Panel mainPanel) {
		
		new Panel(mainPanel) => [
			layout = new ColumnLayout(3)
			new Label(it).text = "Origen"
			new Label(it).text = "Destino"
			new Label(it).text = "Precio maximo"
			new Selector<String>(it) => [
				allowNull = true
				bindValueToProperty = "origen"
				bindItems(new ObservableProperty(modelObject, "todosLosAeropuertos"))
				width = 100
			]
			new Selector<String>(it) => [
				allowNull = true
				bindValueToProperty = "destino"
				bindItems(new ObservableProperty(modelObject, "todosLosAeropuertos"))
				width = 100
			]
			new TextBox(it) => [
				bindValueToProperty("tarifaMax")
				width = 80
			]
			new Label(it).text = "Fecha Desde"
			new Label(it).text = "Fecha Hasta"
			new Label(it).text = "  " //boton
			new TextBox(it) => [
				bindValueToProperty("fechaDesde")
				width = 100
			]
			new TextBox(it) => [
				bindValueToProperty("fechaHasta")
				width = 100
			]
			new Button(it) => [
				caption = "Buscar"
				onClick [|modelObject.buscar]
				setAsDefault
				width = 80
			]
		]
	}

	def tablaResultados(Panel mainPanel) {
		new Table<Vuelo>(mainPanel, typeof(Vuelo)) => [
			bindItemsToProperty("resultados")
			bindSelectionToProperty("vueloSeleccionado")
			height = 250
			numberVisibleRows = 8
			new Column<Vuelo>(it) => [
				title = "Origen"
				fixedSize = 100
				bindContentsToProperty("nombreOrigen")
			]
			new Column<Vuelo>(it) => [
				title = "Destino"
				fixedSize = 100
				bindContentsToProperty("nombreDestino")
			]
			new Column<Vuelo>(it) => [
				title = "Salida"
				fixedSize = 128
				bindContentsToProperty("fechaSalidaStr")
			]
			new Column<Vuelo>(it) => [
				title = "Llegada"
				fixedSize = 128
				bindContentsToProperty("fechaLlegadaStr")
			]
			new Column<Vuelo>(it) => [
				title = "Escalas"
				fixedSize = 54
				bindContentsToProperty("cantidadEscalas")
			]
			new Column<Vuelo>(it) => [
				title = "Asientos Libres"
				fixedSize = 100
				bindContentsToProperty("cantidadDeAsientosLibres")
			]
		]
	}

	def botoneraAcciones(Panel mainPanel) {
		val elementSelected = new NotNullObservable("vueloSeleccionado")
		val Panel panel = new Panel(mainPanel).layout = new HorizontalLayout()
		new Button(panel) => [
			width = 100
			caption = "Reservar Asientos"
			onClick [|this.reservas]
			bindEnabled(elementSelected)
		]
		new Button(panel) => [
			width = 100
			caption = "Volver"
			onClick [|this.accept]
		]
	}

	def reservas() {
		val proxModel = new ReservaAsientoAppModel(modelObject.usr, modelObject.vueloSeleccionado)
		this.openDialog(new ReservaAsiento(this, proxModel))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.open
	}
	
	override protected addActions(Panel actionsPanel) {
	}
}
