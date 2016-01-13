---
title: "Diseñando objetos con BDD de especificaciones"
date: "2013-05-12"
slug: disenando-objetos-con-bdd-de-especificaciones
comments: true
categories: 
- BDD
- Agilidad
- POO
type: post
---

Ya hemos visto en los artículos anteriores como utilizar el lenguaje natural del cliente para [describir un sistema utilizando BDD de historias](/2013/02/describiendo-sistemas-con-bdd/), y comunicar el comportamiento esperado a través de un conjunto de escenarios. Hoy comenzaremos a adentrarnos en el segundo nivel de BDD, para especificar el comportamiento del sistema a nivel técnico.

<!--more-->

Un sistema, desarrollado bajo el paradigma de la [programación orientada a objetos](http://es.wikipedia.org/wiki/Programaci%C3%B3n_orientada_a_objetos), esta conformado por un conjunto de objetos con responsabilidades bien definidas, que intercambian mensajes para colaborar en la consecución de un objetivo de negocio. La responsabilidad del diseño e implementación de estas unidades de trabajo reposa sobre el equipo de desarrollo del proyecto, y BDD de especificaciones es el conjunto de técnicas de BDD que los ayuda a realizar este trabajo. A diferencia de BDD de historias, donde participan todos los interesados en el proyecto, la especificación de objetos es un tema técnico y la descripción del comportamiento de los objetos se realizan a este nivel.

## Principios S.O.L.I.D.##

Los [principios S.O.L.I.D.](http://www.genbetadev.com/paradigmas-de-programacion/solid-cinco-principios-basicos-de-diseno-de-clases) son un conjunto de cinco principios de la programación orientada a objetos que debemos tomar en consideración cuando diseñamos aplicaciones. Aplicándolos, lograremos diseñar sistemas fáciles de mantener y ampliables en el tiempo. 

BDD de especificaciones es una disciplina de diseño que nos ayuda a contruir código que sea fácil de probar y que cumpla con estos principios recomendados, pues al escribir primero las especificaciones de nuestro objeto, y describiendo mediante ejemplos concretos de código como debe comportarse, podremos identificar si un objeto tiene demasiadas responsabilidades (los ejemplos de código se verán muy largos), o si los objetos están demasiado acoplados (código dificil de probar), etc.

## ¿Es BDD de especificaciones lo mismo que TDD?##

Ambas prácticas ágiles son escencialmente lo mismo y comparten la misma filosofía. [TDD o Desarrollo Guiado por pruebas](http://es.wikipedia.org/wiki/Desarrollo_guiado_por_pruebas) fue la práctica pionera en el tema de diseñar sistemas partiendo de un conjunto de pruebas que fallan, y que luego el desarrollador implementa para hacerlas pasar, finalmente refactorizando el código para eliminar la duplicación y dejar el código limpio. 

El cambio que introdujo BDD a la formula es el del lenguaje. Al cambiar la palabra pruebas por especificaciones, algo en nuestro cerebro nos permite concentrarnos más en el aspecto de diseño (y no en el de conseguir errores) que es la idea original de ambas prácticas. Ya no hablamos de escribir pruebas del objeto, sino de describir su comportamiento mediante ejemplos. El cambio incluso ayuda a documentar mejor nuestra clase a nivel técnico, pues cuidamos que los nombres de los métodos en nuestra clase de prueba expresen el comportamiento de la clase que estamos especificando. Aunque finalmente escribimos una prueba automatizada que valida que el comportamiento es el esperado, el cambio del lenguaje utilizado es importante para ayudarnos a determinar que pruebas escribir. 

## ¿Qué clases debo especificar o describir?##

Lo más dificil cuando se comienza con BDD de especificaciones es saber qué clases debo especificar. Aqui es importante tener presente que en muchos lenguajes de programación orientados a objetos, los valores (que modelan cantidades o mediciones) y los objetos (que modelan procesos computacionales) son implementados a través de clases. Es importante que entendamos esta diferencia, pues queremos especificar son las clases que representan objetos, osea las que tienen una identificación y mantienen estado. 

Si una clase solo tiene propiedades (por ejemplo un bean de java), y si al comparar dos instancias con las mismas propiedades, podemos decir que son iguales, entonces esta clase representa un valor. Los valores también se acostumbran a implementar a través de clases inmutables.

Si una clase mantiene un estado, y este estado cambia dependiendo de los mensajes que reciba la clase en el tiempo, es un objeto, y es candidato de especificar a través de BDD. Dos instancias de un objeto tienen identidades distintas, aunque compartan el mismo estado en algun momento.

Más información acerca de la diferencia entre valores y objetos la puedes encontran en el capítulo 2 de [Growing Object Oriented Software Guided By Tests](http://www.amazon.com/Growing-Object-Oriented-Software-Guided-Tests/dp/0321503627/).

## Describiendo el comportamiento con ejemplos de código##

Habiendo identificado una clase que representa un objeto, entonces puedo comenzar a especificar su comportamiento escribiendo ejemplos de código donde dado un cierto contexto inicial, el cual determino programáticamente en el ejemplo, cuando llamo un método del objeto con unos valores predeterminados, verifico que el objeto se comporte como es esperado. La idea es muy similar al Dado/Cuando/Entonces de BDD de historias, solo que esta vez escribimos el ejemplo con código en un lenguaje de programación. Para cada ejemplo, podemos utilizar el patrón [Arrange Act Assert](http://www.arrangeactassert.com/why-and-what-is-arrange-act-assert/) para que el código del ejemplo sea más entendible. 

Existen dos puntos que queremos diseñar: las operaciones del objeto (su interfaz pública) y la manera en que colabora con otros objetos para conseguir su objetivo.

## Especificando las operaciones##

Es importante que pensemos en el objeto como una caja negra. Nos importa especificar el comportamiento visible del objeto desde afuera, osea cuales serán sus métodos públicos y no saber como hace las cosas internamente, ni mucho menos como guarda sus propiedades internas. Esto es lo que se conoce en POO como [encapsulamiento](http://es.wikipedia.org/wiki/Encapsulamiento_(inform%C3%A1tica\)), y debemos respetarlo, asi que no te preocupes acerca de como acceder a propiedades privadas de un objeto durante la fase de verificación, ni si llamó a algun método interno, enfoca las pruebas en el comportamiento visible del objeto a través de sus operaciones públicas. Nunca es necesario escribir métodos de acceso a propiedades solo para verificar que cambiaron correctamente, estarías escribiendo código que tu objeto no necesita. Para validar que un objeto cambió de estado, escribe un ejemplo de código de alguna operación pública que se vea afectada por el estado, y verifica que la respuesta es la esperada.

Al escribir el ejemplo de código, y ejecutarlo, va a fallar, cumpliéndose la fase roja de las pruebas. Entonces podemos concentrarnos en implementar la clase de manera de que el ejemplo se ejecute y pase (verde). Finalmente podemos refactorizar el código para mejorar su estructura. Como puedes ver, es exactamente lo mismo que TDD, pero nóten como usando lenguaje BDD y hablando de comportamiento visible, es un poco más sencillo escribir las pruebas.

## Especificando los mensajes entre objetos##

Solo los objetos más básicos realizan operaciones por ellos mismos sin necesidad de colaborar con otros objetos. Pero en la mayoría de aplicaciones de la vida real, vamos a querer que nuestros objetos interactúen con otros enviandose mensajes (haciendo llamadas a través de sus operaciones públicas).

Durante el diseño de una operación que necesite de un colaborador (otro objeto) para llevarse a cabo, debemos utilizar lo que se conoce en el mundo de las pruebas un doble. En el próximo artículo hablaré más en profundidad de los dobles, por ahora solo diré que nos permiten entonces diseñar cuales son los mensajes que van a intercambiar nuestros objetos, pudiendo validar al final de cada ejemplo de código que los mensajes se pasaron correctamente entre ellos, y también cuantos mensajes se pasaron y cuales colaboradores. 

## Las herramientas##

Cualquier herramienta de pruebas unitarias, como la familia xUnit, puede servirnos para aplicar BDD de especificaciones. En java por ejemplo, con [JUnit](http://junit.org/) es suficiente. Sin embargo, algunos lenguajes de programación cuentan con herramientas especializadas para esta tarea, que agregan una que otra conveniencia a la hora de especificar comportamiento mediante código. Tal es el caso de la pionera en el tema, [RSpec](http://rspec.info/) que es la herramienta para el lenguaje [Ruby](http://www.ruby-lang.org/es/). [PHP](http://php.net/) también cuentan con una herramienta moderna para la práctica, llamada [PHPSpec](http://www.phpspec.net/). [JNario](http://jnario.org/) es otro proyecto interesante para java, pero que a la fecha no soporta internacionalización. Seguramente habrá otras que no conozco y saldrán nuevas herramientas, lo mejor es buscar un poco antes de comenzar.

## Tips y notas finales##

- La práctica hace al maestro. Describir objetos mediante ejemplos de código con BDD es algo que requiere práctica. Acércate a la comunidad ágil de tu localidad y verifica si están realizando [dojos de codificación](/2013/02/participando-en-dojos-de-agilidad/), son una excelente manera de practicar esta técnica en un ambiente relajado.

- Recuerda que al igual que BDD de historias, los ejemplos deben ser concretos. No escribas aserciones contra variables, ej. `assertEquals(nombreEsperado, nombreRecibido)`, pues vas a terminar implementando el código de la clase en el ejemplo! Usa siempre valores concretos de un par de casos borde o algun caso representativo de la funcionalidad, ej. `assertEquals("Adrian", nombre)`.

- El código de prueba debe ser tratado tambien como el código de la aplicación, en el sentido de que debes refactorizar y mantenerlo siempre en buen estado, para que no se convierta en una carga más adelante.

- Al comienzo te va a parecer muy lento especificar mediante ejemplos de códigos, pero esto es porque no tienes nada de código de prueba. Pero siguiendo la recomendación anterior, vas a comenzar a identificar y codificar funciones que te van a ir ayudando con las pruebas y la velocidad va a mejorar considerablemente.

- Cuando tengas una suite de ejemplos que valide que el comportamiento de tus clases es el esperado, podrás refactorizar, hacer cambios y mejorar el sistema con confianza, pues si alteras algun comportamiento imprevisto, tus especificaciones te notificarán enseguida.
