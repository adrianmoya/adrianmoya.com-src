---
title: "Inyección de Características"
date: "2014-02-02"
comments: true
slug: inyeccion-de-caracteristicas
categories: 
- BDD
- Características
- Agilidad
type: post
---

Según la definición, BDD es una metodología que nos permite construir software que importa. La inyección de características es una técnica de análisis creada por Chris Matts que nos ayuda a encontrar características que nos permitan aportar el máximo de valor.

<!--more-->

## ¿Qué es software que importa?##

¿Acaso todo el software que escribimos no es importante? La verdad es que escribir software, como toda actividad creativa, nos genera un sentimiento de propiedad y de importancia personal, pero lejos de los sentimentalismos, no todo el software que escribimos es importante. Si alguna vez has estado en un proyecto que nunca se puso en producción, has escrito software sin importancia. No importa lo bien escrito, no importa la arquitectura perfecta, las horas dedicadas. El software, como inversión, importa solo si aporta VALOR a la empresa o persona que invierte en él.

Con la finalidad de construir software que importa, el primer paso de la inyección de características trata de cazar el valor. Pero ¿cómo se ve el valor? ¿dónde está el valor?.

## PASO 1: Cazando el valor##

Un software entrega valor si cumple una de estas 4 condiciones:

**1. Aumenta la ganancia:** Si desarrollar una funcionalidad permite que la compañía incremente sus ingresos, entonces agrega valor. Conseguir nuevos clientes o formas de ingreso entrega valor a sus inversionistas.

**2. Protege la ganancia:** Si el desarrollo permite que la compañía conserve sus actuales clientes, previniendo que se vayan con la competencia, el proyecto entrega valor. Conservar la base de clientes es tan o más importante que conseguir nuevos clientes.

**3. Reducir costos:** Si implementar una característica ayuda a la compañía a reducir costos operativos, esto también representa valor.

**4. Evitar costos:** Muy similar a la condición 3, si una característica evita totalmente incurrir en costos, entonces agrega valor.

Sabiendo como luce una característica que agrega valor, dónde debemos buscar dicho valor? ¿En las entradas o salidas del sistema? La respuesta es simple, el valor SIEMPRE se encuentra en la salida del sistema. No tiene valor introducir datos a un sistema si no existe un producto en la salida que agregue valor. Por tanto, en nuestra cacería del valor, debemos fijarnos en las salidas que se quieren obtener en el sistema.

Existen varias técnicas que podemos usar para llegar al valor, como por ejemplo recorrer la *lista de porques*. simplemente repitiendo ante una caracteristica propuesta para el sistema, la pregunta ¿por qué? ¿por qué queremos esta característica? Cuando repetimos la pregunta varias veces, vamos subiendo de nivel hasta encontrar la salida que queremos obtener de dicha propuesta.

Por ejemplo: 
- Quiero que el sistema solicite al usuario un login y un password a través de un formulario.
- ¿Por que quiere que el usuario introduzca usuario y password?
- Porque necesito saber quién es el usuario.
- ¿Por qué necesita saber quién es el usuario?
- Para ofrecer contenido personalizado que me permita ofrecerle productos o servicios de su interés.

Bingo! Lo que realmente quiere nuestro cliente u empresa es ofrecer productos o servicios de interés para un usuario particular, y por eso necesita identificarlo. Podemos replantear esto de la siguiente manera:

Para ofrecer productos y servicios de manera personalizada
Como agente de mercadeo
Yo necesito que el usuario se autentique con un formulario.

## PASO 2: Inyectar las características##

Este paso da el nombre a la técnica, y consiste en, una vez sabiendo las salidas que queremos, identificar los requerimientos para obtenerlas. Dichos requerimientos van a variar dependiendo de la naturaleza del proyecto y la característica que estemos implementando. Este es un buen momento para hacer una tormenta de ideas y buscar alternativas para alcanzar el mismo objetivo, e inyectar nuevas características. 

El proceso de inyectar no es más que conseguir nuevas características que satisfagan el requerimiento. Del proceso pueden salir nuevas ideas que podemos analizar para ver si nos conviene más, sea porque sean más sencillas de implementar o porque disponemos de la información ya en otro sistema, o simplemente conseguir formas adicionales de tener el mismo resultado, que podemos ir implementando en el orden de prioridades que decidamos. La inyección de características nos da OPCIONES.

Continuando con el ejemplo, podemos preguntárnos, ¿de qué otra forma podemos identificar al usuario? ¿Podemos identificarlo a través de su huella digital? ¿Podemos identificarlo a través de la voz? Las consolas de videojuegos modernas autentican al usuario a través de los dispositivos de seguimiento de movimiento. ¡Hay muchas maneras! Conociendo lo que realmente queremos alcanzar, podemos buscar alternativas menos costosas o más sencillas de implementar. Conociendo los requisitos para alcanzar dichas salidas, podemos preguntárnos cómo podemos obtener las entradas.

## PASO 3: Romper el modelo##

Finalmente, una vez decidida una característica que nos de el mayor valor, y habiendo identificado sus entradas, procedemos a buscar las distintas variaciones en las entradas que puedan comprometer nuestro "modelo", o lo que es lo mismo buscar distintos escenarios y validar como se va a comportar dicha características ante dichos escenarios.

Si queremos identificar a nuestro usuario con su huella digital, entonces debemos comenzar a romper el modelo:

- ¿Qué pása si el usuario no dispone de captahuellas o el captahuellas esta averiado?
- ¿Qué sucede si el usuario tiene un accidente y pierde su huella registrada?

Si quiero identificar con voz:

- ¿Qué pasa cuando una persona tenga gripe, y su tono de vez se vea afectado?
- ¿Cómo identificamos a las personas que no puedan hablar?

Y la típica, el usuario amnésico si nos vamos por el usuario y password:

- ¿Qué pasa si el usuario olvida su contraseña? 
- ¿Qué pasa si olvida su usuario? 

El proceso de romper el modelo puede llevarnos a rechazar la característica seleccionada, ya sea porque conseguimos un caso que no podemos superar o porque requiere de cambios que costarían más que seleccionar otra de las características ya discutidas durante la fase de inyección. En este caso procedemos a inyectar una alternativa y volvemos a intentar romper el modelo.

## Finalizando##

Bueno, una técnica más para tener en nuestra caja de herramientas ágiles, esta vez al momento del análisis. Durante su aplicación podemos combinar con otras técnicas como Mapeo de Impacto para identificar el valor, los participantes, las salidas y las características necesarias para obtenerlas. Algunos recursos para continuar:

[Artículo de Feature Injection en InfoQ](http://www.infoq.com/articles/feature-injection-success)

[Chris Matts en twitter](https://twitter.com/PapaChrisMatts)

[Scan Agile 2012 - Feature Injection (Video)](http://vimeo.com/40028722)
