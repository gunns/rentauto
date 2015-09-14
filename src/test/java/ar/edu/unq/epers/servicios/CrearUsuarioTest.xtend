package ar.edu.unq.epers.servicios
import org.mockito.Mock
import org.junit.Before
import org.joda.time.DateTime
import org.junit.Test
import java.sql.Connection
import static org.junit.Assert.*
import org.junit.After

class CrearUsuarioTest {
	protected Usuario user
	protected UsuarioHome home
	protected DateTime fnac
	
	@Before
	def void setUp(){
		home= new UsuarioHome()
		user= new Usuario()
		user.apellido="Aramburu"
		user.nombre="Gustavo"
		user.password="password"
		fnac= new DateTime()
		fnac.withYear(1992)
		fnac.withDayOfMonth(8)
		fnac.withMonthOfYear(4)
		user.fnac=fnac
		user.email="gunns@live.com.ar"
		user.username="gunns"
		user.valcode=user.username+"validado"
		var Connection conn
			try{
			conn = home.getConnection()
			var ps =conn.prepareStatement("TRUNCATE TABLE Usuarios")
			ps.execute
			}
		finally{
			conn.close()
		}			
	}
	
	@Test
	def void pruebaDeCreacion(){
		home.crear(user)
		var Connection conn
			try{
			conn = home.getConnection()
			var ps = conn.prepareStatement("SELECT * FROM Usuarios WHERE username = ?")
			ps.setString(1,"gunns")
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
				assertEquals(nwuser.nombre,"Gustavo")
				assertEquals(nwuser.apellido,"Aramburu")
				assertEquals(nwuser.email,"gunns@live.com.ar")
			}
		}
		finally{
			conn.close()
		}
	}
	
	@Test
	def void testGetUserByUsername(){
		assertEquals(home.getUsuarioPorUsername("gunns"),user)
	}
	
	@Test
	def void pruebaDeFalla(){
		home.crear(user)
		var user2 = user
		home.crear(user2)
	}
}