package Repositorios

import java.util.List
import Dominio.Usuario
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result
import java.util.Iterator
import org.neo4j.graphdb.GraphDatabaseService
import Dominio.Reserva
import org.neo4j.graphdb.Label

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

	/*def List<Reserva> getReservas(String valor) {
		val transaction = graphDb.beginTx
		try {
			getNodosPeliculas(valor).map [ Node node |
				convertToPelicula(node, false)
			].toList
		} finally {
			cerrarTransaccion(transaction)
		}
	}

	def Pelicula getPelicula(Long id) {
		val transaction = graphDb.beginTx
		try {
			convertToPelicula(getNodoPelicula(id), true)
		} finally {
			cerrarTransaccion(transaction)
		}
	}
	
	def convertToPelicula(Node nodePelicula, boolean deep) {
		new Pelicula => [
			id = nodePelicula.id
			titulo = nodePelicula.getProperty("title") as String
			frase = nodePelicula.getProperty("tagline", "") as String
			val released = nodePelicula.getProperty("released", null) as Long
			if (released != null) {
				anio = released.intValue
			}
			if (deep) { 
				val rel_actuaron = nodePelicula.getRelationships(RelacionesPelicula.ACTED_IN)
				personajes = rel_actuaron.map [
					rel | new Personaje => [
						id = rel.id
						val rolesPersonaje = rel.getProperty("roles", []) as String[]
						roles = new ArrayList(rolesPersonaje)
						val nodeActor = rel.startNode // hay que saber como navegar
						actor = nodeActor.convertToActor
					]
				].toList
			}			
		]
	}

	def void eliminarPelicula(Pelicula pelicula) {
		val transaction = graphDb.beginTx
		try {
			getNodoPelicula(pelicula.id).delete
			transaction.success
		} finally {
			cerrarTransaccion(transaction)
		}
	}*/

	def void saveOrUpdateUsuario (Usuario usuario) {
		
		// falta validar el usuario para que no se repita
		 
		val transaction = graphDb.beginTx
		try {
			var Node nodoUsuario = null
			if (usuario.id == null) {
				nodoUsuario = graphDb.createNode
				nodoUsuario.addLabel(labelUsuario)
			} else {
				nodoUsuario = getNodoUsuario(usuario.id)
			}
			actualizarUsuario(usuario, nodoUsuario)
			transaction.success
			usuario.id = nodoUsuario.id
		} finally {
			cerrarTransaccion(transaction)
		}
	}

	/*private def getNodosUsuarios(String valor) {
		basicSearch("peli.title =~ '(?i).*" + valor + ".*'")
	}*/

	private def Node getNodoUsuario(Long id) {
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
		/* 	usuario.personajes.forEach [ personaje |
				val Node nodoActor = RepoActores.instance.getNodoActorById(personaje.actor.id)
				val relPersonaje = nodoActor.createRelationshipTo(it, RelacionesPelicula.ACTED_IN)
				
				// Manganeta para usar arrays porque el [] se confunde con el bloque
				val roles = personaje.roles		
				var String[] _roles = #[]
				_roles = roles.toArray(_roles)
				relPersonaje.setProperty("roles", _roles)	
			]*/
		]
	}

	private def Label labelUsuario() {
		Label.label("Usuario")
	}
	
}