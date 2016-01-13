---
title: "BDD de historias: un ejemplo concreto"
date: "2013-04-22T00:00:00-05:00"
comments: true
categories: 
- BDD
- Agilidad
type: post
---

Para continuar con la serie de artículos acerca del Desarrollo Guiado por Comportamiento, hoy les traigo un ejemplo de BDD de historias, junto con sus implementaciones en Java y PHP.

<!-- more -->
## La historia y sus escenarios ##

Como he comentado en la serie de artículos de BDD, nuestra intención es partir desde los requerimientos del cliente. Así, para este ejemplo, vamos a partir con la siguiente historia de usuario (característica del sistema):

    Característica: Suma de dos números
    
    Como matemático novato
    Yo quiero obtener la suma de dos cifras
    Para aprender a sumar

Para poder implementar esta sencilla característica de suma de dos cifras, nos reunimos el equipo y determinamos algunos escenarios con ejemplos concretos que podamos validar. A continuación los escenarios identificados:

    Escenario: Sumar dos numeros positivos
      Dado que estoy en la aplicación
      Cuando ingreso los números 1 y 3
      Y solicito el resultado del cálculo
      Entonces el resultado debe ser 4

    Escenario: Sumar dos numeros negativos
      Dado que estoy en la aplicación
      Cuando ingreso los números -1 y -3
      Y solicito el resultado del cálculo
      Entonces el resultado debe ser -4

    Escenario: Sumar un numero positivo y uno negativo
      Dado que estoy en la aplicación
      Cuando ingreso los números -2 y 3
      Y solicito el resultado del cálculo
      Entonces el resultado debe ser 1

Como pueden ver, escribimos 3 simples escenarios con valores concretos que muestran como la funcionalidad de suma debe funcionar. Pudieramos escribir muchas combinaciones de valores, pero nuestra idea aqui es dar un ejemplo concreto, no todas las combinaciones posibles. Los escenarios son fácilmente legibles tanto por el gerente, el dueño del negocio, los desarrolladores, el equipo de pruebas, en fin, todos los interesados.

Partiendo de esta información, creamos un archivo de texto con el nombre de la característica y la extensión feature (Suma.feature) y pasamos la información a ese archivo. Luego, usando las herramientas para BDD, generamos los pasos automáticos que verifican que la aplicación cumple lo que se está solicitando. Finalmente desarrollamos la aplicación que hace pasar los pasos de verificación. 

## Implementación en Java ##

* Repositorio de código: [https://github.com/adrianmoya/bddsample-java](https://github.com/adrianmoya/bddsample-java)
* Artículo explicativo: [http://adrianmoya.com/2013/04/bdd-de-historias-un-ejemplo-concreto-en-java/](http://adrianmoya.com/2013/04/bdd-de-historias-un-ejemplo-concreto-en-java/)

## Implementación en PHP ##

* Repositorio de código: [https://github.com/adrianmoya/bddsample-php](https://github.com/adrianmoya/bddsample-php)
* Artículo explicativo: [http://adrianmoya.com/2013/04/bdd-de-historias-un-ejemplo-concreto-en-php/](http://adrianmoya.com/2013/04/bdd-de-historias-un-ejemplo-concreto-en-php/)

## Implementación en otros lenguajes ##

Si alguien se anima a realizar la implementación en otros lenguajes, con mucho gusto la publicaré junto con este artículo. Los principales lenguajes que yo manejo a nivel de trabajo son Java y PHP, y por eso sólo hice las implementaciones para estos dos lenguajes.

## Tips y notas finales ##

- Aunque solo te llame la atención una de las dos implementaciones, no dejes de leer la otra. Busqué hacerlas lo bastante similares para que existieran puntos de comparación. Si conoces ambos lenguajes, revisar ambas implementaciones ayudará a entender mejor como se hizo.

- Es importante notar que ambas implementaciones parten del mismo archivo de entrada, Suma.feature. Este archivo tiene una estructura común para las herramientas BDD de la familia Cucumber y Behat. Su sintaxis se conoce como Gherkins. Para una buena documentación sobre que otras cosas podemos añadir a un archivo Gherkins, Behat ofrece una buena referencia en [Writing Features - Gherkin Language](http://docs.behat.org/guides/1.gherkin.html).

- Los tres escenarios realizan los mismos pasos con diferentes valores. Esto podría escribirse como una plantilla, y proporcionar una tabla de valores, lo que se conoce como Esquema del escenario. Pueden ver la sintaxis en [Scenario Outlines](http://docs.behat.org/guides/1.gherkin.html#scenario-outlines) de la documentación de Behat. Queda como ejercicio para los lectores.

- A pesar de haber realizado la implementación en ambos lenguajes, podrán notar que en ninguno hay pruebas unitarias. Esto es porque el tema de las pruebas a nivel de clases, que en BDD se conoce como SpecBDD, comenzaré a tratarlo en los próximos artículos. Cuando llegue el momento de un ejemplo concreto, podremos ver el cuadro completo de BDD en acción (Historias + Especificaciones). Los ejemplos actuales solo cubren [BDD de Historias](/2013/02/describiendo-sistemas-con-bdd/).

Hasta el próximo artículo!
