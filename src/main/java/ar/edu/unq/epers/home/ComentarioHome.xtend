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
	//Inserta un nuevo comentario en la BD a través de la var homeComentarios
	}
	
	def getComentariosSoloAmigos(Usuario user){
		//crea una query en la cual la variable "vis" tenga el valor SoloAmigos
		val query = DBQuery.in("vis",Visibilidad.SoloAmigos)
		// Defino al usuario del parámetro
		query.in("user",user)
		//busco los comentarios de la query
		val comentarios = homeComentarios.getMongoCollection().find(query)
		//devuelvo los comentarios que me trajo la query
		comentarios
	}
	
	def getComentariosPrivados(Usuario user){
		//idem anterior pero con vis privado
		val query = DBQuery.in("vis", Visibilidad.Privado)
		query.in("user",user)
		val comentarios = homeComentarios.getMongoCollection().find(query)
		comentarios
	}
	
	def getComentariosPublicos(Usuario user){
		//idem anterior pero con vis público
		val query = DBQuery.in("vis", Visibilidad.Publico)
		query.in("user",user)
		val comentarios = homeComentarios.getMongoCollection().find(query)
		comentarios
	}
	
	def getAll(Usuario user){
		//devuelve todos los comentarios de un usuario
		val query = DBQuery.in("vis", Visibilidad.Publico,Visibilidad.Privado,Visibilidad.SoloAmigos)
		query.in("user",user)
		val comentarios = homeComentarios.getMongoCollection().find(query)
		comentarios
	}
}