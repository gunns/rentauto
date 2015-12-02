package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Ubicacion
import java.util.ArrayList

class UbicacionHome extends ModelHome<Ubicacion> {
	
	new() {
		super(Ubicacion)
	}
	
	def getAll() {
		val query = SessionManager::getSession().createQuery("from Ubicacion")
		return query.list() as ArrayList<Ubicacion>
	}
}