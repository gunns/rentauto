package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.BusquedaPorDia
import ar.edu.unq.epers.home.Patente
import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import com.datastax.driver.mapping.Mapper
import com.datastax.driver.mapping.MappingManager
import java.util.List

class CacheService {
	Cluster cluster;
	Session session;
	public Mapper<BusquedaPorDia> mapper
	
	new() {
		connect
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
	}
	
	def connect() {
		cluster = Cluster.builder().addContactPoint("localhost").build();
		session = cluster.connect();
		this.createSchema
		mapper= new MappingManager(session).mapper(BusquedaPorDia);
	}
		
	def eliminarTablas() {
		session.execute("DROP KEYSPACE IF EXISTS simplex");
		cluster.close();
	}
	
	def crearBusqueda(String loc,String fechaInicio,String fechaFin,List<Patente> pat) {
		var bpd = new BusquedaPorDia => [
			location = loc
			finicio = fechaInicio
			ffin = fechaFin
			patentes = pat
			]
			this.mapper.save(bpd)
	}
	//def guardarAutosDisponibles
	//	def connect() {
	//	cluster = Cluster.builder().addContactPoint("localhost").build();
	//	session = cluster.connect();
	//}
}