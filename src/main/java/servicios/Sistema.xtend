package servicios

import ar.edu.unq.epers.model.Empresa
import org.joda.time.DateTime

class Sistema {
	
	Empresa empresa
	Home home
	
	def registrarUsuario(Usuario usuarioNuevo) throws UsuarioYaExisteException{
		this.home.registrarUsuario(usuarioNuevo)
		
	}
}

	