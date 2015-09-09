# Grupo 4

# Rentauto.com
La idea de este TP es implementar el sistema Backend de la empresa *Rentauto.com* que se dedica al alquiler de autos.

El TP va a estar dividido en entregas. Cada una de las entregas del TP irá agregando nuevos casos de uso que vamos a implementar utilizando distintas técnicas y tecnologías de persistencia. La idea es que veamos distintas variantes y aprendamos todas.

La fecha de entrega incluye el trabajo durante ese día. O sea que tienen que entregarlo al final de la clase.

## Entrega #1 - Usuarios.
Fecha de Entrega: 07/09

La primera entrega tiene como objetivo implementar el registro de usuarios y el login de los mismos. 

Requerimientos:
* Como usuario quiero poder registrarme cargando mis datos y que quede registrado en el sistema. Cuando el usuario se registra debe enviar un mail al usuario para validar su cuenta. Para eso debe generarse un código de validación que se envía por mail. 
* Como usuario quiero poder validar mi cuenta ingresando mi código de validación.
* Como usuario quiero poder entrar en la aplicación ingresando mi nombre de usuario y contraseña. 
* Como usuario quiero poder cambiar mi contraseña. Se debe validar que la nueva contraseña no sea igual a la anterior.
* Como administrador del sistema quiero que el sistema nunca quede en un estado inválido.

De los usuarios debemos administrar los siguientes datos (además de los que necesitemos por los requerimientos):
* Nombre
* Apellido
* Nombre de Usuario (debe ser unique)
* E-Mail.
* Fecha de Nacimiento.

#### Servicios Expuestos.
Es necesario que el sistema tenga los siguientes servicios respetando la siguiente interfaz. 

* `RegistrarUsuario (Usuario usuarioNuevo) : void throws UsuarioYaExisteException`
* `ValidarCuenta (String codigoValidación) : void throws ValidaciónException`
* `IngresarUsuario (String userName, String password) : Usuario throws UsuarioNoExiste`.
* `CambiarPassword (String userName, String password, String nuevaPassword) : void throws NuevaPasswordInválida`

Para el envió de mails tenemos el siguiente servicio escrito por otro grupo de trabajo:

![Diagrama de clase mailing](https://drive.google.com/file/d/0BwLWxnCUu_qieTZoYTRpTHk3cUE/view?usp=sharing)

Para la entrega es necesario que se implementen los tests necesarios para probar la funcionalidad expuesta. 
En el caso del `EnviadorDeMails` se debe realizar un mock del mismo y testearlo funcionando y tirando una excepción.

## Entrega #2: Rentautos.
Checkpoint: 21/09<br />
Fecha de Entrega: 28/09

En esta segunda etapa del proyecto vamos a utilizar Hibernate como ORM. 
Esta entrega tiene como objetivo implementar el modelo de alquiler de autos y reservas de los mismos.

#### Contexto:
* La empresa tiene una cantidad de autos disponibles para su alquiler, de cada uno de los autos sabemos:
   * Marca
   * Modelo
   * Año
   * Patente
   * Categorías (_Familiar_, _Deportivo_, _4x4_)
   * Costo base por día
* La empresa tiene muchas ubicaciones desde donde alquila los autos, como por ejemplo _Ezeiza_, _Aeroparque_, _Retiro_. 
* Existen ubicaciones “virtuales” que integran más de una ubicación real. Por ejemplo _Capital Federal_, que incluye _Retiro_ y _Aeroparque_.
* Un auto puede estar en una ubicación solamente (maldita física). La información de la ubicación es temporal, o sea hoy esta en _Ezeiza_, pero al alquilarlo lo devuelven en _Retiro_, por lo que a partir de la semana que viene esta en _Retiro_.
* La empresa maneja dos tipos de reserva: las reservas de clientes comunes y los empresariales. Las reservas empresariales tienen información extra sobre la facturación a la empresa.
* Dependiendo de cada categoría de autos se modifica el tipo de cálculo del costo total.

#### Requerimientos:
* Como usuario quiero saber los autos disponibles en una determinada ubicación un determinado día.
* Como usuario quiero que me devuelva la información de los autos posibles para la consulta de reserva, entrando la siguiente información:
   * Ubicación Origen
   * Ubicación Destino
   * Fecha Inicio
   * Fecha Fin
   * Categoria de auto deseado
* Como usuario quiero hacer una reserva.

#### Se pide:
Para esta entrega les vamos a proveer el modelo de dominio ya implementado, lo que se pide es lo siguiente:

1. Realizar los mapeos necesarios para que el modelo funcione con Hibernate
2. Implementar la arquitectura para que funcionen de forma transparente con el modelo de dominio ya implementado.
3. Implementar los tests complementarios para demostrar el comportamiento del sistema con Hibernate

Para esta entrega ya hay código de dominio escrito, por lo que se lo pueden bajar del repositorio de git.

## Entrega #3: Performance en Hibernate.
Fecha de Entrega: 19/10

Ver el enunciado que se encuentra separado aca: https://github.com/EPERS-UNQ/TP-Performance 

## Entrega #4: Amigos
Fecha de Entrega: 02/11

La empresa desea integrar una red social a su sitio de alquiler de autos. En esta red social el usuario, inicialmente, va a tener una cantidad de amigos

#### Requerimientos:
* Como usuario quiero poder agregar a mis amigos que ya son miembro del sitio.
* Como usuario quiero poder consultar a mis amigos
* Como usuario quiero poder mandar mensajes a mis amigos.
* Como usuario quiero poder saber todas las personas con las que estoy conectado, o sea mis amigos y los amigos de mis amigos recursivamente.

El objetivo de esta entrega es implementar los requerimientos utilizando una base de datos orientada a grafos.

## Entrega #5: Comentarios
Fecha de Entrega: 16/11

El objetivo de esta entrega es que el usuario pueda agregar información a su perfil personal.

#### Requerimientos:
* Como usuario quiero calificar cada uno de los autos que alquile, estableciendo una calificación (_EXCELENTE_, _BUENO_, _REGULAR_, _MALO_) y un comentario de texto
* Como usuario quiero a cada auto y comentario establecerle un nivel de visibilidad, privado, público y solo amigos.
* Como usuario quiero poder ver el perfil público de otro usuario, viendo lo que me corresponde según si soy amigo o no.

El objetivo de esta entrega es implementar estos requerimientos utilizando una base de datos orientada a documentos.

## Entrega #6: Cache
Fecha de Entrega: 14/12

#### Requerimientos:
* Como administrador quiero que la información de disponibilidad de los autos se guarde de forma 
cacheada por día y ubicación, o sea para cada día que autos estan disponibles. De esta manera es 
mucho más rápido la consultade los autos disponibles ese día
* Como administrador quiero que la información de disponibilidad de los autos se actualice en 
el caché cuando ocurra un cambio.

El objetivo de esta entrega es implementar los requerimientos utilizando una base de datos orientada a clave/valor.
