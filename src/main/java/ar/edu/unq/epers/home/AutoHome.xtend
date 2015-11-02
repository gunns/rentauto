package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Auto
import java.util.ArrayList
import org.joda.time.DateTime
import ar.edu.unq.epers.model.Ubicacion

class AutoHome extends ModelHome<Auto> {
	
	new() {
		super(Auto)
	}
	
	def getAll() {
		val query = SessionManager::getSession().createQuery("from Auto")
		return query.list() as ArrayList<Auto>
	}
	
	def getAutoParaReserva(Ubicacion origen,String nomCategoria,DateTime fechaInicio,DateTime fechaFin) {
		//creo un método que traiga el nombre de una categoria
      val query = SessionManager::getSession().createQuery("
				select auto
				from Auto as auto left join auto.reservas as reserva left join reserva.destino 
				where auto.categoria.nombre = :nombreCat 
				and (reserva = null or (:fechaInicio > reserva.fin or :fechaFin < reserva.inicio))
				and reserva.destino.nombre = :origen")
				
				//busco todos los autos que cuya categoria tenga el nombre "value"
				query.setParameter("nombreCat", nomCategoria)
				query.setParameter("fechaInicio", fechaInicio.toDate())
				query.setParameter("fechaFin", fechaFin.toDate())
				query.setParameter("origen", origen.nombre)
				//le digo a la query que "value" es el nombe de la categoria parámetro
				
      return query.list() as ArrayList<Auto>
	}
	
}