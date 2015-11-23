package ar.edu.unq.epers.model

import com.fasterxml.jackson.annotation.JsonProperty
import org.mongojack.ObjectId

class Comentario {
	Calificacion cal
	String texto
	Visibilidad vis
	Auto auto
	@ObjectId
	@JsonProperty("_id")
	String id
	
	new(Calificacion cal,String texto,Visibilidad vis,Auto auto){
		this.cal=cal
		this.texto=texto
		this.vis= vis
		this.auto = auto

	}
	
}