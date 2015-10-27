package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.home.AutoHome
import ar.edu.unq.epers.home.SessionManager
import java.util.ArrayList
import java.util.List

class AutoService extends ModelService<Auto>{
	
	new() {
		super(Auto)
	}
	
	def getCategoriaAuto(String nombre){
		var List<Auto > autos
		autos = new ArrayList<Auto>
		SessionManager.runInSession([
			
			new AutoHome().getCategoriaAuto(nombre)
			
		]);
	}
}