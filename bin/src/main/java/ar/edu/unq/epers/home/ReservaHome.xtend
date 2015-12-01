package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Reserva
import java.util.ArrayList

class ReservaHome extends ModelHome<Reserva> {
	
	new() {
		super(Reserva)
	}
	
	def getAll() {
		val query = SessionManager::getSession().createQuery("from Reserva")
		return query.list() as ArrayList<Reserva>
	}
	
}