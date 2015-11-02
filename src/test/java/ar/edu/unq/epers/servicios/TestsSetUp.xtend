package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.AutoHome
import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Deportivo
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Usuario
import java.util.ArrayList
import java.util.List
import org.joda.time.DateTime
import org.junit.Before

class TestsSetUp {
	protected Auto auto
	protected Categoria cat
	protected Reserva res
	protected Reserva resdos
	protected Ubicacion loc
	protected Ubicacion locdos
	protected Usuario usuario
	protected Auto autodos
	protected DateTime inicio
	protected DateTime fin
	protected List<Auto> listaRetornada = new ArrayList<Auto>
	protected List<Auto> autos = new ArrayList<Auto>()
	protected List<Auto> autosbis = new ArrayList<Auto>()
	
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
			var fnac = date.toDate()		
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
			res.inicio = DateTime.now().minusDays(4).toDate()
			res.fin = DateTime.now().toDate()
			res.auto = auto
			res.usuario = usuario
			
			resdos = new Reserva
			resdos.numeroSolicitud = 2
			resdos.origen = locdos
			resdos.destino = loc
			resdos.inicio = DateTime.now().minusDays(8).toDate()
			resdos.fin = DateTime.now().minusDays(2).toDate()
			resdos.auto = autodos
			resdos.usuario = usuario
			
			auto.agregarReserva(res)
			autodos.agregarReserva(resdos)
			
			
			autosbis.add(auto)
			autosbis.add(autodos)
			
			autos.add(autodos)
			
			inicio = DateTime.now().plusDays(15)
			fin = DateTime.now().plusDays(25)
						
			new AutoHome().save(auto)
			new AutoHome().save(autodos)
			listaRetornada = new AutoHome().getAll()
			return null
		]
	}
}