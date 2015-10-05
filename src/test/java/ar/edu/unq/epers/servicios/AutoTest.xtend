package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import org.junit.Before
import org.junit.Test
import ar.edu.unq.epers.model.Deportivo
import org.junit.Assert
import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.ModelHome

class AutoTest {
	protected Auto auto
	protected Categoria cat
	protected Reserva res
	protected Ubicacion loc
	
	@Before
	def void setUp(){
		SessionManager.runInSession[
			cat = new Deportivo
			cat.nombre = "SuperSport"
			loc = new Ubicacion("Italia")
			auto = new Auto("lamborgotti","fasterossa", 2005, "tsm201", cat, 0.15, loc)
			
			new ModelHome(Auto).save(auto)
			return null
		]
	}
	
	@Test
	def void crearAutoOk(){
		//me traigo al primer auto de la tabla, lo llamo autoa
		val autoa = ServiceProvider.autoService.consultar(1)
		//auto se guarda, cuando pregunto por su marca me la devuelve.
		Assert.assertEquals("lamborgotti", autoa.marca)
	}
	
	@Test
	def void testGetUserByUsername(){
		
	}
	
	@Test
	def void pruebaDeFalla(){
	}
}