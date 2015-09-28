package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.AutoHome


class AutoService {
		
	def consultarAuto(int id) {
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
}