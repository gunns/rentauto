package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.UbicacionHome
import ar.edu.unq.epers.home.UsuarioHome
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Usuario
import org.joda.time.DateTime
import org.junit.Before
import org.junit.Test

class ReservaTest {
	
	protected Ubicacion origen
	protected Ubicacion destino
	protected DateTime inicio
	protected DateTime fin
	protected Usuario user
	protected String categoria
	
	@Before
	def void setUp(){
		SessionManager.runInSession[
			origen = new UbicacionHome().getAll().head
			destino = new UbicacionHome().getAll().last
			inicio = DateTime.now().plusDays(15)
			fin = DateTime.now().plusDays(25)
			user= new UsuarioHome().getAll().head
			categoria= "Deportivo"
		]
		
	}
	
	@Test
	def void CrearReservaTest(){
		//var auto = new AutoService().getAutoParaReserva(origen,"Deportivo",inicio,fin).head
		new ReservaService().crearReserva(origen,categoria,destino,inicio,fin,user)
	}
	
}