package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Categoria

class CategoriaHome {
		def get(int id){
		return SessionManager.getSession().get(typeof(Categoria) ,id) as Categoria
	}

	def save(Categoria cat) {
		SessionManager.getSession().saveOrUpdate(cat)
	}
}