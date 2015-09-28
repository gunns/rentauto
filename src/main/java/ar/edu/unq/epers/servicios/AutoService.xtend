package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.AutoHome


class AutoService {
		
	def consultarJugador(int id) {
		SessionManager.runInSession([
			new AutoHome().get(id)
		])
	}

	def crearAuto(Auto auto) {
		SessionManager.runInSession([
			new AutoHome().save(auto)
			auto
		]);
	}

	def modificarNombre(int id, String nombre) {
		SessionManager.runInSession([
			var auto = new AutoHome().get(id)
			auto.nombre = nombre
		]);
	}
}