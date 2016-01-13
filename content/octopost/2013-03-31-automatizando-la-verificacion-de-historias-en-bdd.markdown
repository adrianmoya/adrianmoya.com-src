---
title: "Automatizando la verificación de historias en BDD"
slug: automatizando-la-verificacion-de-historias-en-bdd
date: "2013-03-31"
comments: true
categories: 
- BDD
- Agilidad
type: post
---

En el artículo [Describiendo Sistemas con BDD](/2013/02/describiendo-sistemas-con-bdd/), vimos como escribir los requerimientos de un sistema utilizando el lenguaje natural del cliente, y describiendo los escenarios principales mediante una serie de pasos. En este artículo comentaré acerca de cómo automatizar estos requerimientos, y algunos tips que debemos tener en cuenta.

<!--more-->

## ¿Por qué automatizar la verificación de mis requerimientos? ##

Voy a comenzar hablando del valor que tiene para nosotros automatizar la verificación de nuestros requerimientos. De esta manera, cuando entremos en materia acerca del trabajo que implica automatizar la prueba, podremos responder a la pregunta "¿De verdad todo esto vale la pena?". Ciertamente automatizar nuestras pruebas requiere codificar las pruebas, configurar las herramientas, e incluso mantener el código de pruebas al dia, una tarea que puede parecer muy costosa si no entendemos el valor que nos proporciona.

Construir pruebas automatizadas de los requerimientos:

- **Ayuda a validar que lo que está haciendo el sistema es realmente lo que se está pidiendo**: La prueba verifica que se este cumpliendo lo que dice la especificación, por tanto solo pasará si realmente implementé la especificación en mi sistema.
- **Avisa de inmediato si introduje algún comportamiento indeseado en el sistema**: A medida que un sistema crece, y vamos agregando nuevos requerimientos, es posible que modifiquemos código que esta involucrado en otras funcionalidades, y sin querer introduzcamos un cambio no deseado. Las pruebas funcionan como una red de seguridad que nos avisa de inmediato si el código que estamos escribiendo está afectando el comportamiento de las otras partes del sistema, y podemos tomar medidas para corregir el error y mantener el funcionamiento tal como esta descrito en las especificaciones. 
- **Nos ayuda a mantener las especificaciones al día:** En caso de que cambiemos el comportamiento del sistema porque nuestro cliente así lo decidió (somos ágiles, estamos abiertos a aceptar cambios durante el desarrollo), o porque algo no se contempló inicialmente, actualizar el requerimiento para que especifique el comportamiento REAL del sistema permite que mis especificaciones sirvan como documentación actualizada.

En general, automatizar mis pruebas a este nivel nos da la paz mental de que estamos construyendo software que agrega valor al cliente y que ese valor no se pierde a medida que el sistema crece. 

## Pruebas de integración, no unitarias ##

Cuando queremos automatizar la prueba de una especificación en BDD de historias, debemos tener en cuenta que vamos a probar el sistema **como un todo**. Estamos describiendo el comportamiento del producto final, y no de sus partes individuales. Esto es importante tenerlo en cuenta, pues debemos enfocarnos en que la automatización simule la manera en que un usuario utilizaría nuestra aplicación, y evitar entrar en pruebas de clases o código particular, que es el tipo de pruebas que dejaremos en manos de **BDD de especificaciones**, del cual hablaré en un futuro artículo.

Muchos se preguntarán si no deberíamos estar probando las partes del sistema antes de probar el todo. BDD como metodología de diseño de sistemas toma un camino que va desde afuera hacia adentro, por tanto primero se asegura de que el producto final se comporta como quiere el cliente, que es lo que realmente le da valor al sistema. El cómo funciona el sistema para lograr ese comportamiento deseado se especifica y prueba después. Esto es lo que se conoce como el ciclo doble en BDD. 

## Ciclo BDD ##

![](/images/2013/03/ciclobdd.png)

Iniciamos en un ciclo externo, donde escribimos la prueba de la especificación (paso 1 en la imagen), la misma falla. Luego entramos en un ciclo interno donde vamos escribiendo la especificación de nuestras clases (pasos 2, 3 y 4) y que se repite hasta que todo lo necesario para hacer pasar la prueba externa este listo (paso 5), y finalmente tambien refactorizamos a nivel del ciclo externo (paso 6). El ciclo externo lo repetimos hasta que todas las historias estén codificadas.

## Herramientas y frameworks para automatizar ##

Existen varias herramientas que podemos usar para automatizar nuestras pruebas BDD. A nivel de BDD de historias, la más famosa es [Cucumber](http://cukes.info/). Inicialmente era una herramienta que nos permitía automatizar nuestras especificaciones escribiendo código en [Ruby](http://www.ruby-lang.org/es/). Recientemente fue reescrita totalmente en java, y nos permite utilizarla con proyectos en cualquier lenguaje que corra en la JVM (Java, Ruby, Python, etc). Para PHP, tenemos a [Behat](http://behat.org/). En java tambien tenemos [JBehave](http://jbehave.org/), que fue desarrollada por Dan North. Hay muchas otras herramientas que varian en madurez y lenguaje utilizado, aquella a elegir va a depender de las necesidades particulares de nuestro proyecto. Personalmente recomiendo Cucumber y Behat. Con ambas estan cubiertas la mayoría de los lenguajes. 

Estas herramientas nos permitirán crear el código necesario para automatizar una prueba partiendo de un archivo de características (feature file), que no es más que un archivo de texto con la especificación tal cual la escribimos siguiendo las pautas del artículo [Describiendo sistemas con BDD](/2013/02/describiendo-sistemas-con-bdd/). La herramienta identifica dentro del texto las palabras claves Escenario, Dado, Cuando, Entonces. Por cada paso de nuestro escenario, se genera un método dentro del cual podemos escribir código que automatice ese paso. 

Escribiendo cuidadosamente nuestras especificaciones, vamos a poder reutilizar los pasos que vayamos codificando, haciendo que la automatización de las pruebas se vaya haciendo cada vez más sencilla. Dejare un ejemplo concreto para un próximo artículo.

Además de las herramientas de BDD, también es útil apoyarnos en otros frameworks de pruebas. Recordemos que queremos probar el sistema tal cual como lo haría el cliente. Si por ejemplo, nuestra aplicación es una aplicación web, debemos entonces utilizar un framework que nos permita controlar un navegador web para poder conectarnos a la aplicación. En este caso, uno de los más utilizados es [Selenium Webdriver](http://docs.seleniumhq.org/docs/03_webdriver.jsp) (o simplemente Selenium), que es un API que nos abstrae del navegador real, y nos permite escribir pruebas que puedan ser utilizadas con el (o los) navegadores de nuestra preferencia. En el caso de PHP, tenemos [Mink](http://mink.behat.org/) que cumple la misma función. Tambien podemos utilizar otros frameworks que interactúen directamente a traves de HTTP (por ejemplo, si vamos a probar webservices REST, podriamos usar [HttpUnit](http://httpunit.sourceforge.net/) directamente para consumir los servicios y verificar las cabeceras de respuestas). O si vamos a probar una aplicación swing, podemos usar [Window Licker](https://code.google.com/p/windowlicker/).

Lo importante es siempre tener en consideración que debemos realizar la prueba controlando el sistema desde afuera, como si fueramos el cliente.

## Tips y notas finales ##

- Para llevar el sistema al estado requerido para una prueba particular, podemos bajar de nivel: Si bien es cierto que la prueba como tal debe ser programada simulando la interacción a nivel del cliente, a veces es necesario establecer el contexto de la prueba (por ejemplo, introducir algunos usuarios a la base de datos, o activar o desactivar alguna opción). Este tipo de actividad, que se refiere a preparar el contexto (o estado del sistema) para poder realizar la prueba, podemos realizarla a un nivel más bajo. Esto quiere decir que no vamos a correr la prueba de registro de usuario 10 veces para incluir 10 usuarios, podemos simplemente hacer un query que ingrese la data necesaria en el estado que la necesitamos. Para esto podemos apoyarnos con patrones como el [TestDataBuilder](http://codebetter.com/iancooper/2008/10/17/testdatabuilders/), que permita construir data válida dentro del sistema.

- Cuando es una aplicación orientada a datos (Crear, modificar, eliminar datos de una base de datos), debemos configurar nuestras pruebas para que utilicen una base de datos de prueba, preferiblemente del mismo tipo que utilizaremos cuando el sistema este en producción. Si estas usando un [ORM](http://es.wikipedia.org/wiki/Mapeo_objeto-relacional), pudieramos sustituir la BD por una más rápida en memoria, pero lo ideal es que sea la misma para evitar sorpresas imprevistas. Nuestro código de pruebas será responsable de inicializar la BD al estado deseado antes de la prueba, y limpiar la BD al final. Debemos garantizar que cada prueba inicia SIEMPRE en el mismo estado que esperamos, y que deja la base de datos limpia de registros para que la próxima prueba se inicie. Esto es clave para poder confiar plenamente en las pruebas. También es importante que si trabajamos en un equipo, cada desarrollador tenga una copia local donde ejecutar sus pruebas sin afectar las pruebas que pudiera estar haciendo otro miembro del equipo. Tener una base de datos para prueba compartida por un equipo es una fuente segura de problemas a la hora de ejecutar las pruebas automatizadas.

- El código de las pruebas, al igual que el del sistema, debe cumplir con los estándares de calidad. A medida que desarrollamos el sistema, y vamos escribiendo más pruebas, es importante que el código se mantenga legible, y que refactoricemos donde sea necesario para poder reutilizar las clases que nos ayuden en las pruebas. En el caso de la verificación de historias, validar si tenemos pasos similares y buscar escribirlos de la misma manera, o identificar términos distintos que se refieren a lo mismo, permite ir construyendo un lenguaje ubicuo donde no existan ambiguedades y donde podemos reutilizar los métodos de prueba y así escribir menos código y ser más efectivos.

- Finalmente, como estas son pruebas de integración, debemos siempre ejecutar primero las pruebas de unidad, para saber que todo funciona a nivel de clases, para luego empaquetar la aplicación y desplegarla en el ambiente en el cual se realizarán las pruebas. Esto no tiene que ver con el orden en que se escriben y fallan las pruebas, que ya fue discutido en éste artículo, sino más bien con la optimización de la ejecución de pruebas automatizadas.

- Cuando probemos aplicaciones web, en lo posible debemos usar un navegador "programático", es decir, uno que simplemente ejecute las llamadas al servidor y devuelva las respuestas. Esto es mucho más rápido de ejecutarse y no depende de que tengamos instalado un navegador particular al momento de realizar las pruebas. La única desventaja es que el navegador programático no funciona cuando necesitamos probar javascript. Asi que si queremos probar aplicaciones que utilicen ajax, o generen eventos en javascript, no nos queda de otra que utilizar un navegador real. Los frameworks aqui mencionados nos permiten usar ambos navegadores sin necesidad de cambiar el código de las pruebas, e incluso podemos ejecutar un grupo de pruebas con un tipo de navegador y el resto con el otro tipo. 

En el próximo artículo voy a estar describiendo un ejemplo concreto de BDD de historias. Lo voy a escribir en Java utilizando cucumber-jvm, y compartiré el código con ustedes. Hasta la próxima!
