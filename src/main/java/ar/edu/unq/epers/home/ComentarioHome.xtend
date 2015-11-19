package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Comentario
import java.util.List

class ComentarioHome {
	Collection<Comentario> homeComentarios
	
	new (){
		homeComentarios = SistemDB.instance().collection(Comentario)
	}
	def toComentario(Comentario comm){
	homeComentarios.insert(comm)
	}
	
}