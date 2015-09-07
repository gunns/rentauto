package servicios

import java.sql.Connection
import java.sql.DriverManager
import org.joda.time.DateTime

class Home {

	def crear(Usuario usuarioNuevo) throws UsuarioYaExisteException{
		var java.util.Date d= usuarioNuevo.fnac.toDate
		var java.sql.Date fnacsql = new java.sql.Date(d.getTime())
		
		var Connection conn = null 
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
		finally{
			conn.close()
				}
		
	}
	def getUsuarioPorCodigoDeValidacion(String codigoDeValidacion){
		var Connection conn = null
		try{
			conn = this.getConnection()
			var ps = conn.prepareStatement("SELECT * FROM Usuarios WHERE VALCODE = ?")
			ps.setString(1,codigoDeValidacion)
			var rs= ps.executeQuery()
			if (rs.next){
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
				nwuser.fnac=new DateTime(fnac)
				nwuser.valcode=valcode
				nwuser.username= username
				nwuser.password=password
				return nwuser
			}else{
				return null
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
		var java.util.Date d= usuario.fnac.toDate
		var java.sql.Date fnacsql = new java.sql.Date(d.getTime())
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
			var ps = conn.prepareStatement("SELECT * FROM Usuarios WHERE VALCODE = ?")
			ps.setString(1,nomusuario)
			var rs= ps.executeQuery()
			if (rs.next){
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
				nwuser.fnac=new DateTime(fnac)
				nwuser.valcode=valcode
				nwuser.username= username
				nwuser.password=password
				return nwuser
			}else{
				return null
			}
		}
		finally{
			conn.close()
		}
	}

}