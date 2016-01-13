---
title: "BDD de especificaciones: Un ejemplo concreto"
date: "2013-07-14T00:00:00-05:00"
comments: true
categories: 
- BDD
- Agilidad
type: post
---

En un artículo anterior, había compartido con ustedes un [ejemplo concreto de BDD de historias](/2013/04/bdd-de-historias-un-ejemplo-concreto/). Ahora toca el turno de un ejemplo de lo que es BDD de especificaciones. 

<!--more-->

Para el ejemplo, seguire la misma mecánica que para el de BDD de historias, explicando en este artículo de que se trata el ejemplo, para luego enlazar a futuros artículos con la implementación concreta.

## Diseñando un objeto Cuenta ##

La idea es aplicar BDD de especificaciones para diseñar un objeto que represente una cuenta bancaria. Para hacer el ejemplo sencillo, el balance de la cuenta se manejará como un entero. Se quiere entonces que este objeto cuenta:

* Reduzca el balance cuando se hace un débito.
* Incremente el balance cuando se hace un crédito.
* Envíe una alerta personalizada cuando el saldo es menor a 100.

Asi mismo nos vamos a plantear las responsabilidades para este objeto a nivel del código. En el caso del balance de la cuenta, que podemos representar como una propiedad, el mismo objeto podrá a través de su API realizar débitos y créditos.

Para el caso de la alerta sin embargo, vamos a requerir de un colaborador, es decir, otro objeto cuya responsabilidad sea el envío de alertas, y que yo pueda utilizar cuando se de el caso del saldo menor a 100. Para los efectos del ejercicio, este colaborador no existe, asi que mientras realizamos el diseño de la cuenta, aprovechamos de diseñar como se comunicará con este colaborador, al que llamaremos "alertas" por ahora, para cumplir con el último requisito.

Si bien el ejercicio es muy sencillo, muestra los pasos básicos que se utilizan para diseñar objetos en una aplicación de la vida real.

## Implementación en Java ##

* Repositorio de código: [https://github.com/adrianmoya/specbddsample-java](https://github.com/adrianmoya/specbddsample-java)
* Artículo explicativo: [/2013/07/bdd-de-especificaciones-un-ejemplo-concreto-en-java/](/2013/07/bdd-de-especificaciones-un-ejemplo-concreto-en-java/)

## Implementación en otros lenguajes ##

Próximamente estaré publicando implementaciones de este ejemplo sencillo en otros lenguajes, e iré actualizando este artículo.

## Notas finales ##

- Aplicando esta técnica, es muy sencillo cuando un nuevo desarrollador ingresa al proyecto, que entienda que hace cada clase, con solo leer el nombre de la especificación y ver el ejemplo del código. 

- Normalmente programo en inglés, por lo que a este nivel, las especificaciones y nombres de las clases las pondré en inglés. El nivel de inglés usado en las especificaciones es muy básico, asi que aún cuando no entiendas inglés, el ejemplo de código debe ser bastante claro.

- Para los ejemplos utilizaré algunas técnicas que explicaré en el artículo relativo a cada implementación.

Si hay preguntas, pueden usar los comentarios para contactarme. Saludos!
