package ar.edu.unq.epers.home

import org.hibernate.SessionFactory
import org.hibernate.Session
import org.eclipse.xtext.xbase.lib.Functions.Function0
import org.hibernate.cfg.Configuration
import org.hibernate.Transaction

class SessionManager {
	
	static SessionFactory sessionFactory
	static ThreadLocal<Session> tlSession = new ThreadLocal<Session>();
	
	def synchronized static SessionFactory getSessionFactory() {
		if (sessionFactory == null) {
			var cfg = new Configuration();
			cfg.configure()
			sessionFactory = cfg.buildSessionFactory();
		}
		sessionFactory;
	}
	
	def static <T> T runInSession(Function0<T> cmd){
		var sessionFactory = SessionManager.getSessionFactory();
		var Transaction transaction = null;
		var T result = null;
		var Session session = null;
		
		try {
			session = sessionFactory.openSession();
			transaction = session.beginTransaction();

			tlSession.set(session);
			
			result = cmd.apply()

			session.flush();
			transaction.commit();
		} catch (Exception e) {
			if (transaction != null)
				transaction.rollback();
			throw new RuntimeException(e);
		} finally {
			if (session != null)
				session.close();
			tlSession.set(null);
		}
		
		return result;
	}

	def static Session getSession() {
		tlSession.get();
	}

	
}