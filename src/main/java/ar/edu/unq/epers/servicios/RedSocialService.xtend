package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.RedSocialHome
import ar.edu.unq.epers.model.TipoDeRelaciones
import ar.edu.unq.epers.model.Usuario
import org.neo4j.graphdb.GraphDatabaseService

class RedSocialService {


	private def createHome(GraphDatabaseService graph) {
		new RedSocialHome(graph)
	}

	def eliminarPersona(Usuario user) {
		GraphServiceRunner::run[
			createHome(it).eliminarNodo(user)
			null
		]
	}

	def agregarPersona(Usuario user) {
		GraphServiceRunner::run[
			createHome(it).crearNodo(user); 
			null
		]
	}

	def AmigoDe(Usuario usuario, Usuario amigo) {
		GraphServiceRunner::run[
			val home = createHome(it);
			home.relacionar(usuario, amigo, TipoDeRelaciones.Amigo)
		]
	}

	def AmigosDeAmigosDe(Usuario user) {
		GraphServiceRunner::run[
			val home = createHome(it);
			home.getAmigosDeAmigosDe(user)
		]
	}

	def AmigosDe(Usuario user) {
		GraphServiceRunner::run[
			val home = createHome(it)
			home.getAmigosDe(user)
		]
	}

}