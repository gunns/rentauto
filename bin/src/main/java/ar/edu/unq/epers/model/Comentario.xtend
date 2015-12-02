package ar.edu.unq.epers.model

import com.fasterxml.jackson.annotation.JsonProperty
import org.mongojack.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Comentario {
	Usuario user
	Calificacion cal
	String texto
	Visibilidad vis
	String patenteAuto
	@ObjectId
	@JsonProperty("_id")
	String id
	
	new (){}
	
	new(Calificacion cal,String texto,Visibilidad vis,Auto auto,Usuario user){
		this.cal=cal
		this.texto=texto
		this.vis= vis
		this.patenteAuto = auto.patente
		this.user= user

	}
	
}