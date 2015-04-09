package ar.edu.unq.epers.model

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.joda.time.Days

@Accessors
class Reserva {
	Integer numeroSolicitud
	Ubicacion origen
	Ubicacion destino
	Date inicio
	Date fin
	Auto auto
	IUsuario usuario

	def double costoTotal() {
		return Days.daysBetween(new DateTime(inicio), new DateTime(fin)).days;
	}
}


@Accessors 
class ReservaEmpresarial extends Reserva{
	Empresa empresa
	String nombreContacto
	String cargoContacto
}