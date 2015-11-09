package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.model.Usuario
import java.util.Date
import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.UsuarioHome

class UsuarioService extends ModelService<Usuario>{
		
	new() {
		super(Usuario)
	}
	
	/* 
	def crearUsuario(String nombre,	String apellido, String username, String email,	Date fnac, String password){
	
		SessionManager.runInSession[
		var user = new Usuario
			user.nom = nombre
			user.ape = apellido
			user.mail = email
			user.nomUsuario = username
			user.fnacim = fnac
			user.contrasenha = password
						
			new UsuarioHome().save(user)
			null
			]
	}
	*/
	
	/*Empresa empresa
	UsuarioHome home
	EnviadorDeMails envmail
	
	def getEnvMail(){
		envmail
	}
	def getHome(){
		home
	}
	def setEmpresa(Empresa emp){
		empresa = emp
	}
	def setHome(UsuarioHome unaHome){
		home = unaHome
	}
	def setEnvMails(EnviadorDeMails enviador){
		envmail = enviador
	}
	
	def registrarUsuario(Usuario usuarioNuevo) throws UsuarioYaExisteException{
	
		if((this.getHome().getUsuarioPorUsername(usuarioNuevo.username)) != null){
			throw new UsuarioYaExisteException		
		}else{			
		usuarioNuevo.valcode= (usuarioNuevo.username+"no validado")
		this.home.crear(usuarioNuevo)
		var Mail mail = new Mail()
		mail.to = usuarioNuevo.email
		mail.from = "validacion@rentauto.com"
		mail.subject= "Validacion"
		mail.body = usuarioNuevo.valcode
		this.envmail.enviarMail(mail)	
		}
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
			user = this.home.getUsuarioPorCodigoDeValidacion(username+"validado")
			if(user==null){
				throw new UsuarioNoValidadoException
			}else{			
				return user.validarPassword(password)
				 }
			}
		}
		
	def cambiarPassword(String username,String password,String nuevaPassword) throws NuevaPasswordInvalidaException{
		var user=this.home.getUsuarioPorUsername(username)
		if(password==nuevaPassword){
			throw new NuevaPasswordInvalidaException
		}
		if(user==null){
			throw new UsuarioNoExisteException
		}else{
			var userVal=user.validarPassword(password)
			userVal.password=nuevaPassword
			this.home.guardar(userVal)
		}
	}*/
}
