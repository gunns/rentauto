package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.servicios.TestsSetUp

import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import com.datastax.driver.mapping.Mapper
import com.datastax.driver.mapping.MappingManager
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import ar.edu.unq.epers.home.BusquedaPorDia
import org.joda.time.DateTime
import ar.edu.unq.epers.home.Patente

class CacheTest extends TestsSetUp {
	
	Cluster cluster
	Session session
	Mapper<BusquedaPorDia> mapper
	BusquedaPorDia busqueda1
	BusquedaPorDia busqueda2
	Patente patente1
	Patente patente2

	@Before
	def void setup() {
		connect
		createSchema
		crearBusqueda
	}

	def createSchema() {
		session.execute("CREATE KEYSPACE IF NOT EXISTS  simplex WITH replication = {'class':'SimpleStrategy', 'replication_factor':3};")
		
		session.execute("CREATE TYPE IF NOT EXISTS simplex.patente (" +
			"patente text);"
		)
		
		session.execute("CREATE TABLE IF NOT EXISTS simplex.BusquedaPorDia (" + 
				"location text, " + 
				"finicio text, " +
				"ffin text, " +
				"patentes list<frozen< patente>>," + 
				"PRIMARY KEY (location, finicio, ffin));"
		)
		mapper = new MappingManager(session).mapper(BusquedaPorDia);
	}

	def connect() {
		cluster = Cluster.builder().addContactPoint("localhost").build();
		session = cluster.connect();
	}

	def crearBusqueda() {
		patente1 = new Patente => [
			patente = auto.getPatente
		]

		patente2 = new Patente => [
			patente = autodos.getPatente
		]

		busqueda1 = new BusquedaPorDia => [
			location = loc.nombre
			finicio = DateTime.now()
			ffin = DateTime.now().plusDays(2)
			patentes = #[patente1]
		]
		
		busqueda2 = new BusquedaPorDia => [
			location = locdos.nombre
			finicio = DateTime.now()
			ffin = DateTime.now().plusDays(2)
			patentes = #[patente2]
		]
		
		mapper.save(busqueda1)
		mapper.save(busqueda2)
	}

	@Test
	def obtenerBusqueda() {
		val busqueda = mapper.get(loc, DateTime.now(),DateTime.now().plusDays(2))
		Assert.assertEquals(busqueda.location, loc)
		Assert.assertEquals(busqueda.finicio, DateTime.now())
		Assert.assertEquals(busqueda.finicio, DateTime.now().plusDays(2))
		Assert.assertTrue(busqueda.patentes.containsAll(#[patente1]))
	}
	
	
	@Test
	def obtenerBusqueda2() {
		val busqueda = mapper.get(locdos, DateTime.now(),DateTime.now().plusDays(2))
		Assert.assertEquals(busqueda.location, locdos)
		Assert.assertEquals(busqueda.finicio, DateTime.now())
		Assert.assertEquals(busqueda.finicio, DateTime.now().plusDays(2))
		Assert.assertTrue(busqueda.patentes.containsAll(#[patente2]))
	}
	
		
	@Test
	def busquedaVacia() {
		val busqueda = mapper.get(loc, DateTime.now(),DateTime.now())
		Assert.assertNull(busqueda)
	}
	

	@After
	def eliminarTablas() {
		session.execute("DROP KEYSPACE IF EXISTS simplex");
		cluster.close();
	}
}