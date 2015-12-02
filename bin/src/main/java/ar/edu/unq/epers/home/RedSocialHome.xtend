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
		//creo un label User para definir a los usuarios
	}
	private def msgLabel() {
		DynamicLabel.label("Msg")
		//creo un label msg que es para definir a los mensajes entre usuarios.
	}
	
	def crearNodo(Usuario user) {
		val node = this.graph.createNode(userLabel)
		node.setProperty("username", user.username)
		node.setProperty("email", user.email)
		node.setProperty("apellido", user.apellido)
		//creo un nodo usuario con el userlabel, y 
		//le ingreso sus datos a partir de 
		//un usuario parámetrizado.
	}

	def eliminarNodo(Usuario user) {
		val nodo = this.getNodo(user)
		nodo.relationships.forEach[delete]
		nodo.delete
		//eliminamos un nodo primero eliminando 
		//sus relaciones
		
	}

	def getNodo(Usuario user) {
		this.getNodo(user.username)
	}
	
	def getNodo(Mensaje msg) {
		this.getNodo(msg.id)
	}
	
	def getNodo(String username) {
		this.graph.findNodes(userLabel, "username", username).head
		//busco los nodos con username igual al username parametro
		//siempre devuelve una lista asi que le pido el
		//primer elemento
	}
	
	def getNodo(int id){
		this.graph.findNodes(msgLabel, "id", id).head
	}
	
	def relacionar(Usuario user1, Usuario user2, TipoDeRelaciones relacion) {
		val nodo1 = this.getNodo(user1);
		val nodo2 = this.getNodo(user2);
		nodo1.createRelationshipTo(nodo2, relacion);
		//relaciono el nodo uno con el nodo dos
		//con un tipo de relacion
	}
	def getTo(Node msg){
		val to = this.nodosRelacionados(
			msg,TipoDeRelaciones.To,Direction.OUTGOING
		)
		//busco el destinatario de un mensaje. 
		//como va a ser a quien va dirigido
		//la direction va a ser outgoing
		to.map[toUser].head
	}
	def getFrom(Node msg){
		val from = this.nodosRelacionados(
			msg,TipoDeRelaciones.From,Direction.INCOMING
		)
		//busco el emisor de un mensaje.
		//como el emisor de un mensaje es quien lo envia,
		//la direccion va a ser incoming
		from.map[toUser].head
	}
	
	def relacionar(
		Mensaje msg,Usuario user1,TipoDeRelaciones relacionfrom, Usuario user2, TipoDeRelaciones relacionto
	){
		val nodomsg = this.crearNodoMensaje(msg)
		val nodofrom = this.getNodo(user1)
		val nodoto = this.getNodo(user2)
		//creamos 3 nodos, el primero va a ser el mensaje
		//el segundo el emisor, y el tercero el receptor
		nodofrom.createRelationshipTo(nodomsg,relacionfrom)
		//creamos la relacion entre el emisor y el mensaje
		//ya que el emisor esta antes del mensaje la relacion
		//va del emisor al mensaje.
		nodomsg.createRelationshipTo(nodoto,relacionto)
		//creamos la relacion entre el mensaje y el destinatario
		//ya que el mensaje se envia hacia el destinatario
		//la relacion va del mensaje hacia el destinatario	
	}
	private def toMsg(Node nodo){
		new Mensaje => [
			id = nodo.getProperty("id") as Integer
			to = getTo(nodo)
			mensaje = nodo.getProperty("mensaje") as String
			fecha = new DateTime(nodo.getProperty ("fecha") as Long)
			from = getFrom(nodo)
		]
		//creamos un mensaje a traves de un nodo.
	}
	
	def getMsgs(Usuario user){
		val nodoUsuario = this.getNodo(user)
		val nodoMsgs = this.nodosRelacionados(nodoUsuario,TipoDeRelaciones.To, Direction.INCOMING)
		nodoMsgs.map[toMsg].toSet
		//busco los mensajes recibidos
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
		//busco todos los nodos relacionados que tengan la relacion
		//amigo tanto salientes como entrantes.
		nodoAmigo.map[toUser].toSet
	}

	def getAmigosDeAmigosDe(Usuario user) {
		/*val amigosDeAmigos = this.getAmigosDe(user)
		amigosDeAmigos.map[this.getAmigosDe(it)].flatten.toSet*/
		var TraversalDescription td = graph.traversalDescription()
		.breadthFirst().relationships( TipoDeRelaciones.Amigo, Direction.BOTH )
            .evaluator( Evaluators.excludeStartPosition() );
    	td.traverse(getNodo(user)).nodes.map[toUser].toSet
    	//busco todos los nodos elacionados con este nodo y
    	//asi recursivamente.
	}

	protected def nodosRelacionados(Node nodo, RelationshipType tipo, Direction direccion) {
		//devuelvo todos los nodos relacionados con el parametro nodo
		//con el tipo de relacion y la direccion de los parametros.
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