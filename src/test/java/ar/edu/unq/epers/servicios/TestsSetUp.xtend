package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.AutoHome
import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Calificacion
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Deportivo
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.Visibilidad
import java.util.ArrayList
import java.util.List
import org.joda.time.DateTime
import org.junit.Before

class TestsSetUp {
	protected Auto auto
	protected Integer numSol
	protected Categoria cat
	protected Reserva res
	protected Reserva resdos
	protected Ubicacion loc
	protected Ubicacion locdos
	protected Usuario usuario
	protected Usuario usuario2
	protected Usuario usuario3
	protected Auto autodos
	protected DateTime inicio
	protected DateTime fin
	protected List<Auto> listaRetornada = new ArrayList<Auto>
	protected List<Auto> autos = new ArrayList<Auto>()
	protected List<Auto> autosbis = new ArrayList<Auto>()
	protected ComentarioService comservice
	
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
			usuario2 = new Usuario
			usuario2.nombre= "octavio"
			usuario2.apellido= "gonzalez"
			usuario2.username= "octi14"
			usuario2.fnac= fnac
			usuario2.password="cualquiera"
			usuario3 = new Usuario
			usuario3.nombre= "otro"
			usuario3.apellido= "usuario"
			usuario3.username= "otrousuario"
			usuario3.fnac= fnac
			usuario3.password="unomas"
			autodos= new Auto("Audi","r8",2010,"skt015",cat,0.15,locdos)
			numSol=3
			
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
		this.comservice = new ComentarioService(usuario)
		this.comservice.nuevoComentario(Calificacion.Bueno,"el auto fue bueno",Visibilidad.Publico,auto)
		this.comservice.nuevoComentario(Calificacion.Excelente,"el auto fue excelente",Visibilidad.SoloAmigos,autodos)
	}
}