package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.servicios.UsuarioNoPudoGuardarseException
import java.sql.Connection
import java.sql.Date
import java.sql.DriverManager
import java.sql.ResultSet
import java.sql.SQLException
import java.util.ArrayList

class UsuarioHome extends ModelHome<Usuario>{
	
	new() {
		super(Usuario)
	}
	
	def crear(Usuario usuarioNuevo) throws UsuarioNoPudoGuardarseException{
		var java.util.Date d= usuarioNuevo.fnac
		var Date fnacsql = new Date(d.getTime())
	}
		
	def getAll() {
		val query = SessionManager::getSession().createQuery("from Usuario")
		return query.list() as ArrayList<Usuario>
	}
	
		/*var Connection conn = null 
		try{
				conn = this.getConnection()
				var ps= conn.prepareStatement("INSERT INTO Usuarios (NOMBRE, APELLIDO, EMAIL, FNAC, USERNAME, VALCODE, PASSWORD) VALUES (?,?,?,?,?,?,?)")
				ps.setString(1,usuarioNuevo.nombre)
				ps.setString(2,usuarioNuevo.apellido)
				ps.setString(3,usuarioNuevo.email)
				ps.setDate(4,fnacsql)
				ps.setString(5,usuarioNuevo.username)
				ps.setString(6,usuarioNuevo.valcode)
				ps.setString(7,usuarioNuevo.password)
				ps.execute
				}
		catch(SQLException e){
			throw new UsuarioNoPudoGuardarseException()
		}
		finally{
			conn.close()
				}
		
	}
	def construirUsuario(ResultSet rs) {
	    var nombre =rs.getString("NOMBRE")
	    var apellido=rs.getString("APELLIDO")
	    var email=rs.getString("EMAIL")
	    var fnac=rs.getDate("FNAC")
	    var username=rs.getString("USERNAME")
	    var valcode=rs.getString("VALCODE")
	    var password=rs.getString("PASSWORD")
	    var Usuario nwuser= new Usuario
	    nwuser.nombre=nombre
	    nwuser.apellido=apellido
	    nwuser.email=email
	    nwuser.fnac=fnac
	    nwuser.valcode=valcode
	    nwuser.username= username
	    nwuser.password=password
	    return nwuser
}
	def getUsuarioPorCodigoDeValidacion(String codigoDeValidacion){
		var Connection conn = null
		try{
			conn = this.getConnection()
			var ps = conn.prepareStatement("SELECT * FROM Usuarios WHERE VALCODE = ?")
			ps.setString(1,codigoDeValidacion)
			var rs= ps.executeQuery()
			if (rs.next) {
   				return this.construirUsuario(rs)
			} else {
   				null
			}
		}
		finally{
			conn.close()
		}
	}

	def getConnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/Rentauto?user=root&password=root");
	}
	
	def guardar(Usuario usuario) {
		var java.util.Date d= usuario.fnac
		var Date fnacsql = new Date(d.getTime())
		var Connection conn = null 
		try{
				conn = this.getConnection()
				var ps= conn.prepareStatement("UPDATE Usuarios SET NOMBRE=?, APELLIDO=?, EMAIL=?, FNAC=?, USERNAME=?, VALCODE=?, PASSWORD=? WHERE USERNAME=?")
				ps.setString(1,usuario.nombre)
				ps.setString(2,usuario.apellido)
				ps.setString(3,usuario.email)
				ps.setDate(4,fnacsql)
				ps.setString(5,usuario.username)
				ps.setString(6,usuario.valcode)
				ps.setString(7,usuario.password)
				ps.setString(8,usuario.username)
				ps.execute
				}
		finally{
			conn.close()
				}
			}
	
	def getUsuarioPorUsername(String nomusuario) {
		var Connection conn = null
		try{
			conn = this.getConnection()
			var ps = conn.prepareStatement("SELECT * FROM Usuarios WHERE USERNAME = ?")
			ps.setString(1,nomusuario)
			var rs= ps.executeQuery()
			if (rs.next){
  				return this.construirUsuario(rs)
			} else {
   				null
			}	
		}
		finally{
			conn.close()
		}
	}
*/
}
