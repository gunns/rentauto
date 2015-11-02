package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.model.Auto
import java.util.ArrayList
import java.util.List
import org.joda.time.DateTime
import org.junit.After
import org.junit.Assert
import org.junit.Test

class AutoTest extends TestsSetUp {
	
	
	
	@Test
	def void crearAutoOk(){
		//me traigo al primer auto de la tabla, lo llamo autoa
		val autoa = ServiceProvider.autoService.consultar(1)
		//auto se guarda, cuando pregunto por su marca me la devuelve.
		Assert.assertEquals("lamborgotti", autoa.marca)
	}
	
	@Test
	def void testGetLosQueCumplenEstricto(){
		var autoServ = new AutoService()
		var List<Auto> deportivosQueCumplen = new ArrayList<Auto>()
		deportivosQueCumplen = autoServ.getAutoParaReserva(loc,"Deportivo",DateTime.now(),DateTime.now().plusDays(2))
		//pido los que cumplen con las especificaciones (solo el dos porque el uno tiene una reserva hasta hoy)
		Assert.assertEquals(autos,deportivosQueCumplen)
	}
	
	@Test
	def void testGetTodosLosQueCumplenTodo(){
		var autoServ = new AutoService()
		var List<Auto> deportivosQueCumplenConDos = new ArrayList<Auto>()
		deportivosQueCumplenConDos = autoServ.getAutoParaReserva(loc,"Deportivo",DateTime.now().plusDays(4),DateTime.now().plusDays(5))
		//la ultima reserva es hoy asi que me tendria que traer a todos los autos
		Assert.assertEquals(autosbis,deportivosQueCumplenConDos)
	}
	
	@After
	def void tierDown(){
		SessionManager::resetSessionFactory()
	}
	//def void testGetNinguno()
	/* 
	@Test
	def void pruebaDeFalla(){
	}*/
}