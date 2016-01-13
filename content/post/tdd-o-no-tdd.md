+++
categories = ["TDD"]
date = "2015-12-18T07:14:08-08:00"
description = ""
keywords = []
title = "TDD o no TDD"

+++
No cabe duda de que escribir pruebas unitarias para nuestro código en los proyectos es una práctica excelente que rinde grandes beneficios. Sin embargo, en este artículo quiero tratar el tema de si debo escribir las pruebas primero que el código de producción (técnica conocida como TDD), o si debo cubrir el código con pruebas (escribirlas después del código de producción). 

<!--more-->

El año pasado se genero [gran controversia alrededor del tema](http://joaquinoriente.com/2014/07/23/ha-muerto-tdd-de-la-controversia-al-pragmatismo/). El tema despierta pasiones y hay quienes sugieren que no escribir pruebas primero es inaceptable.

Cuando me hacen la pregunta de si utilizo TDD diariamente, mi respuesta es depende. Como todas las prácticas que se utilizan en agilidad, el contexto influye mucho y no podemos cerrarnos a pensar que TDD aplica en todos los casos. Generalmente no tengo mucho tiempo de extenderme en la respuesta, por eso he decido escribir este artículo. Los siguientes son algunos factores que considero para aplicar o no TDD:

## Proyecto nuevo vs. existente.

En un proyecto nuevo es más sencillo aplicar TDD, pues no existe una arquitectura definida o malas prácticas presentes en el código. Pero la realidad para mucho de nosotros es que los proyectos en los que trabajamos han sido construidos varios años atrás cuando las pruebas unitarias no se tomaban en cuenta, resultando en código con fuerte acoplamiento y herencia excesiva. Para este tipo de proyectos, generalmente no uso TDD sino que realizo el cambio en el código y trato de cubrirlo con una prueba. Si hay pruebas existentes, evalúo la calidad de las mismas, para decidir si es posible escribir una prueba primero, pero mi experiencia es que las pruebas en proyectos viejos no son muy expresivas o son muy complicadas (debido al fuerte acoplamiento).

Pero si necesito hacer un cambio relativamente complejo donde debo considerar muchas variables, prefiero aplicar TDD para diseñar un componente que maneje el caso específico de negocio, y luego refactorizar el código viejo para que use este componente. Esto me permite hacer mejores preguntas acerca de las condiciones (que son las entradas a mis pruebas) y estar seguro acerca de los resultados esperados. Incluso ayuda al cliente a entender todos los escenarios posibles. El resultado es un componente diseñado con TDD inyectado al código antiguo.


## Fase del proyecto

Incluso en nuevos proyectos, he encontrado que no es óptimo comenzar con TDD cuando apenas esta empezando, pues generalmente hay mucha incertidumbre acerca de los requerimientos. Prefiero enfocarme en construir un [esqueleto caminante](http://alistair.cockburn.us/Walking+skeleton) del proyecto para tomar decisiones de arquitectura tempranas y saber que tipo de objetos voy a diseñar a través de pruebas, que en esta fase temprana pueden no estar claros y pueden cambiar mucho. Esto ayuda a disminuir la incertidumbre y entender más el negocio, que nos permitirá más adelante hacer mejor uso de la técnica de TDD.

Una vez el proyecto comienza a tomar más forma, y la arquitectura base esta decidida, ya me siento libre de usar TDD para ir diseñando componentes que añadan nuevas características a la aplicación, y cubrir con pruebas el diseño inicial.

## Experticia en el lenguaje y herramientas de testing

Como apasionado del desarrollo, me gusta probar nuevos lenguajes, y estudiar sus herramientas de pruebas. Mi lenguaje del día a día es java, por eso tengo total dominio de las herramientas y me siento cómodo de aplicar TDD en este lenguaje. Pero cuando pruebo un lenguaje nuevo, debo darme tiempo de entender el lenguaje y sus formas. Si intento arrancar con TDD de seguro fracasaré en entender el lenguaje y sus herramientas, porque traeré mi conocimiento java e intentaré aplicarlo, lo que puede no tener sentido.

Por tanto cuando comienzo con un nuevo lenguaje, prefiero comenzar haciendo proyectos pequeños para entender el estilo del lenguaje, y luego tratar de cubrir el código con pruebas y aprender las herramientas de prueba. Una vez que me sienta cómodo escribiendo código y pruebas en el lenguaje, comienzo a pensar acerca de escribir pruebas primero. 

La experticia con un lenguaje no asegura la experticia escribiendo pruebas, hay que dominar ambas cosas antes de intentar aplicar TDD. Pienso que una gran cantidad de personas les cuesta aplicar TDD con sus lenguajes porque no emplean tiempo de calidad en aprender las librerías de prueba del lenguaje. 

## El conocimiento del dominio del negocio

Finalmente, hay negocios más sencillos de comprender, y negocios que son altamente complejos. A medida que la complejidad aumenta, tener la capacidad de aislar partes del sistema y entender bien su funcionamiento es algo en lo que TDD puede ayudarnos mucho, por su manera progresiva de ir añadiendo complejidad y tener cubierto los casos anteriores, que permite dar pasos seguros hacia la solución final. 

## Para terminar
Si llevas mucho tiempo escribiendo pruebas y código en un lenguaje, es posible que puedas saltarte los "pasitos de bebe" que TDD propone, y adelantarte un poco a escribir la implementación real de los componentes, pero ten cuidado! A veces para avanzar, hay que volver a lo básico! 

