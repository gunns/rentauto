package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.model.Mensaje
import ar.edu.unq.epers.model.Usuario
import org.joda.time.DateTime
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class RedSocialTest {
	Usuario user1
	Usuario user2
	Usuario user3
	Usuario user4
	Mensaje msg
	RedSocialService service
	
	
	@Test
	def void esAmigo(){
		val amigos = service.amigosDe(user1)
		Assert.assertEquals(1, amigos.length)
		Assert.assertEquals(amigos.head, user2)
	}
	
	@Test
	def void amigosDeAmigosDe(){
		val amigosDeAmigos = service.amigosDeAmigosDe(user1)
		
		Assert.assertEquals(3, amigosDeAmigos.length)
		Assert.assertTrue(amigosDeAmigos.contains(user3))
		Assert.assertTrue(amigosDeAmigos.contains(user4))
	}
	
	@Test
	def void Mensaje(){
		val mensaje= service.verMisMsg(user4)
		Assert.assertEquals(1,mensaje.length)
		Assert.assertEquals(user1,mensaje.head.from)
	}
	
	@After
	def void after(){
		service.eliminarUsuario(user1)
		service.eliminarUsuario(user2)
		service.eliminarUsuario(user3)
		service.eliminarUsuario(user4)
	}
	
	
	@Before
	def void setup(){
		user1 = new Usuario => [
			username = "usuario1" 
			email = "usuario1@users.com"
			apellido = "Pérez"
		];
		
		user2 = new Usuario => [
			username = "usuario2" 
			email = "usuario2@users.com"
			apellido = "Rodriguez"
		];
		
		user3 = new Usuario => [
			username = "usuario3" 
			email = "usuario3@user.com"
			apellido = "Gonzalez"
		];
		
		user4 = new Usuario => [
			username = "usuario4" 
			email = "usuario4@user.com"
			apellido = "Garcia"
		];
		
		msg = new Mensaje => [
			id= DateTime.now().hashCode
			mensaje = "tu auto esta que mola (?"
			to = user4
			from = user1
			fecha = DateTime.now()
		];
		
		
		service = new RedSocialService
		service.agregarUsuario(user1)
		service.agregarUsuario(user2)
		service.agregarUsuario(user3)
		service.agregarUsuario(user4)
		service.amigoDe(user1,user2)
		service.amigoDe(user2, user3)
		service.amigoDe(user2, user4)
		service.enviarMensaje(user4,user1,msg)
	}
}