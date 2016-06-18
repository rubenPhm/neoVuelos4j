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
	
	def Usuario searchByNickContrasenia(String xNick,String xContrasenia){
		 getUsuarios(xNick,xContrasenia).toSet.head
		 //getNodosUsuarios(xNick,xContrasenia)
		 
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
			//val released = nodeUsuario.getProperty("released", null) as Long
			//if (released != null) {
			//	anio = released.intValue
			//}
			if (deep) { 
				val rel_reservas = nodeUsuario.getRelationships(RelacionUsuarioReservas.RESERVA_USUARIO)
				reservas= rel_reservas.map [
					rel | new Reserva => [
					//rel.startNode
					id = rel.id
					val nodoAsiento = rel.endNode 
					//fechaReserva = new Date (nodoAsiento.getProperty("fechaReserva") as Long)//new Date (new Long(nodoAsiento.getProperty("fechaReserva")as Long))
					//fechaReserva = rel.getProperty("fechaReserva")as Date
					 
						//val rolesPersonaje = rel.getProperty("roles", []) as String[]
						//roles = new ArrayList(rolesPersonaje).
					//rel.startNode
				   //val relacion= rel.startNode // hay que saber como navegar
						
						//val reservas =ArrayList
						
					]
				].toSet
		//user.reservas.addAll(reservas)
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
		/*val users = getUsuarios(usuario.nick)
		if (users.contains(usuario)){
			throw new RuntimeException("El usuario ya existe") 
		}*/
		 
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

	

	private def Node getNodoUsuarioById(Long id) {
		basicSearch("ID(u) = " + id).head
	}
	
	private def getNodosUsuarios(String nick,String contrasenia) {
		basicSearch("u.nick =~ '(?i).*" + nick + ".*'" )//'nick'"
	}
	
	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (u:Usuario) where " + where   + " return u")//CREATE UNIQUE (user)
		val Iterator<Node> user_column = result.columnAs("u")// user.nick = {where}
		return user_column
	}
	
    def search(Usuario usuario) {
	val nick = usuario.nick
	val Result result = graphDb.execute("match (user:Usuario)" + "where nick(user) = nick"  + "CREATE UNIQUE (user) return user")//+ "and user.contrasenia = " + usuario.contrasenia  + "and user.nombre = " + usuario.nombre + " 	
		//val Result result = graphDb.execute("MATCH (a {nombre: '' + where }) 
// CREATE UNIQUE (a)")
 
 
		val Iterator<Node> user_column = result.columnAs("user")
		return user_column
	}

	private def void actualizarUsuario(Usuario usuario, Node nodeUsuario) {
		val user = nodeUsuario => [
			setProperty("nombre", usuario.nombre)
			setProperty("nick", usuario.nick)
			setProperty("contrasenia",usuario.contrasenia)
			// Borro las relaciones que tenga ese nodo
			relationships.forEach [it.delete ]
			// Creo relaciones nuevas
			//if(usuario.reservas != null){
			usuario.reservas.forEach [ reserva |
		val Node nodoAsiento = graphDb.createNode(Label.label( "Asiento" ))
		nodoAsiento.setProperty("fechaReserva",(new Date).toString)
		it.createRelationshipTo(nodoAsiento,RelacionUsuarioReservas.RESERVA_USUARIO)
			]
			  //val Node nodoUsuario = RepoUsuariosNeo4j.instance.getNodoUsuarioById(usuario.id)
			  		
			//]			
		//}
		]
		/* 
		val Node nodoAsiento = graphDb.createNode(Label.label( "Asiento" ))
		nodoAsiento.setProperty("fechaReserva",(new Date).toString)
		user.createRelationshipTo(nodoAsiento,RelacionUsuarioReservas.RESERVA_USUARIO)
		user.
		*/		
	}

    /*def crearRelaciones(Usuario usuario){
    	val Node user = RepoUsuariosNeo4j.instance.getNodoUsuarioById(usuario.id)
    	val Node asiento = RepoAsientosNeo4j.instance.getNodoAsientoById(new Long(10))
    	user.createRelationshipTo(asiento,RelacionUsuarioReservas.RESERVA_USUARIO)
    	
    }*/
    
    
    
	private def Label labelUsuario() {
		Label.label("Usuario")
	}
	
	/*def eliminarTodos(){
//		try {
    
    	val tx = graphDb.beginTx()   
    //Label label = Label.label( "User" );
    var label = this.labelUsuario
    for ( IndexDefinition indexDefinition : graphDb.schema()
            .getIndexes( label ) )
    {
        // There is only one index
        indexDefinition.drop();
    }

    tx.success();
}*/
	
	
}