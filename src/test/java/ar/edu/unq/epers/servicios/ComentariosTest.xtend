package ar.edu.unq.epers.servicios

import org.junit.Assert
import org.junit.Test

class ComentariosTest extends TestsSetUp{
	
	@Test
	def buscarPublicoOk(){
		var comservice=new ComentarioService(usuario)
		var perfil =comservice.verPerfil(usuario)
		Assert.assertEquals(perfil.size(),2)
	}
}