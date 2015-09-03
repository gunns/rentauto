package servicios

import java.sql.Connection
import java.sql.DriverManager
import java.util.List
import java.sql.Date

class Home {
	Sistema sistema
	List<Usuario> users

	def registrarUsuario(Usuario usuarioNuevo) throws UsuarioYaExisteException{
		var d= usuarioNuevo.fnac. toDate
		var Connection conn = null 
		conn = this.getConnection()
		var ps= conn.prepareStatement("INSERT INTO Usuarios (NOMBRE, APELLIDO, EMAIL, FNAC, USERNAME) VALUES (?,?,?,?,?)")
		ps.setString(1,usuarioNuevo.nombre)
		ps.setString(2,usuarioNuevo.apellido)
		ps.setString(3,usuarioNuevo.email)
		ps.setDate(4,d)
		ps.setString(5,usuarioNuevo.username)	
	}

	def getConnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/Rentauto?user=root&password=root");
	}

}