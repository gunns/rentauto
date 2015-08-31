package servicios

import ar.edu.unq.epers.model.Empresa
import org.joda.time.DateTime

class Sistema {
	
	Empresa empresa
	Home home
	
	def registrarUsuario(String username, String apellido, String nombre,DateTime fnac) throws UsuarioYaExisteException{
		val _usuarioNuevo = null
		_usuarioNuevo
		this.home.registrarUsuario(usuarioNuevo)
		
	}
}

	