package Vista

import AppModel.LoginAppModel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.PasswordField
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class Login extends SimpleWindow<LoginAppModel> {

	new(WindowOwner parent) {
		super(parent, new LoginAppModel)
		title = "Login"
	}

	override protected addActions(Panel mainPanel) {
		this.botonera(mainPanel)
	}

	override protected createFormPanel(Panel mainPanel) {
		this.labelInputUsrYContrasenia(mainPanel)
	}

	def labelInputUsrYContrasenia(Panel mainPanel) {
		val panelTexto = new Panel(mainPanel)

		new Label(panelTexto).text = "Usuario"
		new TextBox(panelTexto) => [
			bindValueToProperty("nick")
			width = 150
		]

		new Label(panelTexto).text = "Contraseña"
		new PasswordField(panelTexto) => [
			bindValueToProperty("contrasenia")
			width = 150
		]
	}

	def botonera(Panel mainPanel) {
		val panel = new Panel(mainPanel).layout = new HorizontalLayout

		new Button(panel) => [
			caption = "Iniciar Sesíon"
			onClick = [|
				modelObject.autorizarLogin
				this.loguear
			]
			setAsDefault
		]
	}

	def loguear() {
		throw new UnsupportedOperationException(
			"Logeado como Usuario: " + modelObject.usuario.nick + " y contraseñia: " + modelObject.usuario.contrasenia)

	//Aca es donde redirecciona a la siguiente pantalla
	//Creo una nueva instancia de una venta y le paso el usuario que va a estar seteado en el controller
	//this.openDialog( new SiguienteVenta ( this, modelObject.usuario) )
	}

}
