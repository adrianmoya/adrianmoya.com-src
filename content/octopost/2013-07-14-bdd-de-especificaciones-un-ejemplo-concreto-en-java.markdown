---
title: "BDD de especificaciones: un ejemplo concreto en Java"
date: "2013-07-14T00:00:01-05:00"
comments: true
categories: 
- BDD
- Java
- JUnit
- Mockito
type: post
---

Esta es la implementación en Java de [un ejemplo concreto de BDD de Especificaciones](/2013/07/bdd-de-especificaciones-un-ejemplo-concreto/). Es importante que leas primero de que se trata el ejemplo en el artículo anterior, antes de proceder a ver la implementación.

<!--more-->

## Herramientas ##

Para el lenguaje Java, las herramientas que utilizaré son las siguientes:

[**JUnit**](http://junit.org/): La herramienta de pruebas unitarias más utilizada del mundo Java, sirve perfectamente para escribir nuestras especificaciones.

[**Mockito**](https://code.google.com/p/mockito/): Es una librería para crear [dobles de pruebas](http://adrianmoya.com/2013/05/usando-dobles-para-especificar-la-comunicacion-entre-objetos/). En este ejercicio lo usamos para describir como nuestro objeto cuenta se comunica con el colaborador que envía las alertas (que no existe).

[**Maven**](http://maven.apache.org/): Es la herramienta de manejo de dependencias y construcción del proyecto. 

## Implementando el ejemplo ##

Como he comentado en artículos anteriores, la idea del artículo no es explicar el funcionamiento de las herramientas, sino de la técnica. Existen muchas otras herramientas que podrías usar para implementar el mismo ejemplo, y cada una esta debidamente documentada en sus sitios web respectivos.

## Configuración del ambiente ##

Estos son los pasos que sigo para comenzar a escribir especificaciones usando BDD:

**pom.xml**: En el archivo de proyecto de maven, procedo a especificar las dependencias para las herramientas que uso, en este caso junit y mockito. Además de esto, configuro el plugin de pruebas de maven (surfire), que por defecto ejecuta con junit aquellas clases que tienen "Test" en su nombre, para que detecte clases con la palabra "Spec" en el nombre, ya que me gusta nombrar mis clases de especificaciones con el sufijo Spec.

## El archivo de especificaciones ##

**AccountSpec.java**: En este archivo es donde voy especificando que debe hacer el objeto Account. Aqui se encuentra un método por cada especificación, con un ejemplo de código de como debe funcionar. Esta clase es la que sirve como documentación para otros miembros del equipo, además de asegurarse de que el comportamiento del objeto se mantiene cada que la ejecutamos con junit.

## Archivos de soporte para las pruebas ##

**AccountBuilder.java**: Este archivo es una implementación del [patrón builder](http://es.wikipedia.org/wiki/Builder_(patr%C3%B3n_de_dise%C3%B1o\)) del cual estaré hablando más en detalle en un próximo artículo, pero que sirve en este caso para construir objetos para la prueba que cumplan unas ciertas características necesarias para darle contexto a la prueba.

## El código del objeto ##

**Account.java**: Es el objeto que estamos diseñando en el ejercicio. El objeto debe comportarse tal como es descrito en el archivo de especificaciones.

**AlertListener.java**: Esta es una interfaz que usaremos para describir la comunicación con el colaborador que envía las alertas. Cuando llegue el momento de implementar este colaborador, el mismo implementará esta interfaz, de manera que provea los métodos que nuestra clase Account espera. Por tanto en la prueba del envío de la alerta, hacemos un mock de esta clase para utilizarla en la prueba y validar que el resultado es el esperado.

## Obteniendo el código del ejemplo ##

Puedes clonar el ejemplo usando git o simplemente descargarlo desde esta dirección:

[https://github.com/adrianmoya/specbddsample-java](https://github.com/adrianmoya/specbddsample-java)

## Ejecutando el ejemplo ##

Para ejecutarlo, puedes utilizar el IDE de tu preferencia y ejecutar la clase AccountSpec como si fuera una prueba de Junit. En Netbeans, el resultado se ve asi:

![](/images/2013/07/specbddsample-netbeans.png)

El ejemplo también puedes ejecutarlo desde la consola con la instrucción `mvn test`. (Requiere tener configurado maven en la consola), pero en este caso maven solo nos da un resumen de las pruebas que ejecutó, por tanto es ideal para un servidor de integración continua, pero no es muy expresivo para ver como usando un IDE.

Hasta la próxima!

