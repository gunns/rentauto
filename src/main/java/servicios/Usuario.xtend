package servicios

import org.joda.time.DateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Usuario {
	String nombre
	String apellido
	String username
	String email
	DateTime fnac

	def getNombre() {
		return nombre
	}
	
	def getUsername() {
		return username
	}
	def getEmail(){
		return email
	}
	def getFnac(){
		fnac
	}
	
}