package servicios

import java.sql.Connection
import java.sql.DriverManager
import java.util.List

class Home {
	Sistema sistema
	List<Usuario> users

	def registrarUsuario(Usuario usuarioNuevo) throws UsuarioYaExisteException{
		var Connection conn = null 
		conn = this.getConnection()
		var ps= conn.prepareStatement("INSERT INTO Usuarios (NOMBRE, APELLIDO, EMAIL, FNAC, USERNAME) VALUES (?,?,?,?,?)")
//		ps.(usuarioNuevo.getNombre(),usuarioNuevo.apellido, usuarioNuevo.getEmail(),usuarioNuevo.getFnac(),usuarioNuevo.getUsername())
		
	}

	def getConnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/Rentauto?user=root&password=root");
	}

}