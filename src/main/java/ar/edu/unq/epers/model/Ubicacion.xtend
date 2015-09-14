package ar.edu.unq.epers.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors 
class Ubicacion {
	String nombre
	
	new(String nombre){
		this.nombre = nombre
	}
}

@Accessors 
class UbicacionVirtual extends Ubicacion{
	List<Ubicacion> ubicaciones
}
