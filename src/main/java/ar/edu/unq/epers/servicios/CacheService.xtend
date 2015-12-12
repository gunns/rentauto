package ar.edu.unq.epers.servicios

import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session

class CacheService {
	Cluster cluster
	Session session
	//def guardarAutosDisponibles
	//	def connect() {
	//	cluster = Cluster.builder().addContactPoint("localhost").build();
	//	session = cluster.connect();
	//}
}