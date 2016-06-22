package Repositorios

import Dominio.Reserva
import Dominio.Usuario
import java.util.Date
import java.util.Iterator
import java.util.List
import java.util.Set
import org.neo4j.graphdb.Label
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result

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
		val Node nodoUsuario = basicSearch("u.nick = '" + xNick + "' and u.contrasenia = '" + xContrasenia + "'").last
		
		val transaction = graphDb.beginTx
		try {
			convertToUsuario( nodoUsuario, true)
		} finally {
			cerrarTransaccion(transaction)
		}
		
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
		
		val RepoAsientosNeo4j repoAsientos = RepoAsientosNeo4j.instance
		
		new Usuario => [
			id = nodeUsuario.id
			nick = nodeUsuario.getProperty("nick") as String
			contrasenia = nodeUsuario.getProperty("contrasenia") as String
			nombre = nodeUsuario.getProperty("nombre") as String
			
			if (deep) { 
				val rel_reservas = nodeUsuario.getRelationships(RelacionUsuarioReservas.RESERVA_USUARIO)
				reservas = rel_reservas.map [rel | 
					new Reserva => [
						id = rel.id
						asiento = repoAsientos.convertToAsiento(rel.endNode, true)
						vuelo = asiento.vuelo
						fechaReserva = new Date(rel.getProperty("fechaReserva") as Long)
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

//	private def noExiste(Usuario usuario){
//		getNodosUsuarios(usuario.nick,usuario.contrasenia).empty
//	}
	
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

	def update(Usuario usr){
		saveOrUpdateUsuario(usr)
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
		
		val RepoAsientosNeo4j repoAsientos = RepoAsientosNeo4j.instance
		
		nodeUsuario => [
			val este = it
			setProperty("nombre", usuario.nombre)
			setProperty("nick", usuario.nick)
			setProperty("contrasenia",usuario.contrasenia)
			// Borro las relaciones que tenga ese nodo
			relationships.forEach [it.delete ]
			// Creo relaciones nuevas
			usuario.reservas.forEach [ reserva |
				val Node nodoAsiento = repoAsientos.getNodoAsientoById(reserva.asiento.id)
				val relacion = este.createRelationshipTo(nodoAsiento,RelacionUsuarioReservas.RESERVA_USUARIO)
				relacion.setProperty("fechaReserva",(reserva.fechaReserva).getTime)
			]			  
		]	
	}
    
	public def labelUsuario() {
		Label.label("Usuario")
	}
	
	def searchByExample(Usuario usr){
		val transaction = graphDb.beginTx
		var Set<Object> resultadosConsulta = newHashSet
		try {
			resultadosConsulta = basicSearch("u.nick = '"+ usr.nick + "'").toSet
		}catch(Exception e){
			resultadosConsulta = newHashSet
		}
		finally {
			cerrarTransaccion(transaction)
		}
		return resultadosConsulta
	}
}