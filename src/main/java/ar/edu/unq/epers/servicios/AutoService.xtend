package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.home.AutoHome
import ar.edu.unq.epers.home.SessionManager

class AutoService extends ModelService<Auto>{
	
	new() {
		super(Auto)
	}
	
	def getCategoriaAuto(String nombre){
		SessionManager.runInSession([
			new AutoHome().getCategoriaAuto(nombre)
			nombre
		]);
	}
}