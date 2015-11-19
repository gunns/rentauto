package ar.edu.unq.epers.home

import com.mongodb.DB
import com.mongodb.MongoClient
import java.net.UnknownHostException
import org.mongojack.JacksonDBCollection

class SistemDB {
	static SistemDB INSTANCE;
	MongoClient mongoClient;
	DB db;

	synchronized def static SistemDB instance() {
		if (INSTANCE == null) {
			INSTANCE = new SistemDB();
		}
		return INSTANCE;
	}

	private new() {
		try {
			mongoClient = new MongoClient("localhost", 27017);
		} catch (UnknownHostException e) {
			throw new RuntimeException(e);
		}
		db = mongoClient.getDB("rentauto");
	}
	
	
	def <T> Collection<T> collection(Class<T> entityType){
		val dbCollection = db.getCollection(entityType.getSimpleName());
		new Collection<T>(JacksonDBCollection.wrap(dbCollection, entityType, String));
	}

}
