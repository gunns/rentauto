package ar.edu.unq.epers.servicios

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Mail {
	String body
	String subject
	String to
	String from
}