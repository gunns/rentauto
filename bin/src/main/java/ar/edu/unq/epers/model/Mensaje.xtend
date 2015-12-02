package ar.edu.unq.epers.model

import org.joda.time.DateTime

class Mensaje {
	public Integer id
	public String mensaje
	public Usuario to
	public Usuario from
	public DateTime fecha
	
	new (String mensaje,Usuario to,Usuario from){
		this.id = DateTime.now().hashCode
		this.mensaje = mensaje
		this.to=to
		this.from = from
		this.fecha =DateTime.now()
	}
	
	new() {
	}
	
}