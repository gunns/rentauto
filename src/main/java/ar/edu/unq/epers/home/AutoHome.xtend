package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Auto

class AutoHome {
	
	def get(int id){
		return SessionManager.getSession().get(typeof(Auto) ,id) as Auto
	}

	def save(Auto a) {
		SessionManager.getSession().saveOrUpdate(a)
	}
}