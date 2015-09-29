package ar.edu.unq.epers.home

class ModelHome<T> {
	Class<T> modelType
	
	new(Class<T> modelType){
		this.modelType = modelType
	}
	
	def get(int id){
		return SessionManager.getSession().get(modelType ,id) as T
	}

	def save(T a) {
		SessionManager.getSession().saveOrUpdate(a)
	}
}