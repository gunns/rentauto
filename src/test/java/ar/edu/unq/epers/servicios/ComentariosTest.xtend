package ar.edu.unq.epers.servicios

import org.junit.Assert
import org.junit.Test
import java.util.List
import ar.edu.unq.epers.model.Comentario

class ComentariosTest extends TestsSetUp{
	
	@Test
	def siQuieroVerLosComentariosDeMiPerfilMeLosTraeAtodos(){
		var comservice=new ComentarioService(usuario)
		var perfil =comservice.verPerfil(usuario)
		Assert.assertEquals(perfil.size(),2)
	}
	
	@Test
	def siQuieroVerSoloLosComentariosSoloAmigosSinSerAmigoMeDeberiaTraerUnoSolo(){
		/*porque no son amigos */
		var comservice=new ComentarioService(usuario2)
		var perfil =comservice.verPerfil(usuario)
		Assert.assertEquals(perfil.size(),1)
	}
	
	@Test
	def quieroChequearSiSeGuardoBienLaDescripcionDelComentario(){
		var comservice=new ComentarioService(usuario)
		var Iterable<Comentario> perfil =comservice.verPerfil(usuario)
		var comentario = perfil.toList().head
		//test
		Assert.assertEquals(comentario.texto, "el auto fue bueno")
		
	}
}