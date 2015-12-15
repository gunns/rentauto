package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Ubicacion
import java.util.ArrayList
import java.util.List
import org.joda.time.DateTime

class AutoHome extends ModelHome<Auto> {
	
	new() {
		super(Auto)
	}
	
	def getAll() {
		val query = SessionManager::getSession().createQuery("from Auto")
		//busco todos los autos y devuelvo la lista como un array list
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
				//la query hace un join entre los autos, sus reservas y los destinos de las reservas
				//pide que el auto sea de la categoría parametro.
				//y si tiene reservas busca las que el destino sea igual al origen de la reserva que se pretende realizar
				//busco todos los autos que cuya categoria tenga el nombre "value"
				query.setParameter("nombreCat", nomCategoria)
				query.setParameter("fechaInicio", fechaInicio.toDate())
				query.setParameter("fechaFin", fechaFin.toDate())
				query.setParameter("origen", origen.nombre)
				//le digo a la query que "value" es el nombe de la categoria parámetro
				
      return query.list() as ArrayList<Auto>
	}
	
	def getAutoPorPatente(List<String> patentes){
		val query = SessionManager::getSession().createQuery("
				select auto
				from Auto as auto
				where auto.patente in :patentes")
				query.setParameter("patentes", patentes)
				
		return query.list() as ArrayList<Auto>
	}
	
}