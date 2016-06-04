+++
categories = ["Unit Testing", "JUnit", "Java"]
date = "2016-05-24T08:14:30-05:00"
description = ""
keywords = []
title = "Pruebas con tiempo en java 8"

+++
En [mi artículo anterior](/post/pruebas-con-tiempo-en-aplicaciones-legado/) revisé algunas técnicas para escribir pruebas que manipularan el tiempo en una aplicación legado. Hoy estaré compartiendo estrategias para escribir código que manipule el tiempo usando Java 8.

<!--more-->

Imaginemos que tenemos que escribir una clase que retorne un mensaje de bienvenida basado en el tiempo que ha pasado desde que el usuario entró por última vez al sistema. Aqui está el requermiento:

|Tiempo desde la última entrada | Mensaje de bienvenida |
|---------------------|------------------|
|<=10 minutos|Hola, no te he visto desde hace unos minutos!|
|> 10 mins, < 24 horas|"Hola, no te he visto desde hace un rato!"|
|>=24 horas < 48 horas|"Hola, no te he visto desde ayer!"|
|>=48 horas|"Hola, no te he visto desde hace mucho tiempo!"|

## Escribiendo clases que manipulen fecha/hora ##

Siempre que crees una clase en tu aplicación que trabaje con el tiempo, declara e inyecta un `Clock` para proveer acceso a la información de hora/tiempo actual. Por ejemplo:

```Java
public class GreetingsMessage {
    private Clock clock;
    public GreetingsMessage(Clock clock) {
        this.clock = clock;
    }
}
```

Existen diversas opciones para manejar las zonas de tiempo, dependiendo de la necesidad de tu aplicación. Inicializar el reloj con `Clock.systemDefaultZone();` utilizará la zona de tiempo del sistema. Alternativamente, si la aplicación va a trabajar en múltiples zonas de tiempo, `Clock.system(ZoneId zone);` permite establecer la zona de tiempo del usuario y ajustarse a esa región.

Una vez que el reloj se ha definido, crea las fechas y horas pasando el reloj como parámetro:
```Java
LocalDateTime currentDateTime = LocalDateTime.now(clock);
```

Todos los métodos del nuevo API para obtener la fecha u hora actual han sido sobrecargados para recibir el reloj como parámetro. 

## Preparando la prueba ##

Ahora, prepara la prueba para el mensaje de bienvenida. Las pruebas requieren entradas fijas para que el usuario pueda hacer aserciones de las reglas de negocio basándose en una fecha u hora fijada (Depender de la hora del sistema para pruebas producirá resultados débiles que no funcionan consistentemente). Aquí esta el código:
```Java
public class GreetingsMessageTest {

    private GreetingsMessage greetingsMessage;
    private final LocalDateTime REFERENCE_DATE_TIME = LocalDateTime.of(2016, 4, 1, 10, 0); //2016-04-01 at 10:00am
    private final ZoneId defaultZone = ZoneId.systemDefault();
    private final Clock FIXED_CLOCK = Clock.fixed(REFERENCE_DATE_TIME.atZone(defaultZone).toInstant(), defaultZone);

    @Before
    public void setup(){
        greetingsMessage = new GreetingsMessage(FIXED_CLOCK);
    }
}
```
Para este ejemplo, la fecha y hora de referencia ha sido definida como 1 de Abril de 2016 a las 10:00am. Como esto es una prueba, esta bien usar la zona de tiempo por defecto para construir el reloj. La constante `FIXED_CLOCK` contiene el reloj con la fecha de referencia fijada. Ahora, cada vez que el código llame `LocalDateTime.now(clock)` va a recibir 1 de Abril de 2016 a las 10:00am. Eso es suficientemente determinístico para escribir pruebas.

## Escribiendo pruebas con tiempo ##

La primera prueba ejecutará el escenario en el que el usuario entró al sistema hace 5 minutos.
```Java
@Test
public void testGreetingSinceMinutesAgo(){
    //Given
    LocalDateTime lastSeenInstant = REFERENCE_DATE_TIME.minus(5, ChronoUnit.MINUTES);

    //When
    String greeting = greetingsMessage.getMessage(lastSeenInstant);

    //Then
    assertEquals("Hello, I haven't see you in a few minutes!", greeting);
}
```

El parámetro `lastSeen` se deriva desde la hora de referencia de la prueba. Este caso usa las 9:55 a.m. del 1 de Abril de 2016, 5 minutos antes de la hora de referencia. [`LocalDateTime`](https://docs.oracle.com/javase/8/docs/api/java/time/LocalDateTime.html) describe métodos que ayudan a calcular un momento en el tiempo partiendo de un valor actual, puedes revisar el API para aprovechar esos métodos en tus pruebas. 

Tambien puedes probar el escenario de "ayer" usando un método diferente para restar un número de días de la fecha de referencia:

```Java
@Test public void testGreetingSinceYesterday(){
    //Given
    LocalDateTime lastSeen = REFERENCE_DATE_TIME.minusDays(1);

    //When
    String greeting = greetingsMessage.getMessage(lastSeen);

    //Then
    assertEquals("Hello, I haven't see you since yesterday!", greeting);
}	
```

Este ejemplo establece el valor de 10:00 a.m. del 31 de Marzo de 2016 para `lastSeen`. Aunque podrías crear este valor directamente, pienso que el uso del API ayuda con la legibilidad de la condición para esta prueba. 

Siguiendo estos pasos, puedes ir implementando las pruebas de tiempo. El ejemplo completo esta publicado en [mi cuenta de GitHub](https://github.com/adrianmoya/testingtimejava8). Felices pruebas con Java 8!

