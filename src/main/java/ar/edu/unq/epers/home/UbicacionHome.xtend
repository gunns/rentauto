package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Ubicacion

class UbicacionHome {
	def get(int id){
		return SessionManager.getSession().get(typeof(Ubicacion) ,id) as Ubicacion
	}

	def save(Ubicacion loc) {
		SessionManager.getSession().saveOrUpdate(loc)
	}

}