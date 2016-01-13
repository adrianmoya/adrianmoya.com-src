---
title: "Introducción a Desarrollo Guiado por Comportamiento (BDD)"
date: "2013-01-19"
comments: true
slug: introduccion-a-desarrollo-guiado-por-comportamiento-bdd
categories: 
- Agilidad
- BDD
type: post
---

A finales del año 2011 decidí que el 2012 sería el año en el que me enfocaría en aprender todo lo relacionado a las prácticas de pruebas del mundo ágil. Ya para ese entonces escuchaba y leía de BDD (Desarrollo guiado por comportamiento) pero decidí que me enfocaría en TDD "puro y simple" antes de comenzar a explorar otras prácticas "más avanzadas". Y ahí fue cuando comenzo mi frustración.

<!--more-->

## TDD es difícil de aprender##

Si tomas a un programador productivo (que entrega su trabajo en un tiempo razonable) y le dices "ahora vamos a comenzar a escribir pruebas primero, para ser ágiles (y tener una matriz de seguridad automatizada y blah blah), verás como comienza un proceso de frustración que termina en improductividad total, donde el pobre comienza golpeándose con un gran muro de preguntas y dificultades que practicamente detienen el desarrollo. No hablo de hacer el bendito kata de la calculadora, que muchos pueden hacer y pensar que han dominado TDD, hablo de comenzar a desarrollar un nuevo módulo para una aplicación JEE o PHP dentro del tiempo requerido para poder salir a producción. La presión de entregar código funcional con algo de calidad en un tiempo razonable hace que el tiempo necesario en aprender la práctica sea simplemente inaceptable. Al menos sin un entrenador formal con experiencia que pueda guiar al equipo en sus primeros pasos. 

## Cómo llegué a BDD##

Habiendo desechado el tema de las pruebas para volver a mi productividad normal, pero quedando con la espina de dominar esta práctica agil, comencé a notar que habian "unas pruebas escritas en lenguaje natural". Y sentí una puerta abierta a explorar nuevamente el mundo de las pruebas. En ese momento conocí [Behat](http://behat.org). La verdad quedé enamorado de la posibilidad de escribir en castellano cómo quería que funcionara el código y que la herramienta me permitiera automatizar una prueba basada en el documento. Y entonces caí en cuenta que esto se trataba de BDD (o mejor dicho, de Story BDD). 

## Un nuevo aire en el mundo de las pruebas (especificaciones?) automatizadas##

Conocer Behat, y comenzar a escribir escenarios y pasos me infundio de un nuevo ánimo para estudiar el mundo de las pruebas y de BDD. Descubrí que la práctica buscaba en esencia mejorar la comunicación entre el equipo y a través del uso de un lenguaje basado en escenarios y en Dado/Cuando/Entonces, se iba construyendo un lenguaje ubicuo que expresaba claramente los objetivos del proyecto, permitiendo menos ambiguedades en los requerimientos. Aprendí además que BDD era en esencia lo mismo que TDD (un poco sobre esto más adelante), y que las prácticas estaban enfocadas en el diseño de la aplicación más que en las pruebas como tal, por tanto los practicantes de BDD sugirieron un cambio en el lenguaje (en lugar de pruebas, hablar de comportamientos, en lugar de caso de prueba, hablar de ejemplo). 

Descubrí tambien que la práctica existe a dos niveles, siendo StoryBDD la parte enfocada en la comunicación con el cliente final, y SpecBDD la parte enfocada en la comunicación entre desarrolladores, y noté el parecido entre SpecBDD y TDD tradicional. Y tambien noté la similitud entre pruebas de aceptación (de ATDD) y los escenarios de StoryBDD. Y entonces comprendí...

## Especificación mediante ejemplos##

Mezclando todos los conceptos obtenemos el término más genérico, impulsado por [Gojko Adzic](http://gojko.net/), [Especificación Mediante Ejemplos](http://www.specificationbyexample.com/). Los conceptos del libro me ayudaron a completar la visión acerca de las prácticas ágiles que involucran pruebas automatizadas. Un par de libros adicionales y mucha práctica me han permitido mejorar mis habilidades y comenzar a ver algunos frutos. Pienso que usar estas prácticas ayudaría enormemente a muchos equipos de desarrolladores en su trabajo diario. Incluso me atreví a hablar del tema durante el [Tour Agil Caracas 2012](http://comunidadagilven.wix.com/atccs12). Y asi pude llegar a mi propia conclusión:

## ¿Qué es BDD?##

BDD es un conjunto de prácticas que buscan mejorar la comunicación de los requerimientos y expresar mediante ejemplos el diseño de un software. Da soporte directo a los valores ágiles de *colaboración con el cliente* y *respuesta al cambio*, ya que ayuda a crear un lenguaje común entre el equipo que desarrolla y las personas que definen los requerimientos del negocio, permitiendo al equipo enfocarse en el desarrollo de software que verdaderamente cumpla las necesidades del cliente, y quedando las especificaciones en formato ejecutable, lo que resulta en una matriz de pruebas automatizadas que ayudan a detectar regresiones y fallas, permitiendo al equipo escribir código limpio y adaptable a cambios en el tiempo. 

## Finalmente##

Dominar BDD es un asunto de práctica constante, como todas las prácticas ágiles. Requiere de buenos conocimientos de las herramientas y de las prácticas en general, siempre enfocados en que estemos cumpliendo con los valores ágiles. Para equipos que quieran introducirse en este mundo, recomiendo que sea con algún proyecto corto que no tenga restricciones fuertes de tiempos de entrega, y preferiblemente tener un coach acompañándolos y entrenándolos durante las primeras fases del proyecto. Hasta el próximo post! 
