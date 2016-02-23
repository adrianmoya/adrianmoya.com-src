+++
categories = ["Unit Testing", "JUnit", "Java"]
date = "2016-02-22T16:04:31-05:00"
description = ""
keywords = []
title = "Pruebas con tiempo en aplicaciones legado"

+++
Las pruebas unitarias que dependen del tiempo son siempre complicadas. La manera aceptada de hacerlas es envolver todas las llamadas para obtener la hora del sistema en un objeto "Clock". Comenzando con Java 8, [la nueva API de fechas y hora](https://jcp.org/en/jsr/detail?id=310) introdujo el objeto [Clock](https://docs.oracle.com/javase/8/docs/api/java/time/Clock.html) al lenguaje, que hace más simple inyectar en una clase y sustituir por un doble en una prueba. Antes de eso, en Java 7 y anteriores, era tu responsabilidad crear dicho objeto.

Recientemente me tocó trabajar con un pedazo de código legado que manipulaba la hora y la fecha, y el autor original no se tomo la molestia de envolver estas llamadas. En lugar de eso, el código contenía las siguientes llamadas en diversas partes:

``` java
//Obtener una instancia de Calendar usando el método 
//estático getInstance()
Calendar cal = Calendar.getInstance();
//Manipular el calendario para obtener una fecha 20 días después
cal.add(Calendar.DATE, 20);
//Obtener el resultado como un objeto Date
Date finalDate = cal.getTime();
``` 

También podías encontrar cosas como esta:
``` java
//Obtener la fecha/hora actual:
Date now = new Date();
```

Esto es un patrón común cuando se manipula el tiempo en aplicaciones legado. Para cubrir este tipo de código con pruebas, puedes usar algunas herramientas como [Powermock](https://github.com/jayway/powermock) y sustituir las respuestas de las llamadas estáticas para retornar dobles con las horas y fechas fijadas cuando llamas `cal.getTime()`. Pero esto no te ayudará con las operaciones como añadir horas o días. Para el segundo caso, que obtiene la hora actual, no puedes hacer nada. Esta clase necesita una refactorización grande para poder hacerla amigable a las pruebas.

## Joda-Time

[Joda-Time](http://www.joda.org/joda-time/index.html) es una librería muy común usada para manipular fechas y tiempo en java, y se convirtió en el reemplazo *de facto* para las clases propias de Java. Incluso si tu proyecto no la usó desde el comienzo, esta librería incluye una poderosa clase utilitaria que [puede fijar una hora definida para usar en pruebas unitarias](http://www.joda.org/joda-time/userguide.html#Change_the_Current_Time). Todos los objetos en la librería que obtienen la hora actual son afectados por esta clase. La puedes usar en la preparación de tu prueba unitaria de esta manera:

``` java
@Before
public void setup(){
    //El objeto DateTime de Joda-Time recibe el año, mes, día, 
    //hora, minuto, segundo como parámetro
    //Así establecemos la fecha de Enero 01 de 2016 a las 09:00:00am
    DateTime fixedDateTime = new DateTime(2016, 1, 1, 9, 0, 0);

    //Fijamos la fecha a la hora establecida
    DateTimeUtils.setCurrentMillisFixed(fixedDateTime.getMillis());
}

@After
public void teardown(){
    //Reiniciamos la librería para que use la hora actual del sistema.
    DateTimeUtils.setCurrentMillisSystem();
}
```

De esta manera podemos establecer una hora/fecha fija antes de cada prueba, y reiniciar a la hora del sistema una vez que la prueba finalice. Ahora, ¿cómo podemos hacer que nuestro código legado respete esta regla? Joda-Time provee una manera de convertir los objetos de la librería a los objetos originales de Java. Puedes leer acerca de esta interoperabilidad [en la documentación](http://www.joda.org/joda-time/userguide.html#JDK_Interoperability). Aprovecharemos ésto y haremos un ligero cambio en nuestra aplicación legado:

``` java
//Para obtener una instancia de Calendar
Calendar cal = new DateTime().toCalendar(Locale.getDefault());
//Manipular el calendario para obtener una fecha 20 días después
cal.add(Calendar.DATE, 20);
//Obtener el resultado como un objeto Date
Date finalDate = cal.getTime();
```

``` java
//Obtener la fecha/hora actual:
Date now = new DateTime().toDate();
```

Como puedes ver, estamos usando el objeto DateTime de la librería Joda-Time como un proxy para crear los objetos Calendar y Date del JDK. No necesitas realizar ningún otro cambio en tu código legado, va a funcionar tal como lo hace actualmente. La diferencia es que ahora cuando escribas una prueba unitaria para éste código, obtienes un resultado determinístico ya que has fijado la hora del sistema a un valor que puedes usar como base para realizar tus aserciones. En el caso del ejemplo, puedes asegurarte de que el objeto Date resultante está 20 días después del 1 de Enero de 2016 a las 9am.

``` java
//Espero obtener una fecha 20 días después
DateTime expectedDate = new DateTime(2016, 1, 21, 9, 0, 0); 
assertThat(myTestSubject.getExpectedDate(), is(expectedDate.toDate()));
```

## Cerrando

Este truco me ha parecido muy simpático a la hora de probar tiempo en aplicaciones legado sin tener que recurrir a mocking complejo de los objetos de Java. Dado el suficiente tiempo para refactorizar, deberías hacerlo para que la clase utilice los objetos de Joda-Time, extrayendo un objeto Clock para obtener la hora y fecha actuales del sistema. Pero si el tiempo no está disponible, esto puede ayudarte a cubrir tu lógica de negocios con pruebas con un mínimo de impacto en tu aplicación legado. Incluso puedes envolver esto en [una regla de JUnit](https://github.com/junit-team/junit/wiki/Rules) para hacerlo más fácil de reutilizar en otras pruebas!

