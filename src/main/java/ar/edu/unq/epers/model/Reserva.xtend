package ar.edu.unq.epers.model

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import static ar.edu.unq.epers.extensions.DateExtensions.*
import org.joda.time.DateTime
import org.joda.time.Days

@Accessors
class Reserva {
	Integer numeroSolicitud
	Ubicacion origen
	Ubicacion destino
	Date inicio
	Date fin
	Auto auto
	IUsuario usuario

	def costo() {
		val cantidadDeDias = Days.daysBetween(new DateTime(inicio), new DateTime(fin)).days
		return cantidadDeDias * auto.costoTotal;
	}
	
	def void validar(){
		val ubicacionInicial = auto.ubicacionParaDia(inicio)
		
		if(ubicacionInicial != origen)
			throw new ReservaException("El auto no tiene la ubicación de origen buscada")
		
		if(!auto.estaLibre(inicio, fin))
			throw new ReservaException("El auto no esta libre en el periodo pedido")
	}
	
	def isActiva(){
		inicio <= hoy && hoy <= fin
	}
	
	def seSuperpone(Date desde, Date hasta){
		if(inicio <= desde && desde <= fin )
			return true
		if(inicio <= hasta && hasta <= fin )
			return true
		if(desde <= inicio && fin <= hasta)
			return true
			
		return false	
	}
	
	def costoPorDia(){
		return 0
	}
	
	def reservar(){
		this.auto.agregarReserva(this)
		this.usuario.agregarReserva(this)
	}
}


@Accessors 
class ReservaEmpresarial extends Reserva{
	Empresa empresa
	String nombreContacto
	String cargoContacto
	
	override reservar(){
		super.reservar()
		this.empresa.agregarReserva(this)
	}
}

class ReservaException extends RuntimeException{
	new(String msg){
		super(msg)
	}
}
