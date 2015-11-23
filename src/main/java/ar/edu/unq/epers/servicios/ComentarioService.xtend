package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.ComentarioHome
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Calificacion
import ar.edu.unq.epers.model.Comentario
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.Visibilidad

class ComentarioService {
	
	Usuario usuario
	RedSocialService redSocial
	ComentarioHome comentarioHome
	
	new(Usuario user){
		this.usuario=user
	}
	
	def verPerfil(Usuario user){
	switch user{
		case user==this.usuario:
			this.mostrarPerfilCompleto(user)
		case redSocial.amigosDe(user).contains(this.usuario):
			this.mostrarPerfilDeAmigo(user)
		default:
			this.mostrarPerfilPublico(user)	
		}
	}
	
	def mostrarPerfilPublico(Usuario usuario) {
		this.comentarioHome.getComentariosPublicos(usuario)
		
	}
	
	def mostrarPerfilCompleto(Usuario usuario) {
		this.comentarioHome.getAll(usuario)
	}
	
	def mostrarPerfilDeAmigo(Usuario usuario) {
		this.comentarioHome.getComentariosSoloAmigos(usuario)
	}
	
	def nuevoComentario(Calificacion cal,String texto,Visibilidad vis,Auto auto){
		var com = new Comentario(cal,texto,vis,auto,this.usuario)
		this.comentarioHome.addComentario(com)
	}
}
	