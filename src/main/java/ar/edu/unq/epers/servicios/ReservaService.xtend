package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.ReservaHome
import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Usuario
import org.joda.time.DateTime

class ReservaService extends ModelService<Reserva>{
	
	new() {
		super(Reserva)
	}
	
	def crearReserva(Ubicacion origen,String categoria,Ubicacion destino, DateTime inicio, DateTime fin,Usuario user){
	
		SessionManager.runInSession[
		var res = new Reserva
			res.numeroSolicitud = new ReservaHome().getAll().last.numeroSolicitud+1
			res.origen = origen
			res.destino = destino
			res.inicio = DateTime.now().minusDays(4).toDate()
			res.fin = DateTime.now().toDate()
			res.auto = new AutoService().getAutoParaReserva(origen,categoria,inicio,fin).head
			res.usuario = user
			
			new ReservaHome().save(res)
			null
			]
	}
}