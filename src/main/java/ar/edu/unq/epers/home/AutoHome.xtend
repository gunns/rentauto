package ar.edu.unq.epers.home

import ar.edu.unq.epers.home.ModelHome
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria

class AutoHome extends ModelHome<Auto> {
	
	new() {
		super(Auto)
	}
	
	def getAll() {
		val query = SessionManager::getSession().createQuery("from Auto")
		return query.list()
	}
	
	def getCategoriaAuto(String categoria) {
      val query = SessionManager::getSession().createQuery("select  
                        from Auto as auto 
                        where auto.categoria.nombre = :Deportivo")
      return query.uniqueResult() as Categoria
   }
}