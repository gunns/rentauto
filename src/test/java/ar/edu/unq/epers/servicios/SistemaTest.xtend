package ar.edu.unq.epers.servicios

import static org.mockito.Mockito.*;
import org.junit.Test
import org.junit.Before
import static org.junit.Assert.*
import ar.edu.unq.epers.home.UsuarioHome

class SistemaTest {
	protected Usuario user
	protected Usuario user2
	
	@Before
	def void setUp(){
		user = new Usuario()
        user.nombre = "octavio"
        user.apellido = "gonzalez"
        user.username = "octi14"
        user.password = "1234"
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
    
    @Test(expected=UsuarioYaExisteException)
    def void siQuieroGuardarUnUsuarioQueYaExisteNoMeDeja(){
    	val servicio = new Sistema()
        servicio.setHome(mock(UsuarioHome))
        servicio.setEnvMails(mock(EnviadorDeMails))
        servicio.registrarUsuario(user)
        when(servicio.getHome.getUsuarioPorUsername(user.username)).thenReturn(user)
        servicio.registrarUsuario(user2)
        }
    
    @Test(expected=UsuarioNoValidadoException)
	def void siUnUsuarioSinValidarQuiereLoguearseNoLoDeja(){
        //creo el sistema y registro el usuario 'octi14'
		val servicio = new Sistema()
        servicio.setHome(mock(UsuarioHome))
        servicio.setEnvMails(mock(EnviadorDeMails))
        servicio.registrarUsuario(user)
        when(servicio.getHome().getUsuarioPorUsername("octi14")).thenReturn(user)
        //me logueo, pero no estoy validado
        servicio.ingresarUsuario("octi14","1234")
	}
	
	@Test(expected=NuevaPasswordInvalidaException)
	def void siUnUsuarioQuiereCambiarSuPassWordPorElMismoNoLoDejan(){
		//creo el sistema y registro el usuario 'octi14'
		val servicio = new Sistema()
        servicio.setHome(mock(UsuarioHome))
        servicio.setEnvMails(mock(EnviadorDeMails))
        servicio.registrarUsuario(user)
        when(servicio.getHome().getUsuarioPorCodigoDeValidacion("octi14"+"no validado")).thenReturn(user)
        //valido la cuenta
        servicio.validarCuenta(user.valcode)
        //intento cambiar el password por el mismo de antes
        servicio.cambiarPassword("octi14","1234","1234")
	}
	
	@Test
	def void siUnUsuarioValidadoQuiereLoguearseLoDeja(){
        //creo el sistema y registro el usuario 'octi14'
		val servicio = new Sistema()
        servicio.setHome(mock(UsuarioHome))
        servicio.setEnvMails(mock(EnviadorDeMails))
        servicio.registrarUsuario(user)
        when(servicio.getHome().getUsuarioPorUsername("octi14")).thenReturn(user)
        when(servicio.getHome().getUsuarioPorCodigoDeValidacion("octi14"+"no validado")).thenReturn(user)
        //me valido
        servicio.validarCuenta(user.valcode)
        when(servicio.getHome().getUsuarioPorCodigoDeValidacion("octi14"+"validado")).thenReturn(user)
        //y me logueo
        servicio.ingresarUsuario("octi14","1234")
	}

	def void siUnUsuarioCambiaSuPasswordPorOtroValidoEstaBien(){
		//creo el sistema y registro el usuario 'octi14'
		val servicio = new Sistema()
        servicio.setHome(mock(UsuarioHome))
        servicio.setEnvMails(mock(EnviadorDeMails))
        servicio.registrarUsuario(user)
        when(servicio.getHome().getUsuarioPorCodigoDeValidacion("octi14"+"no validado")).thenReturn(user)
        //valido la cuenta
        servicio.validarCuenta(user.valcode)
        //intento cambiar el password por otro
        servicio.cambiarPassword("octi14","1234","2345")
        assertEquals(user.password,"2345")
	}

}