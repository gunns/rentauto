package ar.edu.unq.epers.model

import org.junit.Test

import static org.junit.Assert.*
import static ar.edu.unq.epers.extensions.DateExtensions.*

class UbicacionPorFechaTest extends AbstractTest {
		
	@Test
	def ubicacionReservasVacias(){
		assertEquals(auto.ubicacionInicial, auto.ubicacion)
	}
	
	@Test
	def ubicacionUnaReserva(){
		new Reserva => [
			origen = retiro
			destino = aeroparque
			inicio = nuevaFecha(2015,03,01)
			fin = nuevaFecha(2015,03,05)
			it.auto = this.auto
			it.usuario = usuarioPrueba
			reservar()
		]
		
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,02,28)))
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,03,01)))
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,03,02)))
		
		assertEquals(aeroparque, auto.ubicacionParaDia(nuevaFecha(2015,03,05)))
		assertEquals(aeroparque, auto.ubicacionParaDia(nuevaFecha(2015,03,06)))
	}


	@Test
	def ubicacionDosReservas(){
		new Reserva => [
			origen = retiro
			destino = aeroparque
			inicio = nuevaFecha(2015,03,01)
			fin = nuevaFecha(2015,03,05)
			it.auto = this.auto
			it.usuario = usuarioPrueba
			reservar()
		]

		new Reserva => [
			origen = aeroparque
			destino = retiro
			inicio = nuevaFecha(2015,03,06)
			fin = nuevaFecha(2015,03,10)
			it.auto = this.auto
			it.usuario = usuarioPrueba
			reservar()
		]
		
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,02,28)))
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,03,1)))
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,03,2)))
		
		assertEquals(aeroparque, auto.ubicacionParaDia(nuevaFecha(2015,03,5)))
		assertEquals(aeroparque, auto.ubicacionParaDia(nuevaFecha(2015,03,6)))

		assertEquals(aeroparque, auto.ubicacionParaDia(nuevaFecha(2015,03,9)))
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,03,11)))
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,03,11)))
	}
	
}