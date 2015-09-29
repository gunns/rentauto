package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import org.junit.Before
import org.junit.Test
import ar.edu.unq.epers.model.Deportivo
import org.junit.Assert

class CrearUsuarioTest {
	protected Auto auto
	protected Categoria cat
	protected Reserva res
	protected Ubicacion loc
	
	@Before
	def void setUp(){
		cat = new Deportivo
		cat.nombre = "SuperSport"
		loc = new Ubicacion("Italia")
		auto = new Auto("lamborgotti","fasterossa", 2005, "tsm201", cat, 0.15, loc)
		
		
	}
	
	@Test
	def void pruebaDeCreacion(){
		val auto = ServiceProvider.autoService.consultar(1)
		Assert.assertEquals("lamborgotti", auto.marca)
	}
	
	@Test
	def void testGetUserByUsername(){
		
	}
	
	@Test
	def void pruebaDeFalla(){
	}
}