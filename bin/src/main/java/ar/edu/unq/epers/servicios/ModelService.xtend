package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.ModelHome
import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Reserva

class ModelService<T> {
	
	Class<T> modelType
	
	new(Class<T> modelType){
		this.modelType = modelType
	}
	
	def consultar(int id) {
		SessionManager.runInSession([
			new ModelHome(modelType).get(id)
		])
	}

	def crearModel(T t) {
		SessionManager.runInSession([
			new ModelHome(modelType).save(t)
			t
		]);
	}
}


class ServiceProvider{
	static def getAutoService(){
		new ModelService(Auto)
	}
	static def getCategoriaService(){
		new ModelService(Categoria)
	}
	static def getUbicacionService(){
		new ModelService(Ubicacion)
	}
	static def getReservaService(){
		new ModelService(Reserva)
	}
	static def getUsuarioService(){
		new ModelService(Usuario)
	}
	
}


