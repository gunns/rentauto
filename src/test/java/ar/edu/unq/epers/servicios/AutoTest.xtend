package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.AutoHome
import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Deportivo
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Usuario
import org.joda.time.DateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import java.util.List
import java.util.ArrayList

class AutoTest {
	protected Auto auto
	protected Categoria cat
	protected Reserva res
	protected Ubicacion loc
	protected Ubicacion locdos
	protected Usuario usuario
	protected Auto autodos
	protected List<Auto> autos = new ArrayList<Auto>()
	
	@Before
	def void setUp(){
		SessionManager.runInSession[
			cat = new Deportivo
			cat.nombre = "Deportivo"
			loc = new Ubicacion
			loc.nombre = "Italia"
			locdos=new Ubicacion
			locdos.nombre = "Alemania"
			auto = new Auto("lamborgotti","fasterossa", 2005, "tsm201", cat, 0.15, loc)
			var date = new DateTime
			date.withYear(1987)
			date.withMonthOfYear(4)
			date.withDayOfMonth(27)
			var fnac = date.toDate		
		    usuario = new Usuario
			usuario.nombre= "victoria"
			usuario.apellido= "frenteparala"
			usuario.username= "vik"
			usuario.fnac= fnac
			usuario.password="surundanga"
			autodos= new Auto("Audi","r8",2010,"skt015",cat,0.15,locdos)
			
			
			res = new Reserva
			res.numeroSolicitud = 1
			res.origen = loc
			res.destino = loc
			res.inicio = DateTime.now().toDate
			res.fin = DateTime.now().toDate
			res.auto = auto
			res.usuario = usuario
			
			auto.agregarReserva(res)
			
			
			autos.add(auto)
			autos.add(autodos)
						
			new AutoHome().save(auto)
			new AutoHome().save(autodos)
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
	def void testGetCategoriaAuto(){
		var autoServ = new AutoService()
		Assert.assertEquals(autos,autoServ.getCategoriaAuto("Deportivo"))
	}
	/* 
	@Test
	def void pruebaDeFalla(){
	}*/
}