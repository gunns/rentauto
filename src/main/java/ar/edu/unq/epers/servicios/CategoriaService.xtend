package ar.edu.unq.epers.servicios


import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.CategoriaHome


class CategoriaService {
		
	def consultarCategoria(int id) {
		SessionManager.runInSession([
			new CategoriaHome().get(id)
		])
	}

	def crearCategoria(Categoria cat) {
		SessionManager.runInSession([
			new CategoriaHome().save(cat)
			cat
		]);
	}
}