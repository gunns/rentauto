package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Comentario
import ar.edu.unq.epers.model.Usuario
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
	
	def getComentariosSoloAmigos(Usuario user){
		val query = DBQuery.in("vis",Visibilidad.SoloAmigos)
		query.in("user",user)
		val comentarios = homeComentarios.getMongoCollection().find(query)
		comentarios
	}
	
	def getComentariosPrivados(Usuario user){
		val query = DBQuery.in("vis", Visibilidad.Privado)
		query.in("user",user)
		val comentarios = homeComentarios.getMongoCollection().find(query)
		comentarios
	}
	
	def getComentariosPublicos(Usuario user){
		val query = DBQuery.in("vis", Visibilidad.Publico)
		query.in("user",user)
		val comentarios = homeComentarios.getMongoCollection().find(query)
		comentarios
	}
	
	def getAll(Usuario user){
		val query = DBQuery.in("vis", Visibilidad.Publico,Visibilidad.Privado,Visibilidad.SoloAmigos)
		query.in("user",user)
		val comentarios = homeComentarios.getMongoCollection().find(query)
		comentarios
	}
}