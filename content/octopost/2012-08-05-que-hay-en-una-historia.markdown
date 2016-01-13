---
title: "¿Qué hay en una historia?"
date: "2012-08-08"
comments: true
slug: "que-hay-en-una-historia"
categories: 
- Agilidad
- BDD
type: post
---

En estos dias he estado trabajando en un proyecto probando la práctica de especificación mediante ejemplos, o como es más comunmente conocida, desarrollo dirigido por comportamiento. Entre los principales promotores de esta práctica esta [Dan North](http://dannorth.net/), quien ha escrito varios artículos del tema. Como no se consigue mucha documentación (a la fecha solo aparenta haber un libro dedicado, el de [Especificación Mediante Ejemplos](http://www.amazon.com/Specification-Example-Successful-Deliver-Software/dp/1617290084/ref=sr_1_1?ie=UTF8&qid=1343940845&sr=8-1&keywords=specifications+by+example) de [Gojko Adzic](http://gojko.net/about/)), he decidido traducir un artículo titulado [¿Qué hay en una historia?](http://dannorth.net/whats-in-a-story/) para ponerlo a disposición del público latinoamericano, ya que lo considero excelente para orientarnos en cómo escribir historias de usuario con pruebas de aceptación. Demás esta decir que las opiniones expresadas son las del autor original y no las mias propias. ¡Que lo disfruten!

<!--more-->

## ¿Qué hay en una historia?##

El desarrollo dirigido por comportamiento (BDD por sus siglas en inglés, Behaviour Driven Development) es una metodología de "afuera hacia adentro". Comienza desde afuera identificando resultados de negocio, y de ahí profundiza hasta el conjunto de características que alcanzará dichos resultados. Cada característica es capturada como una "historia", que definirá el alcance de la característica junto con su criterio de aceptación. Este artículo introduce la manera en que BDD define e identifica historias y sus criterios de aceptación. 

## Introducción##

El desarrollo de software es acerca de escribir programas para alcanzar resultados de negocio. Suena obvio, pero comunmente factores políticos o ambientales nos distraen de recordar esto. A veces el desarrollo de software puede aparentar ser acerca de producir reportes optimistas para mantener a la gerencia contenta, o solo crear "ocupación" para mantener a la gente en empleos pagados, pero eso es tema para otro dia.

Usualmente, el resultado de negocio está demasiado denso como para ser usado directamente para escribir software (donde comienzas a codificar cuando el resultado es "ahorrar 5% de mis costos operativos"?) así que necesitamos definir requerimientos en un nivel intermedio de manera de poder hacer el trabajo.

El desarrollo dirigido por comportamiento (BDD) parte de que puedes convertir una idea de un requerimiento en código implementado, probado y listo para producción de manera simple y efectiva, siempre y cuando el requerimiento sea suficientemente específico de manera que todos sepan qué está pasando. Para lograr esto, necesitamos una manera de describir el requerimiento en que todo el mundo -la gente de negocio, los analistas, los desarrolladores y los encargados de las pruebas- tenga un entendimiento común del alcance del trabajo. Siendo así, todos pueden acordar una definición común de "listo", y se puede escapar de la [trampa de gumption](http://brigantinus.blogspot.com/2009/05/gumption-algo-para-tener-en-cuenta.html) dual de "eso no es lo que yo pedi" o "se me olvido decirte esta otra cosa".

Este, entonces, es el papel de una Historia. Debe ser una descripción de un requerimiento y sus beneficios de negocio, y un grupo de criterios por los cuales todos acordamos que está "lista". Esto es una definición más rigurosa que en otras metodologías ágiles, donde es descrita como una "promesa de conversación" o una "descripción de una característica". (Una historia BDD puede fácilmente describir un requerimiento no funcional, siempre y cuando el trabajo tenga un alcance, estimación y acuerdo entre las partes.)

## La estructura de una historia##

BDD provee la estructura para una historia. Esto no es obligatorio -puedes usar un formato de historia diferente y seguir haciendo BDD- pero lo presento aquí porque ha demostrado que funciona en muchos proyectos de todos los tipos y tamaños. Como mínimo, tu historia debería contener todos los elementos descritos en la plantilla. La plantilla de historia se ve asi:

```gherkin_es
Título (Una línea describiendo la historia)
    
Narrativa:
Como [un rol]
Yo quiero [característica]
De manera que [beneficio]
    
Criterio de Aceptación: (presentados como Escenarios)
    
Escenario 1: Título
Dado [contexto]
Y [algo más de contexto]...
Cuando [evento]
Entonces [resultado]
Y [otro resultado]...
    
Escenario 2: ...
```
## Contando la historia##

Una historia debe ser el producto de una conversación involucrando a varias personas. Un analista de negocio habla con un interesado del negocio<sup><small><a name="1" href="#fn1">1</a></small></sup> acerca de una característica o requerimiento, y los ayuda a enmarcarla en narrativa de historia. Luego un encargado de pruebas ayuda a definir el alcance de la historia -en la forma de criterios de aceptación- determinando cuáles escenarios importan y cuáles son menos útiles. Un representante técnico proveerá una estimación aproximada de la cantidad de trabajo involucrado en la historia, y propondrá alternativas. Muchas grandes ideas para sistemas vienen de las personas que están desarrollándolos, además de las personas que lo solicitaron en primer lugar.

Esto posiblemente sea un proceso iterativo. El interesado va a tener una idea de lo que quiere pero generalmente no sabrá cuánto trabajo está involucrado, o cómo ese trabajo será distribuido. Con la ayuda de los expertos técnicos y de pruebas, ellos entenderán el costo/beneficio de cada escenario y pueden juzgar acerca de si realmente quieren el requerimiento. Por supuesto, esto tambien está medido en relación a los otros requerimientos: es mejor cubrir más casos de borde en esta historia, o moverse hacia otra historia?

Algunas veces el equipo de desarrollo simplemente no va a saber suficiente para ser capaz de realizar una estimación aproximada. En este caso pueden elegir llevar a cabo algo de trabajo investigativo, conocido como "pico", de manera de entender más acerca del requerimiento.

## Las características de una buena historia##

Usando el ejemplo del artículo [Introducción a BDD](http://dannorth.net/introducing-bdd), veamos los requerimientos para sacar efectivo de un cajero automático:

```gherkin_es
    Como dueño de una cuenta
    Yo quiero retirar efectivo de un cajero automático
    De manera que pueda tener dinero cuando el banco esté cerrado.
    
    Escenario 1: La cuenta tiene suficientes fondos
    Dado que el balance de la cuenta es $100
    Y la tarjeta es válida
    Y el cajero tiene suficiente dinero
    Cuando el dueño de la cuenta solicita $20
    Entonces el cajero debe dispensar $20
    Y el balance de la cuenta debe ser $80
    Y la tarjeta debe ser retornada
    
    Escenario 2: La cuenta no tiene suficientes fondos
    Dado que el balance de la cuenta es $10
    Y la tarjeta es válida
    Y el cajero tiene suficiente dinero
    Cuando el dueño de la cuenta solicita $20
    Entonces el cajero no debe dispensar dinero
    Y el cajero debe decir que no hay suficientes fondos
    Y el balance de la cuenta debe ser $10
    Y la tarjeta debe ser retornada
    
    Escenario 3: La tarjeta ha sido bloqueada
    Dado que la tarjeta esta bloqueada
    Cuando el dueño de la cuenta solicita $20
    Entonces el cajero debe retener la tarjeta
    Y el cajero debe decir que la tarjeta ha sido retenida
    
    Escenario 4: El cajero tiene fondos insuficientes
    ...
```

Como puedes ver, hay un número de escenarios a considerar, algunos relacionados al balance de la cuenta, otros acerca de la tarjeta y otros acerca del cajero como tal. Vamos a dividir la historia para determinar si está correcta.

## El título debe describir una actividad##

El título de la historia, "Dueño de la cuenta retira efectivo", describe una actividad que el Dueño de la cuenta quiere llevar a cabo. Hasta que implementemos esta carcaterística, el dueño de la cuenta no será capaz de retirar dinero del cajero automático. Una vez que la entreguemos, sí será capaz de hacerlo. Esto nos da un punto de partida obvio para determinar cuándo se encuentra "lista".

Si tuviésemos un título como "Manejo de cuenta" o "Comportamiento del cajero", tendríamos que hacer mayor esfuerzo para entender cuándo hemos terminado, y los bordes estarían mas difusos. Por ejemplo, "Manejo de cuenta" podría incorporar aplicar por un préstamo, y "Comportamiento del cajero" podria incluir cambiar la clave de mi tarjeta de débito. El título de la historia debe siempre describir el comportamiento actual por un usuario del sistema. La narrativa debería incluir el rol, una característica y un beneficio. 

La plantilla "*Como [rol] Yo quiero [característica] de manera que [beneficio]*" tiene un número de ventajas. Al especificar el rol en la narrativa, ya sabes con quien hablar acerca de la característica. Al especificar el beneficio, causas que el escritor de la historia considere por qué quiere esa característica.

Se pone interesante si te das cuenta que la característica no va a entregar el beneficio que se le está atribuyendo. Esto generalmente significa que falta una historia. Hay una historia con la característica actual, que resulta en un beneficio distinto (Y por tanto sigue siendo útil), y una historia oculta donde necesitas una característica diferente para poder dar el beneficio descrito. 

La historia del ejemplo nos dice que hay un Dueño de la cuenta a quien le importa la característica que se está entregando, así que sabemos a quien preguntar lo que debería hacer. 

## El titulo del escenario debería decir qué es diferente##

Deberías ser capaz de alinear los escenarios lado a lado, y describir cómo difieren usando solamente el título. En nuestro ejemplo, podemos ver que las descripciones de los escenarios dicen solamente qué es diferente entre cada escenario. No necesitas decir "Un dueño de la cuenta retira dinero de una cuenta con fondos insuficientes y se le dice que es imposible realizar su transacción". Es obvio partiendo del título si este es el escenario que te interesa, comparado con los otros. 

## El escenario debe ser descrito en términos de Supuestos, Eventos y Resultados##

Esto es el cambio comportamental más poderoso que he visto en equipos adoptando BDD. Simplemente por lograr que usuarios de negocio, analistas, encargados de pruebas y desarrolladores adopten este vocabulario de "Dado/Cuando/Entonces", todos descubren que se elimina un mundo de ambiguedades. 

No todos los escenarios son así de simples. Algunos son mejor representados como secuencias de eventos, descritos como: *dado [algo de contexto] cuando [hago algo] entonces [esto sucede] cuando [hago otra cosa] entonces [esta nueva cosa pasa]* y asi sucesivamente. Un ejemplo es un sitio web tipo asistente, donde uno va por pasos a través de una secuencia de pantallas para construir un modelo de datos complejo. Es perfectamente apropiado intercalar secuencias de eventos y resultados, siempre y cuando puedas crear el hábito de pensar en estos términos.

Un comportamiento emergente interesante es que la calidad de la conversación cambia. Rápidamente vas a descubrir que has olvidado un supuesto asumido ("bueno claro la cuenta esta sobregirada"), u olvidado verificar una salida ("bueno naturalmente la tarjeta es devuelta al dueño de la cuenta"). Observé esto en un proyecto particular donde el desarrollador líder me dijo que podia sentir que los analistas y los desarrolladores estaban hablando de propósitos cruzados, pero no podía encontrar la forma de demostrárselos. Luego de unos dias de introducir el vocabulario dado/cuando/entonces, pudo notar una mejoría dramática en la calidad de sus interacciones. 

## Los supuestos deben definir todo, y no mas, que el contexto requerido##

Cualquier supuesto adicional distrae, lo que hace dificil para alguien mirando la historia por primera vez - sea del lado técnico o del lado de negocio - entender lo que necesitan saber. Similarmente cualquier supuesto faltante son realmente suposiciones. Si puedes obtener un resultado diferente de los supuestos provistos, entonces debe estar faltando algo. 

En el ejemplo, el primer escenario dice algo acerca del balance de la cuenta, la tarjeta y el cajero automático. Todos estos son requeridos para definir completamente el escenario. En el tercer escenario, no decimos nada acerca del balance de la cuenta o si el cajero tiene dinero. Esto implica que la máquina va a retener la tarjeta cualquiera sea el balance de la cuenta, y cualquiera sea el estado del cajero. 

## El evento debe describir la característica##

El evento por si solo debe ser muy simple, tipicamente solo una llamada individual al codigo de producción. Como se discutió arriba, algunos escenarios son mas complicados que esto, pero en su mayoría los escenarios para una historia se resolveran alrededor de un evento individual. Van a diferir unicamente en el contexto (los supuestos) y sus correspondientes salidas esperadas.

## La historia debe ser lo suficientemente pequeña para caber en una iteración##

No hay reglas rígidas o rápidas acerca de como hacer esto, hasta que lo divides en pedazos demostrables. En general si hay más de cinco o seis escenarios, posiblemente una historia pueda ser dividida agrupando escenarios similares. 

No podemos decir del ejemplo del cajero automático cuántos escenarios adicionales hay para esta historia, pero sospecho que deben haber muchos mas. Escencialmente tenemos tres "piezas móviles" en esta historia,  el balance de la cuenta, el estado de la tarjeta de débito y el estado del cajero automático. Podriamos entrar en más detalles con la tarjeta de débito: qué pasa si esta vencida, osea que no puedo usarla para retirar efectivo pero el cajero me la devuelve? qué pasa si el cajero falla a mitad de una transacción? qué pasa si mi cuenta tiene una capacidad de sobregiro?

Pudiera ser mejor dividir la historia en varias historias más pequeñas:

Dueño de la cuenta retira efectivo (supuestos: cajero funcionando y tarjeta válida)
Dueño de la cuenta retira efectivo con tarjeta inválida (supuesto: cajero funcionando)
Dueño de la cuenta retira efectivo de cajero defectuoso (supuesto: tarjeta válida)

Aunque esto pueda parecer artificial, te permite demostrar progreso en términos de negocio y te da más puntos de datos para hacer seguimiento. Lo importante es siempre dividir la historia por términos de negocio en escenarios (y haciendo explícitos los supuestos) en lugar de dividirla por términos técnicos (ejemplo haciendo las cosas de la base de datos en esta iteración y la interfaz de usuario en la próxima). Esto es para que el negocio pueda ver progreso demostrable en sus propios términos en vez de simplemente confiar en tu palabra.

## Entonces, ¿cómo es esto distinto de los Casos de Uso?##

Hay todo tipo de casos de uso. Soy un gran fan de la forma en que Alistair Cockburn describe los casos de uso (opuesto a las versiones con sobre-ingeniería que he encontrado en proyectos usando RUP-como-cascada). Dado que no tengo mucha experiencia en proyectos dirigidos por Casos de uso, dejare que otros que dibujen las diferencias. 

Ciertamente estoy de acuerdo con su proceso de comenzar en la precisión mas baja (de un resultado, o meta) y trabajar hacia la precisión más alta, levantando más escenarios de excepción a medida que avanzas. En BDD, esto significa comenzar con las salidas del negocio, y trabajar a través de areas funcionales de alto nivel para profundizar en historias específicas con criterios de aceptación.

En la realidad, no importa cual es tu proceso para identificar y elaborar requerimientos. Esta bien para ti escribir documentos de requerimientos si eso ayuda a organizar tus ideas. No esta bien, sin embargo, pasar esos documentos como si ellos encapsularan todos tus pensamientos, porque no lo hacen. En su lugar, deberías poner el documento de requerimiento, o pila de casos de uso, a un lado y comenzar nuevamente definiendo historias partiendo de resultados de negocio, sabiendo con seguridad que tu trabajo arduo ha significado que tienes todas las respuestas en tu cabeza - o por lo menos un entendimiento suficientemente bueno para delinear el trabajo como lo ves actualmente. 

## Resumen##

El desarrollo orientado a comportamiento usa una historia como la unidad de funcionalidad básica, y por tanto de entrega. Los criterios de aceptación son una parte intrínseca de la historia - en efecto ellas definen el alcance de su comportamiento, y nos dan una definición compartida de "terminado". Son tambien usadas como base para la estimación cuando vamos a planificar. 

Mas importante, las historias son el resultado de conversaciones entre los interesados del proyecto, los analistas de negocios, los encargados de pruebas y los desarrolladores. BDD es tanto acerca de las interacciones entre las distintas personas en el proyecto como tambien acerca de las salidas del proceso de desarrollo. 

---
<a name="fn1" href="#1">1.</a> De hecho debería ser la persona que en realidad le importa la característica, asi que podria ser igualmente una persona de operaciones, de legal o de seguridad dependiendo de la historia. 
