package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.UbicacionHome
import ar.edu.unq.epers.model.Ubicacion

class UbicacionService {
			
	def consultarUbicacion(int id) {
		SessionManager.runInSession([
			new UbicacionHome().get(id)
		])
	}

	def crearUbicacion(Ubicacion loc) {
		SessionManager.runInSession([
			new UbicacionHome().save(loc)
			loc
		]);
	}
}