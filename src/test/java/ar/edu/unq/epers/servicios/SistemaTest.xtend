package ar.edu.unq.epers.servicios

import static org.mockito.Mockito.*;
import org.junit.Test
import org.junit.Before
import static org.junit.Assert.*


class SistemaTest {
	protected Usuario user
	protected Usuario user2
	
	@Before
	def void setUp(){
		user = new Usuario()
        user.nombre = "octavio"
        user.apellido = "gonzalez"
        user.username = "octi14"
        user.email = "kfsk"
        
        user2 = new Usuario()
        user2.nombre = "octavio"
        user2.apellido = "martinez"
        user2.username = "octi14"
        user2.email = "kfsk"
        
	}
	
	@Test
    def void siGuardoUnUsuarioQueNoExisteTodoBien() {
           
        val servicio = new Sistema()
        servicio.setHome(mock(UsuarioHome))
        servicio.setEnvMails(mock(EnviadorDeMails))
        // Le digo al mock de home (servicio.home) que returne null cuando busquen a octi14
        when(servicio.home.getUsuarioPorUsername("octi14")).thenReturn(null)
        servicio.registrarUsuario(user)
        //Verifico que al mock de la home se le haya ordenado crear el usuario
        verify(servicio.home).crear(user)
        //Verifico que al mock del enviador de mail se le haya ordenado enviar un mail cualquiera
        verify(servicio.getEnvMail()).enviarMail(any(Mail))
    }
    
    @Test
    def void siQuieroGuardarUnUsuarioQueYaExisteNoMeDeja(){
    	val servicio = new Sistema()
        servicio.setHome(mock(UsuarioHome))
        servicio.setEnvMails(mock(EnviadorDeMails))
        servicio.registrarUsuario(user)
        try{
        	servicio.registrarUsuario(user2)
        }catch (UsuarioYaExisteException e){
        	assertEquals(user.username,user2.username)
        }
    }
    
	def void siUnUsuarioSinValidarQuiereLoguearseNoLoDeja(){
		
	}

//	def void siUnUsuarioQuiereCambiarSuPassWordPorElMismoNoLoDejan(){
		
	//}
	
	//def void siUnUsuarioQuiereCambiarSuPasswordPeroIntroduceUnoInvalido(){
		
	//}

}