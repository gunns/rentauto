package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Ubicacion
import com.datastax.driver.mapping.annotations.FrozenValue
import com.datastax.driver.mapping.annotations.PartitionKey
import com.datastax.driver.mapping.annotations.Table
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime

@Accessors
@Table(keyspace = "simplex", name = "busquedaPorDia")
class BusquedaPorDia {
	@PartitionKey()
    Ubicacion location
    @PartitionKey(1)
	DateTime finicio
	@PartitionKey(2)
	DateTime ffin
	@FrozenValue
	List<String> patentes
}
