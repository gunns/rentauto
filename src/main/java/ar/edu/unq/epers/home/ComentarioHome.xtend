package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Comentario
import ar.edu.unq.epers.model.Visibilidad
import org.mongojack.DBQuery

class ComentarioHome {
	Collection<Comentario> homeComentarios
	
	new (){   
		homeComentarios = SistemDB.instance().collection(Comentario)
	}
	def addComentario(Comentario comm){
	homeComentarios.insert(comm)   
	}
	
	def getComentariosPublicos(){
		val query = DBQuery.in("vis",Visibilidad.SoloAmigos)
	}
}