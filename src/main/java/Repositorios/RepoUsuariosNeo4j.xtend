package Repositorios

import java.util.List
import Dominio.Usuario
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result
import java.util.Iterator
import org.neo4j.graphdb.GraphDatabaseService
import Dominio.Reserva
import org.neo4j.graphdb.Label
import org.neo4j.kernel.api.proc.Neo4jTypes.RelationshipType
import org.neo4j.graphdb.Transaction
import org.neo4j.graphdb.schema.IndexDefinition
import java.util.ArrayList
import java.util.Date
import java.security.Timestamp
import java.util.GregorianCalendar
import Dominio.Asiento

class RepoUsuariosNeo4j extends AbstractRepoNeo4j {
	
	private static RepoUsuariosNeo4j instance
	//public GraphDatabaseService graphDb
	
	def static RepoUsuariosNeo4j getInstance() {
		if (instance == null) {
			instance = new RepoUsuariosNeo4j
		}
		instance
	}
	
	
	
	def Usuario searchByNickContrasenia(String xNick,String xContrasenia){
		 getUsuarios(xNick,xContrasenia).toSet.head 
		 }
	
	

	def List<Usuario> getUsuarios(String valor,String valor2) {
		val transaction = graphDb.beginTx
		try {
			getNodosUsuarios(valor,valor2).map [ Node node |
				convertToUsuario(node, false)
			].toList
		} finally {
			cerrarTransaccion(transaction)
		}
	}

	def Usuario getUsuario(Long id) {
		val transaction = graphDb.beginTx
		try {
			convertToUsuario(getNodoUsuarioById(id), true)
		} finally {
			cerrarTransaccion(transaction)
		}
	}
	
	def convertToUsuario(Node nodeUsuario, boolean deep) {
		var user = new Usuario 
		user => [
			id = nodeUsuario.id
			nick = nodeUsuario.getProperty("nick") as String
			contrasenia = nodeUsuario.getProperty("contrasenia") as String
			nombre = nodeUsuario.getProperty("nombre") as String
			
			if (deep) { 
				val rel_reservas = nodeUsuario.getRelationships(RelacionUsuarioReservas.RESERVA_USUARIO)
				reservas= rel_reservas.map [
					rel | new Reserva => [
					id = rel.id
					var a = new Asiento
					a.id = rel.endNode.getProperty("asientoId") as Long
					a.disponible = rel.endNode.getProperty("disponible") as Boolean	
					a.fila = rel.endNode.getProperty("fila") as Integer
					a.ubicacion = rel.endNode.getProperty("ubicacion") as String
					asiento = a
					//fechaReserva = new Date(Long.parseLong(rel.getProperty("fechaReserva").toString))
					//new Date((long)nodo.getProperty("fecha", 0))				
					]
				].toSet
		
			}			
		]
	}

	def void eliminarUsuario(Usuario usuario) {
		val transaction = graphDb.beginTx
		try {
			getNodoUsuarioById(usuario.id).delete
			transaction.success
		} finally {
			cerrarTransaccion(transaction)
		}
	}

	private def noExiste(Usuario usuario){
		getNodosUsuarios(usuario.nick,usuario.contrasenia).empty
	}
	
	def void saveOrUpdateUsuario (Usuario usuario) {

		val transaction = graphDb.beginTx
		try {
			var Node nodoUsuario = null
			if (usuario.id == null) {// noExiste(usuario)|| 
				nodoUsuario = graphDb.createNode
				nodoUsuario.addLabel(labelUsuario)
			} else {
				nodoUsuario = getNodoUsuarioById(usuario.id)
			}
			actualizarUsuario(usuario, nodoUsuario)
			transaction.success
			usuario.id = nodoUsuario.id
		} finally {
			cerrarTransaccion(transaction)
		}
	}

	

	private def Node getNodoUsuarioById(Long id) {
		basicSearch("ID(u) = " + id).head
	}
	
	private def getNodosUsuarios(String nick,String contrasenia) {
		basicSearch("u.nick =~ '(?i).*" + nick + ".*'" + " and u.contrasenia =~ '(?i).*" + contrasenia + ".*'")
	}
	
	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (u:Usuario) where " + where   + " return u")
		val Iterator<Node> user_column = result.columnAs("u")
		return user_column
	}
	


	private def void actualizarUsuario(Usuario usuario, Node nodeUsuario) {
		nodeUsuario => [
			setProperty("nombre", usuario.nombre)
			setProperty("nick", usuario.nick)
			setProperty("contrasenia",usuario.contrasenia)
			// Borro las relaciones que tenga ese nodo
			relationships.forEach [it.delete ]
			// Creo relaciones nuevas
			usuario.reservas.forEach [ reserva |
		val Node nodoAsiento = graphDb.createNode(Label.label( "Asiento" ))
		nodoAsiento.setProperty("asientoId",reserva.asiento.id)
		nodoAsiento.setProperty("fila",reserva.asiento.fila)
		nodoAsiento.setProperty("disponible",reserva.asiento.disponible)
		nodoAsiento.setProperty("ubicacion",reserva.asiento.ubicacion)
		val relacion = it.createRelationshipTo(nodoAsiento,RelacionUsuarioReservas.RESERVA_USUARIO)
		relacion.setProperty("fechaReserva",(new Date).toString)
			]			  
		]	
	}

    
	private def Label labelUsuario() {
		Label.label("Usuario")
	}
	
	
	
	
}