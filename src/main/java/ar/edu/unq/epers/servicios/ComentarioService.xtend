package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.ComentarioHome
import ar.edu.unq.epers.model.Usuario

class ComentarioService {
	
	Usuario usuario
	RedSocialService redSocial
	ComentarioHome comentarioHome
	
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
}
	