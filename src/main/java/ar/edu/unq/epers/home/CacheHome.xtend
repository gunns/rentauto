package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Ubicacion
import com.datastax.driver.mapping.annotations.FrozenValue
import com.datastax.driver.mapping.annotations.PartitionKey
import com.datastax.driver.mapping.annotations.Table
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import com.datastax.driver.mapping.annotations.UDT
import org.eclipse.xtend.lib.annotations.EqualsHashCode

@Accessors
@EqualsHashCode
@UDT(keyspace = "simplex", name = "patente")
class Patente {
	String patente
}

@Accessors
@Table(keyspace = "simplex", name = "busquedaPorDia")
class BusquedaPorDia {
	@PartitionKey()
    String location
    @PartitionKey(1)
	String finicio
	@PartitionKey(2)
	String ffin
	@FrozenValue
	List<Patente> patentes
}
