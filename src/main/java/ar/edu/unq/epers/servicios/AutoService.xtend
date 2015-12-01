package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.AutoHome
import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.model.Auto
import java.util.ArrayList
import java.util.List
import org.joda.time.DateTime
import ar.edu.unq.epers.model.Ubicacion

class AutoService extends ModelService<Auto>{
	
	new() {
		super(Auto)
	}
	
	def getAutoParaReserva(Ubicacion origen,String nomCategoria,DateTime fechaInicio,DateTime fechaFin){
		var List<Auto> autos
		autos = new ArrayList<Auto>
		SessionManager.runInSession([
			
			new AutoHome().getAutoParaReserva(origen,nomCategoria,fechaInicio,fechaFin)
			//en la home busco los autos disponibles para la reserva deseada.
		]);
	}
}