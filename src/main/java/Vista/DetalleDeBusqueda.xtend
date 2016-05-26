package Vista

import Dominio.Busqueda
import Dominio.VueloPersistenteArena
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner

class DetalleDeBusqueda extends TransactionalDialog<Busqueda>{
	
	new(WindowOwner owner, Busqueda model) {
		super(owner, model)
				title = "Detalle de Busqueda"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		panelDeDatos(mainPanel)
		botoneraAcciones(mainPanel)
		tablaResultados(mainPanel)
	}
	
	def panelDeDatos(Panel mainPanel) {

		new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
			new Label(it).text = "Horario de la Consulta"
			new Label(it).text = "Criterio"

			new Label(it).bindValueToProperty("fechaRealizacionStr")
			new Label(it).bindValueToProperty("criterioDeBusqueda")
		]
	}
	
	def botoneraAcciones(Panel mainPanel) {
		
		val Panel panel = new Panel(mainPanel).layout = new HorizontalLayout()
		
		new Button(panel) => [
			width = 100
			caption = "Volver"
			onClick [|this.accept]
		]
	}
	
		def tablaResultados(Panel mainPanel) {
		new Table<VueloPersistenteArena>(mainPanel, typeof(VueloPersistenteArena)) => [
			bindItemsToProperty("resultados")
			height = 250
			numberVisibleRows = 8
			new Column<VueloPersistenteArena>(it) => [
				title = "Origen"
				fixedSize = 100
				bindContentsToProperty("nombreOrigen")
			]
			new Column<VueloPersistenteArena>(it) => [
				title = "Destino"
				fixedSize = 100
				bindContentsToProperty("nombreDestino")
			]
			new Column<VueloPersistenteArena>(it) => [
				title = "Salida"
				fixedSize = 128
				bindContentsToProperty("fechaSalidaStr")
			]
			new Column<VueloPersistenteArena>(it) => [
				title = "Llegada"
				fixedSize = 128
				bindContentsToProperty("fechaLlegadaStr")
			]
			new Column<VueloPersistenteArena>(it) => [
				title = "Escalas"
				fixedSize = 54
				bindContentsToProperty("cantidadEscalas")
			]
			new Column<VueloPersistenteArena>(it) => [
				title = "Asientos Libres"
				fixedSize = 100
				bindContentsToProperty("cantidadDeAsientosLibres")
			]
		]
	}
}