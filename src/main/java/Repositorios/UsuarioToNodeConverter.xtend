package Repositorios

import Dominio.Usuario
import org.neo4j.graphdb.Node

class UsuarioToNodeConverter {
	
	def  Usuario convertToUser(Node nodeUsuario) {
		new Usuario => [
			id = nodeUsuario.id
			nombre = nodeUsuario.getProperty("nick", "") as String
			contrasenia = nodeUsuario.getProperty("contrasenia", "") as String
			nombre = nodeUsuario.getProperty("nombre", "") as String
		]
	}
}