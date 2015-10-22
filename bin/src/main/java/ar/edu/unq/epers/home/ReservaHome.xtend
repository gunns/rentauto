package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Reserva
import java.sql.Connection
import java.sql.Date
import java.sql.DriverManager
import java.sql.ResultSet
import java.sql.SQLException
import org.joda.time.DateTime
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.servicios.Usuario

class ReservaHome {
	def crearReserva(Reserva reserva, Usuario usuario, Auto auto){
		
		var java.util.Date d= reserva.inicio.toDate
		var Date iniciosql = new Date(d.getTime())
		
		var Ubicacion origensql = new Ubicacion()
		var Ubicacion destinosql = new Ubicacion()
		
		var Usuario usuariosql = usuario
		var Auto autosql = auto
		
		var Connection conn = null 
		try{
				conn = this.getConnection()
				var ps= conn.prepareStatement("INSERT INTO Reservas (ID, NROSOLICITUD, ORIGEN, DESTINO, INICIO, FIN, AUTO, USUARIO) VALUES (?,?,?,?,?,?,?,?)")
				ps.setInt(1,reserva.id)
				ps.setInt(2,reserva.numeroSolicitud)
				ps.setString(3,origensql)
				ps.setString(4,destinosql)
				ps.setDate(5,iniciosql)
				ps.setDate(6,reserva.fin)
				ps.setObject(7,autosql)
				ps.setObject(8,usuariosql)
				ps.execute
				}
		catch(SQLException e){
			throw new UsuarioNoPudoGuardarseException()
		}
		finally{
			conn.close()
				}
		
	}
	
}