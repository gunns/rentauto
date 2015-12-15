package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.ReservaHome
import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Usuario
import org.joda.time.DateTime

class ReservaService extends ModelService<Reserva>{
	
	new() {
		super(Reserva)
	}
	
	def crearReserva(Integer numSol,Auto auto,Ubicacion origen,String categoria,Ubicacion destino, DateTime inicio, DateTime fin,Usuario user){
		new CacheService().eliminarTablas
		SessionManager.runInSession[
		var res = new Reserva
			res.numeroSolicitud = numSol//new ReservaHome().getAll().last.numeroSolicitud+1
			res.origen = origen
			res.destino = destino
			res.inicio = DateTime.now().minusDays(4).toDate()
			res.fin = DateTime.now().toDate()
			res.auto = auto
			res.usuario = user
			
			new ReservaHome().save(res)
			null
			]
			//crea una reserva con los datos solicitados a
			//la home.
	}
}