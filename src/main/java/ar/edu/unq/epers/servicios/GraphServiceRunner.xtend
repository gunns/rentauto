package ar.edu.unq.epers.servicios

import org.neo4j.graphdb.factory.GraphDatabaseFactory
import org.neo4j.graphdb.GraphDatabaseService
import org.eclipse.xtext.xbase.lib.Functions.Function1

class GraphServiceRunner {

	static private GraphDatabaseService graphDatabaseService

	static synchronized def GraphDatabaseService getGraphDb() {
		if (graphDatabaseService == null) {
			graphDatabaseService = new GraphDatabaseFactory()
				.newEmbeddedDatabaseBuilder("./target/neo4j")
				.newGraphDatabase();
				
			  	Runtime.runtime.addShutdownHook(new Thread([graphDb.shutdown]))
		}
		graphDatabaseService
	}
	
	static def <T> T run(Function1<GraphDatabaseService, T> command){
		val tx = getGraphDb.beginTx
		try {
			val t = command.apply(getGraphDb)
			tx.success
			t
		} catch(Exception e) {
			tx.failure
			throw e
		} finally {
			tx.close
		}
	}
	
}
