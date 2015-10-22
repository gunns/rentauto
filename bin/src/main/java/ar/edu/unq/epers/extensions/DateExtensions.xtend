package ar.edu.unq.epers.extensions

import java.util.Calendar

class DateExtensions {
	def static nuevaFecha(int year, int month, int day){
		val cal = Calendar.instance
		cal.set(year,month - 1,day,0,0,0)
		cal.set(Calendar.MILLISECOND,0)
		cal.time
	}
	
	def static hoy(){
		val cal = Calendar.instance
		cal.set(Calendar.MILLISECOND,0)
		cal.time
	}
}