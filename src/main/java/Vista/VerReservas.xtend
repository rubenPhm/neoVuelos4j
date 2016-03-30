package Vista

import org.uqbar.arena.windows.SimpleWindow
import AppModel.VerReservasAppModel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.tables.Table
import Dominio.Reserva
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.widgets.Label
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import AppModel.BusquedaVueloAppModel

class VerReservas extends SimpleWindow<VerReservasAppModel>{
	
	new(WindowOwner parent, VerReservasAppModel model) {
		super(parent, model)	
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		new Label(mainPanel).text = "Usuario: " + modelObject.usuario.nombre
		new Label(mainPanel).text = "Reservas Efectuadas"
		
        new Table<Reserva>(mainPanel, typeof(Reserva)) => [
			items <=> "reservas"
			height = 200
            bindSelectionToProperty("reservaSeleccionada")
            numberVisibleRows = 10
       		 		  				    
			
		new Column<Reserva>(it) => [
				title = "Origen" 
			    fixedSize = 100  
				bindContentsToProperty("origen")  
			    
			]
		
		new Column<Reserva>(it) => [			
				title = "Destino" 
			    fixedSize = 100   
				bindContentsToProperty("destino")  	
			]	
		
		new Column<Reserva>(it) => [
				title = " Salida" 
			    fixedSize = 100   
				bindContentsToProperty("salida")  
			]
		new Column<Reserva>(it) => [
				title = "Llegada"
			    fixedSize = 100  
				bindContentsToProperty("llegada") 
			]		
			   
		new Column<Reserva>(it) => [
				title = "Tramos"
			    fixedSize = 100  
				bindContentsToProperty("tramos") 
			]		   
        
       new Column<Reserva>(it) => [
				title = "Asiento Reservado"
			    fixedSize = 50  
				bindContentsToProperty("asientoDescripcion") 
			]
	   			
		 ]
		
		val botonera = new Panel(mainPanel).layout = new HorizontalLayout
		
		new Button(botonera) => [
			caption = "Cancelar Reserva"
			width = 150
			onClick[|modelObject.cancelarReserva(modelObject.reservaSeleccionada)						
			 ]
			bindEnabled(new NotNullObservable("reservaSeleccionada"))
			]
			
		
		val botonera2 = new Panel(mainPanel).layout = new HorizontalLayout
		new Button(botonera2)=> [
		    setCaption("Busqueda de Vuelos")
			width = 150
			onClick[|this.abrirBusqueda(this)]
			]
			
			
        new Button(botonera2)
		    .setCaption("Log de Consultas Hechas")
			.width = 150
         			
			
	}
	
	def BusquedaVuelo abrirBusqueda(VerReservas ventana){
		new BusquedaVuelo(ventana,new BusquedaVueloAppModel(modelObject.usuario))
	
	}
	
	override protected addActions(Panel actionsPanel) {
		
	}
	
}