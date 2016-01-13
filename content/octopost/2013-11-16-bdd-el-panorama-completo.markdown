---
title: "BDD: El panorama completo"
date: "2013-11-16"
comments: true
categories: 
- BDD
- Agilidad
type: post
---

El desarrollo guiado por comportamiento se vuelve cada vez más una técnica que todos quieren utilizar. Pero siento que no existe un concepto claro en la comunidad de qué implica utilizar BDD en un proyecto. Como muchos, comencé a explorar BDD desde el punto de vista de la automatización de escenarios. Pero a medida que fui profundizando en el estudio de BDD, descubrí que esto es sólo una pequeña parte de BDD, y que existe mucho más y se encuentra disperso en la internet por lo que es difícil ver el panorama completo.

Este post pretende ampliar la visión de BDD como metodología ágil, para aquellos que aún no han ido más allá de la automatización. 

<!--more-->

## El concepto de BDD, actualizado##

En el 2009, en un evento llamado [Agile specifications, BDD and Testing eXchange](http://skillsmatter.com/event/agile-testing/agile-specifications-bdd-and-testing-exchange), [Dan North](http://dannorth.net/), originador del término BDD, definío BDD como:

> BDD es una metodología ágil de segunda generación, de afuera hacia adentro, basada en demanda, de multiples interesados, multiple escala y alta automatización. Describe un ciclo de interacciones con salidas bien definidas, resultando en la entrega de software funcionando y probado que importa. 

Inicialmente para mi era dudoso llamar BDD una metodología hasta que pude ver este panorama completo (además si lo dijo Dan, ¿quién soy yo para decir lo contrario? :P). Lo cierto es que BDD es comparable a XP, en el sentido de que engloba una filosofía y un conjunto de prácticas a todos los niveles para llevar a cabo el desarrollo de un producto. BDD evoluciona constantemente y se apalanca en nuevas técnicas ágiles que van apareciendo, no es una receta prescrita de cosas que hay que hacer. Pero como metodología, tiene algo fundamental, la manera de abordar el desarrollo de software. 

Preparando mis láminas para las presentaciones de Desarrollo Ágil con BDD ([PHP](/2013/06/desarrollo-agil-con-bdd-en-php/) y [Java](/2013/07/desarrollo-agil-con-bdd-en-java/)), encontré este concepto largo, dificil de traducir y de colocar en la lámina. Me animé a preguntarle a Dan por twitter por un concepto corto y esencial de BDD. Dan contestó:

![](/images/2013/11/dan-north-bdd-tweet.png) 

> El uso de ejemplo en múltiples niveles para crear un entendimiento compartido y sacar a flote la incertidumbre para entregar software que importa.

Este nuevo concepto establece la escencia de BDD como metodología, y combinado con el anterior, nos permite ahondar en lo que significa realmente aplica desarrollo guiado por comportamiento.

## BDD es acerca de comunicación, no de automatización##

En sintonía con el [Manifiesto Ágil](http://agilemanifesto.org/iso/es/), BDD es una metodología que valora **Individuos e interacciones** sobre procesos y herramientas. Lo que sucede es que hay muchísimas herramientas para apoyar y automatizar la verificación de los ejemplos, y generalmente tendemos a conocer BDD a través de la herramienta. Pero si automatizas escenarios y no estás teniendo las conversaciones, no estás haciendo BDD. Si por el contrario, tienes las conversaciones, pero no automatizas los escenarios, estás aplicando BDD en tu proyecto.

¿Qué conversaciones debo tener? Pues conversaciones alrededor de los requerimientos y el dominio del proyecto, estableciendo ejemplos concretos acerca de cómo debe comportarse la aplicación. En estas conversaciones deben participar el cliente, los analistas de negocio, los desarrolladores y el equipo de pruebas. La comunicación entre todos es esencial para una buena aplicación de BDD a un proyecto. Las puedes llevar a cabo en el marco de un taller de especificaciones, que es una práctica que puedes realizar con cierta frecuencia para explorar nuevas características que el sistema debe cumplir.

La meta final de BDD es crear entendimiento compartido, creando un lenguaje ubicuo que mejore la comunicación, y que estas conversaciones permitan identificar cuales son los temas donde existe mayor incertidumbre y riesgo, para que sean atendidos temprano en el proyecto, cuando es menos costoso incorporar cambios.

## El panorama completo##

Veamos algunas prácticas ágiles que nos pueden dar soporte a nuestra aplicación de BDD en varios niveles. Algunas nacieron bajo el marco de BDD, otras son incorporadas al proceso porque se alinean perfectamente con BDD:

**Inyección de Características**: Esta técnica de análisis de proyecto fue concebida por Chris Matts para dar soporte a BDD en la fase de análisis, y permite trabajar desde afuera hacia adentro, tomando como punto de partida las salidas del sistema. Ayuda además a alinear los objetivos de la organización con el software que se desarrolla, mediante un proceso de búsqueda del valor real, la inyección de características que soporten ese valor, y la consecución de los ejemplos necesarios para comunicar como debe comportarse el sistema en los distintos escenarios. [Aquí](http://www.infoq.com/articles/feature-injection-success) un artículo sobre el tema.

**Especificación mediante ejemplos**: Este es el término general que [Gojko Adzic](http://gojko.net/) da al uso de ejemplos para comunicar utilizado en BDD. En su libro [Especificación Mediante Ejemplos](http://specificationbyexample.com/), Gojko habla de las experiencias de múltiples empresas aplicando distintas herramientas y formas en su proceso de desarrollo, y describe el proceso de los talleres de especificación, y de como partir del objetivo y derivar el alcance, especificar colaborativamente, ilustrar mediante ejemplos, refinar la especificación, automatizar la validación, validar frecuentemente evolucionar un sistema de documentación viva. De este tema tuve la oportunidad de compartir durante el [Agile Tour de Caracas en el 2012](http://comunidadagilven.wix.com/atccs12).

**Opciones Reales**: esta técnica, creada por Chris Matts, nos permite manejar los riesgos dentro de un proyecto de una manera ágil, aplicando técnicas basadas en la Teoría de Opciones Financieras, utilizada por inversionistas de la bolsa de valores. Siguiendo el mantra de que las opciones tienen valor, las opciones expiran, y nunca comprometerse temprano a menos que sepas el porque, Chris nos da herramientas que permite la toma de decisiones difiriéndolas hasta el ultimo momento responsable, muy en la onda de Lean Thinking. Más información [acá](http://www.infoq.com/articles/real-options-enhance-agility).

**Mapeo de impacto**: otra técnica de Gojko Adzic, que permite tener un panorama completo del proyecto y conocer quienes son los involucrados, permitiendo tener trazabilidad y dar respuesta a las preguntas Qué, Cómo, Cuando, y por qué del proyecto. Dentro del mundo BDD, está técnica es importante para cumplir la parte de "software que importa". Cuando Dan contestó mi tweet del concepto de BDD, me dio una variación mencionando a Gojko, y terminando el concepto en "software que impacte". Más info en el [sitio web del libro](http://impactmapping.org/).

**Descubrimiento Deliberado**: esta práctica fue introducida por Dan North, y consiste en identificar constantemente los puntos oscuros o de mayor incertidumbre dentro de un proyecto, y tomar tiempo para estudiar, experimentar y entender esos puntos, de forma deliberada, permitiendo que los equipos adquieran las habilidades, conocimientos técnicos o del negocio, y solventen cualquier otra incógnita que puedan tener que este deteniendo su productividad o impidiendo el avance del proyecto, e incluso descubrir las cosas que no sabemos que no sabemos. Aqui el [post de introducción](http://dannorth.net/2010/08/30/introducing-deliberate-discovery/) de Dan.

**BDD de historias**: es la práctica de tomar los ejemplos escritos en forma de escenarios y validarlos de forma automática haciendo uso de algún framework de pruebas. Es lo que comúnmente todo el mundo conoce como BDD. Esta técnica es principalmente útil para permitir que se valide el comportamiento de la aplicación en alineación a los objetivos y características descubiertas en la fase de análisis, y debe ser usada con moderación, pues las pruebas punto a punto que se escriben son las más costosas de ejecutar. Principalmente los caminos felices y las variaciones importantes deben ser abordadas. Más info en mi post [Describiendo Sistemas con BDD](/2013/02/describiendo-sistemas-con-bdd/)

**BDD de especificaciones**: esta práctica viene heredada de XP, y es esencialmente lo mismo que TDD. Trata de aplicar ejemplos en el ámbito meramente técnico, escribiendo ejemplos de código que permitan describir y validar el comportamiento de objetos y la comunicación con sus colaboradores a nivel del código. El cambio de nombre quizo crear una diferenciación en el énfasis de las pruebas, que pretenden comunicar intenciones y ser usadas como un mecanismo de diseño, ya que el nombre de TDD le daba una connotación muy orientada a pruebas, haciendo confuso entender el verdadero objetivo de la práctica. Más info en mi post [Diseñando objetos con BDD de especificaciones](/2013/05/disenando-objetos-con-bdd-de-especificaciones/).

## Software que importa##

Uno de los beneficios de usar BDD en un proyecto es lograr capturar con estás técnicas las características principales que dan valor a los involucrados, quienes no sólo son los usuarios del sistema, sino tambien quienes dan soporte, quienes deben velar por que se cumplan los temas legales, y principalmente, quienes estan poniendo el dinero para la realización del proyecto. Despues de todo, un proyecto de software es una inversión, y debe producir valor para la empresa que lo financia, ya sea aumentando sus ingresos, disminuyendo las pérdidas o protegiendo las ganancias actuales. 

Como pueden ver, BDD va muy de la mano con Lean, por lo que es una excelente metodología para crear productos mínimos viables, partiendo desde los objetivos que se quieren alcanzar y permitiéndonos (debido a que desarrollamos de afuera hacia adentro) reducir el desperdicio, y escribir software que importa.

## Líderes a quien seguir##

A continuación los líderes de este movimiento, a quienes puedes seguir en twitter y leer sus blogs para aprender más sobre toda esta metodología:

**Dan North**
[@tastapod](https://twitter.com/tastapod)
http://dannorth.net/blog/

**Liz Keogh**
[@lunivor](https://twitter.com/lunivore)
http://lizkeogh.com/

**Chris Matts**
[@PapaChrisMatts](https://twitter.com/PapaChrisMatts)
http://theitriskmanager.wordpress.com/

**Gojko Adzic**
[@gojkoadzic](http://twitter.com/gojkoadzic)
http://gojko.net/

## Conclusión##

Espero que este post ayude a ver un poco el panorama completo de lo que significa aplicar BDD, y permita recordar a los equipos que decidan aplicarlo que no dejen de lado los principios del manifiesto ágil, e introduzcan estas técnicas de forma que apoyen su proceso y les permitan entregar de manera más rápida y eficiente.
