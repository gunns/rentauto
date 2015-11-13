package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Mensaje
import ar.edu.unq.epers.model.TipoDeRelaciones
import ar.edu.unq.epers.model.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.neo4j.graphdb.Direction
import org.neo4j.graphdb.DynamicLabel
import org.neo4j.graphdb.GraphDatabaseService
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.RelationshipType
import org.neo4j.graphdb.traversal.Evaluators
import org.neo4j.graphdb.traversal.TraversalDescription

@Accessors
class RedSocialHome {
	GraphDatabaseService graph

	new(GraphDatabaseService graph) {
		this.graph = graph
	}

	private def userLabel() {
		DynamicLabel.label("User")
	}
	private def msgLabel() {
		DynamicLabel.label("Msg")
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
	def getNodo(Mensaje msg) {
		this.getNodo(msg.id)
	}
	
	def getNodo(String username) {
		this.graph.findNodes(userLabel, "username", username).head
	}
	
	def getNodo(int id){
		this.graph.findNodes(msgLabel, "id", id).head
	}
	
	def relacionar(Usuario user1, Usuario user2, TipoDeRelaciones relacion) {
		val nodo1 = this.getNodo(user1);
		val nodo2 = this.getNodo(user2);
		nodo1.createRelationshipTo(nodo2, relacion);
	}
	def getTo(Node msg){
		val to = this.nodosRelacionados(msg,TipoDeRelaciones.To,Direction.OUTGOING)
		to.map[toUser].head
	}
	def getFrom(Node msg){
		val from = this.nodosRelacionados(msg,TipoDeRelaciones.From,Direction.INCOMING)
		from.map[toUser].head
	}
	
	def relacionar(Mensaje msg,Usuario user1,TipoDeRelaciones relacionfrom, Usuario user2, TipoDeRelaciones relacionto){
		val nodo1 = this.crearNodoMensaje(msg)
		val nodo2 = this.getNodo(user1)
		val nodo3 = this.getNodo(user2)
		nodo2.createRelationshipTo(nodo1,relacionfrom)
		nodo1.createRelationshipTo(nodo3,relacionto)
	}
	private def toMsg(Node nodo){
		new Mensaje => [
			id = nodo.getProperty("id") as Integer
			to = getTo(nodo)
			mensaje = nodo.getProperty("mensaje") as String
			fecha = new DateTime(nodo.getProperty ("fecha") as Long)
			from = getFrom(nodo)
		]
	}
	
	def getMsgs(Usuario user){
		val nodoUsuario = this.getNodo(user)
		val nodoMsgs = this.nodosRelacionados(nodoUsuario,TipoDeRelaciones.To, Direction.INCOMING)
		nodoMsgs.map[toMsg].toSet
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
		/*val amigosDeAmigos = this.getAmigosDe(user)
		amigosDeAmigos.map[this.getAmigosDe(it)].flatten.toSet*/
		var TraversalDescription td = graph.traversalDescription()
		.breadthFirst().relationships( TipoDeRelaciones.Amigo, Direction.BOTH )
            .evaluator( Evaluators.excludeStartPosition() );
    	td.traverse(getNodo(user)).nodes.map[toUser].toSet
	}

	protected def nodosRelacionados(Node nodo, RelationshipType tipo, Direction direccion) {
		nodo.getRelationships(tipo, direccion).map[it.getOtherNode(nodo)]
	}
	
	def crearNodoMensaje(Mensaje msg){
		val node = this.graph.createNode(msgLabel)
		node.setProperty("id", msg.id)
		node.setProperty("mensaje", msg.mensaje)
		node.setProperty("fecha", msg.fecha.toDate.time)
		node
	}

	def getConexionesCon(Usuario user) {
		val amigos  = this.getAmigosDe(user)
		val amigosDeAmigos = this.getAmigosDeAmigosDe(user)
		val conexiones = amigos.addAll(amigosDeAmigos)
		conexiones
	}
}