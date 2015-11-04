package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.TipoDeRelaciones
import ar.edu.unq.epers.model.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.graphdb.Direction
import org.neo4j.graphdb.DynamicLabel
import org.neo4j.graphdb.GraphDatabaseService
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.RelationshipType

@Accessors
class RedSocialHome {
	GraphDatabaseService graph

	new(GraphDatabaseService graph) {
		this.graph = graph
	}

	private def userLabel() {
		DynamicLabel.label("User")
	}
	
	def crearNodo(Usuario user) {
		val node = this.graph.createNode(userLabel)
		node.setProperty("username", user.username)
		node.setProperty("email", user.email)
		node.setProperty("apellido", user.apellido)
	}

	def eliminarNodo(Usuario user) {
		val nodo = this.getNodo(user)
		nodo.relationships.forEach[delete]
		nodo.delete
	}

	def getNodo(Usuario user) {
		this.getNodo(user.username)
	}
	
	def getNodo(String username) {
		this.graph.findNodes(userLabel, "username", username).head
	}
	
	def relacionar(Usuario user1, Usuario user2, TipoDeRelaciones relacion) {
		val nodo1 = this.getNodo(user1);
		val nodo2 = this.getNodo(user2);
		nodo1.createRelationshipTo(nodo2, relacion);
	}
	
	
	private def toUser(Node nodo) {
		new Usuario => [
			username = nodo.getProperty("username") as String
			email = nodo.getProperty("email") as String
			apellido = nodo.getProperty("apellido") as String
		]
	}

	def getAmigosDe(Usuario user) {
		val nodoUsuario = this.getNodo(user)
		val nodoAmigo = this.nodosRelacionados(nodoUsuario, TipoDeRelaciones.Amigo, Direction.BOTH)
		nodoAmigo.map[toUser].toSet
	}

	def getAmigosDeAmigosDe(Usuario user) {
		val AmigosDeAmigos = this.getAmigosDe(user)
		AmigosDeAmigos.map[this.getAmigosDe(it)].flatten.toSet
	}


	protected def nodosRelacionados(Node nodo, RelationshipType tipo, Direction direccion) {
		nodo.getRelationships(tipo, direccion).map[it.getOtherNode(nodo)]
	}

}