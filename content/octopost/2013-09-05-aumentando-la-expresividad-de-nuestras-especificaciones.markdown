---
title: "Aumentando la expresividad de nuestras especificaciones"
date: "2013-09-05"
comments: true
categories: 
- TDD
- Agilidad
- JUnit
type: post
---
En el post anterior, vimos como [aplicar el patrón databuilder](/2013/07/utilizando-el-patron-databuilder-en-nuestras-pruebas-unitarias/) puede ayudarnos a escribir el contexto inicial de nuestras especificaciones de manera más clara. En este artículo describiré algunas técnicas adicionales que ayudan a mejorar la expresividad de las pruebas.

<!--more-->

## ¿Por qué es importante escribir pruebas expresivas? ##
Cuando estamos aplicando una técnica como TDD/BDDSpec, vamos escribiendo especificaciones (pruebas, ejemplos de código) para describir cómo debe comportarse cada método de nuestros objetos. En el momento de escribirlas, tenemos fresco en la mente la funcionalidad que queremos lograr, y el significado de los resultados. Pero a medida que un sistema crece, y vamos pasando nuestro enfoque a otras partes del sistema, podemos pasar mucho tiempo sin volver a tocar estas pruebas, hasta que un día lejano, mientras construimos una nueva funcionalidad, rompemos una de las viejas pruebas.

Es ahí cuando es importante la manera en que escribimos la especificación. Si no fuimos suficientemente expresivos, sabemos que la prueba que se rompió nos indica que hicimos algo que no debíamos, o que debemos refactorizar para incorporar el nuevo cambio. Pero exactamente ¿qué está pasando? ¿qué significa la barra roja? En este momento es útil haber aplicado algunas técnicas para que nuestra especificación fuera más sencilla de leer y entender en el futuro.

Igualmente, cuando un nuevo miembro del equipo inicia a trabajar en un proyecto, le es más sencillo entender el diseño si las pruebas estan escritas de manera clara y expresando intención de lo que queremos hacer y las condiciones bajo las cuales se ejecuta el objeto bajo prueba.

## Nombres de pruebas descriptivos ##

Esta es básica, el nombre de nuestra prueba debe denotar la intención de la misma. En lugar de llamarla `testAlert`, deberiamos expresar con claridad que tipo de alerta y bajo que codiciones: `it_should_send_an_alert_when_balance_is_below_limit` expresa más claramente que se trata de una alerta cuando el balance esta por debajo de un límite. Si no te gusta usar `_` en el nombre (que es la manera más legible de escribir el nombre de la prueba en mi opinión) puedes usar el tradicional camelCase: `itShouldSendAnAlertWhenBalanceIsBelowLimit`. Incluso si sigues el tradicional patrón TDD de comenzar el método con la palabra `test`, asegurate de expresar de que trata la prueba `testSendAlertWhenBalanceIsBelowLimit`. Hay plugins para los IDEs que automáticamente separan estos nombres para colocar los espacios donde corresponde y que puedas leer claramente los títulos de cada prueba (por ejemplo [StoryTeller](http://marketplace.eclipse.org/content/storyteller) para eclipse). 

## Mensajes de error descriptivos ##

Todos conocen que existen 3 pasos que repetimos constantemente cuando diseñamos usando ejemplos de código: Escribir una prueba y que falle (rojo), que escribamos el mínimo código necesario para que pase (verde), y que refactoricemos el código para evitar duplicidad e incorporar mejores prácticas. Pero existe un paso implícito que viene después de que hacemos que la prueba falle, y es hacer que el mensaje de error exprese de manera clara que es lo que sucede antes de hacer pasar la prueba.

No es suficiente con decir al final de una prueba que se valide que un resultado sea true. Cuando un mensaje de error dice que verdadero no es falso o que 20 es distinto de 25, esto no expresa aún qué esta pasando en la prueba, sobre todo si tenemos meses sin trabajar en esa sección del código. Se debe usar el parámetro `message` que reciben las assertions para describir con más claridad que significa ese verdadero o que significa ese 20. Un mensaje de error que diga "Descuento de venta: se esperaba 20 y se obtuvo 25" claramente indica que se trata del descuento de venta que no se esta recibiendo correctamente.

Asi mismo cuando comparamos objetos, por lo general el mensaje de error muestra unos garabatos que representan la dirección de memoria del objeto. Esto no ayuda a determinar el error (más que saber que los dos objetos no son iguales, el mensaje será algo como "Expected: TaxItem@123456 but was TaxItem@23456"). Si sobreescribimos el método toString() del objeto, imprimiendo sus propiedades importantes separadas por coma, es más sencillo cuando los objetos no son iguales saber que propiedad es la que no es igual. Ejemplo:

``` java
//TaxItem.java
    @Override
    public String toString() {
        return "TaxItem{" + "value=" + value + ", amount=" + amount + '}';
    }
```

Nos dará un mensaje como "Expected: TaxItem{value=12.00, amount=200.00} but was TaxItem{value=16.00, amount=200.00}", lo que nos permitirá ver que los objetos son distintos porque la propiedad value es distinta.

## Usar comentarios para separar las tres fases de la prueba ##

Separar claramente el contexto, el ejemplo de código que se especifica, y las validaciones finales, hacen que una prueba sea mucho más legible. Puedes usar comentarios, como `//Arrange //Act //Assert` o `//Given //When //Then`. Esto ayuda permite al lector enfocarse en cada segmento, pudiendo ver con claridad el contexto, o por ejemplo concentrándose en cual es la operación que se está probando o qué resultados se esperan. Comentarios adicionales dentro de cada sección también ayudan si sientes que es necesario explicar algo adicional, pero si como mínimo tienes estos 3 comentarios separando las secciones ya estás ganando en expresividad.

## Usar nombres de variables descriptivos ##

Bueno, esta técnica la heredamos de la escritura de código limpio, pero en especial es útil cuando escribimos pruebas. Supongamos que vamos a pasar en el constructor o en algún método del objeto un párametro que representa un usuario bloqueado. En lugar de solo construir una variable `user`, podemos llamarla `blockedUser`, y de esta manera quien lee la prueba a simple vista puede notar que el usuario que pasamos está bloqueado. O por ejemplo, vamos a pasar un colaborador en un constructor que para el ejemplo que estamos escribiendo no es necesario, pero que por ser parte del constructor igual necesitamos pasarlo. En lugar de pasar `null`, podemos definir una variable llamada `unusedLogger` igual a `null` y pasarla como parámetro. De nuevo, la prueba será más legible porque no ponemos al lector a preguntarse que es ese `null` que recibe la clase sino que de una vez entiende que es un Logger pero que no se usará. 

Finalmente, si una prueba devuelve `null`, y esto significa por ejemplo que un usuario no es encontrado (suponiendo que sea un método de búsqueda de usuario por id), entonces en lugar de hacer un assert que chequée que se devolvió `null`, definimos una constante `Customer NO_CUSTOMER_FOUND = null` y assertamos que el resultado sea igual a esta constante. Al leer la prueba, estaremos comunicando que significa que la operación devuelva `null`.

## Expresar todo el contexto de la prueba en la prueba ##

Aunque pueda parecer buena práctica construir algunos objetos en un método setup o algo similar, o heredando de otras clases con setups más complicados, lo cierto es que todas las pruebas deberían poder leerse completas sin obligar al lector a buscar de donde salen los objetos que estamos usando. Probablemente si una prueba falla, el desarrollador irá directamente a esa prueba a ver que pasa. Lo mejor es que pueda leer ahí mismo el contexto, como se construyeron los objetos que se usan en la prueba, sin tener que comenzar a viajar por otras partes del código de prueba para entender. Esto no quiere decir que si hay alguna operación de setup repetitiva no podamos extraerla a un método utilitario, siempre y cuando dicho método tenga un nombre expresivo y sea usado al comienzo de todas las pruebas que requieren dicho setup. De eso trata la próxima técnica.

## Usar métodos y clases ayudadoras (Helpers) ##

Ya vimos un ejemplo de una clase ayudadora en el post anterior cuando hablé de los [databuilders](/2013/07/utilizando-el-patron-databuilder-en-nuestras-pruebas-unitarias/). Esta es una clase que nos permite construir el contexto de manera expresiva, ayudando al lector de la prueba a ver como estan construidos los objetos. Otros ejemplos de clases ayudadoras podrían ser fábricas para construir algunos colaboradores más complejos. Recordemos que añadir un método estático con nombres descriptivos ayuda aún más a entender lo que estamos haciendo.

También se pueden crear métodos privados dentro de la clase de prueba que ayuden a comunicar nuestras intenciones y nos permitan reutilizar algo de código de las pruebas que sólo estén relacionados con ese set de pruebas. Por ejemplo si tenemos varias pruebas que requieren una factura con algunos ítems, podemos crear un método `anAccountWithSomeItems()` que internamente utilice los builders para construir este elemento. Sin embargo, debemos cuidar de no ocultarle información al lector usando los métodos privados. Es recomendable expresar las condiciones importantes para la prueba claramente, como describe la siguiente técnica.

## Enfocarse en lo que es importante (no añadir detalles sin importancia) ##

Dentro de una prueba, debemos enfocarnos en escribir de manera explícita todas las condiciones que afectan la prueba y no más. Algunas pruebas requieren de ciertas condiciones complejas que hay que colocar en el contexto. Para aquellas cosas que no sean de importancia (como agregar usuarios adicionales o transacciones dummy o cualquier otra cosa que se necesiten para completar el contexto pero que los detalles no afectarán la prueba en cuestión) podemos usar métodos helpers. Pero para aquellos elementos directamente relacionados con la prueba que hacemos, asegurémonos de expresar bien claro el contexto. 

Igualmente si vamos a validar la comunicación con los dobles, verifiquemos solo aquellas llamadas que realmente forman parte de las validaciones de la prueba en cuestión, y dejemos flexible la validación de otras llamadas que se hagan a los colaboradores. 

## Una prueba por cada funcionalidad ##

Hay operaciones que realizan más de una actividad dentro del sistema, como por ejemplo persistir un objeto en una BD y tambien enviar una alerta a otro sistema. En estos casos lo recomendable es hacer una prueba por cada una de estas actividades que realiza la operación, y NO MEZCLAR multiples aserciones y validaciones dentro de una sola prueba, pues hace que la misma se vuelva más compleja y difícil de leer. Es preferible tener multiples pruebas, una por cada actividad y así si falla una sola actividad, tenemos una prueba enfocada que nos dice claramente que es lo que falló y no una prueba compleja que chequea muchas cosas y que sea complicado saber en que parte está fallando. 

## Finalmente ##

Aplicando estas simples técnicas ganaremos mucho en expresividad y comunicación de nuestra intención en cada prueba, lograremos que las pruebas documenten el código y se nos hará mas fácil entender que pasa cuando tengamos que lidiar con estas pruebas más adelante en la evolución de nuestra aplicación. Tengamos siempre presente expresar la prueba desde el punto de vista de qué queremos lograr y no del cómo lo estamos implementando. Hasta la próxima!
