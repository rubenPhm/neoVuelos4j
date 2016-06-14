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

class RepoUsuariosNeo4j extends AbstractRepoNeo4j {
	
	private static RepoUsuariosNeo4j instance
	//public GraphDatabaseService graphDb
	
	def static RepoUsuariosNeo4j getInstance() {
		if (instance == null) {
			instance = new RepoUsuariosNeo4j
		}
		instance
	}
	
	/*def static void main(String[] args) {
		new RepoUsuariosNeo4j => [
			//getPeliculas("Fros")
		]
	}*/

	def List<Usuario> getUsuarios(String valor) {
		val transaction = graphDb.beginTx
		try {
			getNodosUsuarios(valor).map [ Node node |
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
		new Usuario => [
			id = nodeUsuario.id
			nick = nodeUsuario.getProperty("nick") as String
			contrasenia = nodeUsuario.getProperty("contrasenia") as String
			nombre = nodeUsuario.getProperty("nombre") as String
			val released = nodeUsuario.getProperty("released", null) as Long
			//if (released != null) {
			//	anio = released.intValue
			//}
			if (deep) { 
				//val rel_reservas = nodeUsuario.getRelationships(RelacionesPelicula.ACTED_IN)
				//reservas = rel_reservas.map [
					//rel | new Reserva => [
					//	id = rel.id
						//val rolesPersonaje = rel.getProperty("roles", []) as String[]
						//roles = new ArrayList(rolesPersonaje)
					//	rel.startNode
						//nodeUsuario = rel.startNode // hay que saber como navegar
						//usuario = nodeUsuario.convertToUsuario
				//	]
			//	].toSet
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

	def void saveOrUpdateUsuario (Usuario usuario) {
		
		// falta validar el usuario para que no se repita
		 
		val transaction = graphDb.beginTx
		try {
			var Node nodoUsuario = null
			if (usuario.id == null) {
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

	private def getNodosUsuarios(String valor) {//completar con la busqueda propia para un usuario
		basicSearch("")//"peli.title =~ '(?i).*" + valor + ".*'"
	}

	private def Node getNodoUsuarioById(Long id) {
		basicSearch("ID(user) = " + id).head
	}
	
	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (user:Usuario) where " + where + " return user")
		val Iterator<Node> user_column = result.columnAs("user")
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
				val Node nodoUsuario = RepoUsuariosNeo4j.instance.getNodoUsuarioById(usuario.id)
			/* 	val relVuelo = nodoUsuario.createRelationshipTo(it, Relaciones.RESERVA )
				
				// Manganeta para usar arrays porque el [] se confunde con el bloque
				val roles = personaje.roles		
				var String[] _roles = #[]
				_roles = roles.toArray(_roles)
				relPersonaje.setProperty("roles", _roles)	
				
				*/
			]
		]
	}

	private def Label labelUsuario() {
		Label.label("Usuario")
	}
	
}