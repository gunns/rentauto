package ar.edu.unq.epers.servicios

import org.joda.time.DateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Usuario {
	String nombre
	String apellido
	String username
	String email
	DateTime fnac
	String valcode
	String password
	
	def validate(){
		valcode = "VALIDADO"
	}
	
	def validarPassword(String password) throws PasswordIncorrectaException{
		if(this.password==password){
			return this
		}
		else{
			throw new PasswordIncorrectaException
		}
	}
	
}