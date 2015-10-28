package ar.edu.unq.epers.home

import ar.edu.unq.epers.home.ModelHome
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import java.util.ArrayList
import org.joda.time.DateTime
import java.util.Date

class AutoHome extends ModelHome<Auto> {
	
	new() {
		super(Auto)
	}
	
	def getAll() {
		val query = SessionManager::getSession().createQuery("from Auto")
		return query.list() as ArrayList<Auto>
	}
	
	def getCategoriaAuto(String nomCategoria) {
		//creo un método que traiga el nombre de una categoria
      val query = SessionManager::getSession().createQuery("
				from Auto as auto
				where auto.categoria.nombre = :value")
				//busco todos los autos que cuya categoria tenga el nombre "value"
				query.setString("value", nomCategoria)
				//le digo a la query que "value" es el nombe de la categoria parámetro
      return query.list() as ArrayList<Auto>
	}
}