package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.AutoHome
import ar.edu.unq.epers.home.Patente
import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Ubicacion
import java.util.ArrayList
import java.util.List
import org.joda.time.DateTime

class AutoService extends ModelService<Auto>{
	
	public CacheService cs = new CacheService()
	
	new() {
		super(Auto)
	}
	
	def getAutoParaReserva(Ubicacion origen,String nomCategoria,DateTime fechaInicio,DateTime fechaFin){
		//var cacheData = this.cs.mapper.get(origen.nombre,fechaInicio.toString,fechaFin.toString)
		if(this.cs.mapper.get(origen.nombre,fechaInicio.toString,fechaFin.toString) != null){
			return new AutoHome().getAutoPorPatente(this.cs.mapper.get(origen.nombre,fechaInicio.toString,fechaFin.toString).patentes.map[it.patente])
		}else{
		val autos = SessionManager.runInSession([
					new AutoHome().getAutoParaReserva(origen,nomCategoria,fechaInicio,fechaFin)
					//en la home busco los autos disponibles para la reserva deseada.
				])
		val patentes = autos.map[new Patente(it.patente)]
		this.cs.crearBusqueda(origen.nombre,fechaInicio.toString,fechaFin.toString,patentes)
		
		return autos
		}
	}
}