package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.RedSocialHome
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
	}

	def amigosDeAmigosDe(Usuario user) {
		GraphServiceRunner::run[
			val home = createHome(it);
			home.getAmigosDeAmigosDe(user)
		]
	}

	def amigosDe(Usuario user) {
		GraphServiceRunner::run[
			val home = createHome(it)
			home.getAmigosDe(user)
		]
	}

}