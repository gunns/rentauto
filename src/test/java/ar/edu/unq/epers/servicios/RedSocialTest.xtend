package ar.edu.unq.epers.servicios

import org.junit.After
import ar.edu.unq.epers.home.SessionManager

class RedSocialTest extends TestsSetUp {
	
	//Tengo la duda de si acà van los tests de la red social o simplemente en UsuarioTest.
	
		
	@After
	def void tearDown(){
		SessionManager::resetSessionFactory()
	}
}