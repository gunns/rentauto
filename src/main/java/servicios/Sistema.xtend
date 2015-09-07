package servicios

import ar.edu.unq.epers.model.Empresa
import org.joda.time.DateTime

class Sistema {
	
	Empresa empresa
	Home home
	
	def registrarUsuario(Usuario usuarioNuevo) throws UsuarioYaExisteException{
		usuarioNuevo.valcode= (usuarioNuevo.username+"validado")
		this.home.crear(usuarioNuevo)
		
	}
	
	def validarCuenta(String codigoDeValidacion) throws ValidacionException{
		var user=this.home.getUsuarioPorCodigoDeValidacion(codigoDeValidacion)
		if(user==null){
			throw new ValidacionException
		}else{
			user.validate()
			this.home.guardar(user)
		}
	}
	def ingresarUsuario (String username, String password) throws UsuarioNoExisteException, PasswordIncorrectaException{
		var user= this.home.getUsuarioPorUsername(username)
		if(user==null){
			throw new UsuarioNoExisteException
		}else{
			return user.validarPassword(password)
		}
	}
	def CambiarPassword(String username,String password,String nuevaPassword) throws NuevaPasswordInvalidaException{
		var user=this.home.getUsuarioPorUsername(username)
		if(password==nuevaPassword){
			throw new NuevaPasswordInvalidaException
		}
		if(user==null){
			throw new UsuarioNoExisteException
		}else{
			var userVal=user.validarPassword(password)
			
		}
	}
}

	