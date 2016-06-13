package Repositorios

import Dominio.Usuario
import org.neo4j.graphdb.Node

class UsuarioToNodeConverter {
	
	def static Usuario convertToActor(Node nodeUsuario) {
		new Usuario => [
			id = nodeUsuario.id
			nombre = nodeUsuario.getProperty("name", "") as String
			contrasenia = nodeUsuario.getProperty("born", "") as String
		]
	}
}