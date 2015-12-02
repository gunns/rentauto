package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.RedSocialHome
import ar.edu.unq.epers.model.Mensaje
import ar.edu.unq.epers.model.TipoDeRelaciones
import ar.edu.unq.epers.model.Usuario
import org.neo4j.graphdb.GraphDatabaseService

class RedSocialService {

	private def createHome(GraphDatabaseService graph) {
		new RedSocialHome(graph)
	}

	def eliminarUsuario(Usuario user) {
		GraphServiceRunner::run[
			createHome(it).eliminarNodo(user)
			null
		]
	}

	def agregarUsuario(Usuario user) {
		GraphServiceRunner::run[
			createHome(it).crearNodo(user); 
			null
		]
	}

	def amigoDe(Usuario usuario, Usuario amigo) {
		GraphServiceRunner::run[
			val home = createHome(it);
			home.relacionar(usuario, amigo, TipoDeRelaciones.Amigo)
		]
		//relaciona un usuario con un "amigo" que vendría
		//a ser otro usuario
	}

	def amigosDeAmigosDe(Usuario user) {
		GraphServiceRunner::run[
			val home = createHome(it);
			home.getAmigosDeAmigosDe(user)
		]
		//le pide a la home los amigos recursivamente.
	}
	
	def verMisMsg(Usuario user){
		GraphServiceRunner::run[
			val home = createHome(it);
			home.getMsgs(user)
		]
		//le pido al home que busque mis mensajes y me los
		//muestre
	}

	def amigosDe(Usuario user) {
		GraphServiceRunner::run[
			val home = createHome(it)
			home.getAmigosDe(user)
		]
		//le pido al home que busque mis amigos y me los
		//muestre
	}
	
	def enviarMensaje(Usuario to,Usuario from,Mensaje mensaje){
		GraphServiceRunner::run[
			val home= createHome(it);
			home.relacionar(mensaje,from,TipoDeRelaciones.From,to,TipoDeRelaciones.To)
		]
		//envia un mensaje a un usuario desde otro.
	}
	
	def personasConLasQueEstaConectado(Usuario user){
		GraphServiceRunner::run[
			val home = createHome(it)
			home.getConexionesCon(user)
		]
	}

}