package ar.edu.unq.epers.model

class Comentario {
	Calificacion cal
	String texto
	Visibilidad vis
	Auto auto
	
	new(Calificacion cal,String texto,Visibilidad vis,Auto auto){
		this.cal=cal
		this.texto=texto
		this.vis= vis
		this.auto = auto
	}
	
}