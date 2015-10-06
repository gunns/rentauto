package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.model.IUsuario
import ar.edu.unq.epers.model.Reserva
import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Usuario implements IUsuario{
	int dni
	String nombre
	String apellido
	String username
	String email
	Date fnac
	String valcode
	String password
	List<Reserva> reservas = newArrayList
	
	def validate(){
		valcode = username+"validado"
	}
	
	def validarPassword(String password) throws PasswordIncorrectaException{
		if(this.password==password){
			return this
		}
		else{
			throw new PasswordIncorrectaException
		}
	}
	
	override agregarReserva(Reserva unaReserva) {
		this.reservas.add(unaReserva)
	}
	
	override getReservas() {
		this.reservas
	}
	
}