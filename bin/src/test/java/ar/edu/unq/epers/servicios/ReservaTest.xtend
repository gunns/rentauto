package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.SessionManager
import org.junit.After
import org.junit.Test

class ReservaTest extends TestsSetUp{

	@Test
	def void crearReservaTest(){
		//var auto = new AutoService().getAutoParaReserva(origen,"Deportivo",inicio,fin).head
		new ReservaService().crearReserva(numSol,autodos,loc,"Deportivo",loc,inicio,fin,usuario)
	}
	
	@After
	def void tearDown(){
		SessionManager::resetSessionFactory()
	}
}