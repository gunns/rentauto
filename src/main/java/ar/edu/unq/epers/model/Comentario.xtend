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
	Auto auto
	@ObjectId
	@JsonProperty("_id")
	String id
	
	new(Calificacion cal,String texto,Visibilidad vis,Auto auto,Usuario user){
		this.cal=cal
		this.texto=texto
		this.vis= vis
		this.auto = auto
		this.user= user

	}
	
}