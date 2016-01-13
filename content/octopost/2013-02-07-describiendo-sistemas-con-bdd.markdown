---
title: "Describiendo sistemas con BDD"
date: "2013-02-07"
comments: true
categories: 
- Agilidad
- BDD
type: post
---

Luego de mi [Introducción a BDD](/2013/01/introduccion-a-desarrollo-guiado-por-comportamiento-bdd/), quisiera comenzar a escribir acerca de BDD de historias, o Story BDD. Se trata de la parte de BDD que cubre las especificaciones de un sistema, expresadas en el lenguaje natural de nuestro cliente mediante características y escenarios.

<!--more-->

## ¿Historias o características? ##

Cuando usamos marcos de trabajos ágiles como Scrum, generalmente hablamos de historias de usuario. Pero ¿qué es la historia de usuario? básicamente es un requisito del sistema que estamos desarrollando, que puede ser muy general (épico en lenguaje ágil), o puede estar suficientemente granulado para representar una característica única del sistema. Cuando estamos planificando una iteración de desarrollo ágil, es de la segunda forma que queremos tener nuestras historias. Así, estamos asegurando que la iteración tendrá como resultado una característica completa del sistema y no un desarrollo a medias sin funcionalidad visible al cliente.

Cuando trabajamos en BDD de historias, el término comúnmente usado es característica, pero esta bien que pensemos en la misma como el equivalente de nuestra historia de Scrum típica que está lista para ser planificada, y hasta puede estar expresada en la forma convencional Como [rol]/Yo Quiero [funcionalidad]/Para que [valor de negocio].

## El lenguaje natural del cliente ##

Esta es una de esas dudas comunes que surgen cuando comienzas a trabajar describiendo historias en BDD. ¿Qué lenguaje debo usar para describir la característica? La respuesta es el lenguaje natural del cliente, por tanto debemos ponernos en sus zapatos y pensar si ellos pueden entender lo que escribimos. Por ejemplo, si es una persona del mundo de las inversiones, su lenguaje natural estará casado con su negocio, es decir, hablará de acciones, de inversión, de compra y venta, de valor de la acción, etc. Posiblemente el lenguaje no sea natural para nosotros y es nuestra tarea y la del equipo empaparse del lenguaje para poder comunicarse claramente con el cliente, y que él nos pueda expresar sus requisitos claramente. 

Afortunadamente BDD nos ayudará a construir este lenguaje claro de comunicación utilizando unas simples técnicas que describiré a continuación. Pero qué pasa si desarrollamos servicios web para un banco? En este caso el lenguaje natural de nuestro cliente no son temas bancarios, pues los servicios están hechos para ser consumidos por desarrolladores en sus aplicaciones. En este caso el lenguaje gira en torno al endpoint, el payload (o cuerpo) de la petición, el xml o json de entrada y respuesta, las cabeceras de seguridad, etc. Es un lenguaje completamente distinto, pues dificilmente un gerente entenderá de servicios web. En este caso, quienes desarrollan la aplicación que consume los servicios pueden manejar el lenguaje del cliente final en su descripción de características. 

## Describiendo la característica con texto informativo ##

La primera recomendación al momento de describir una característica es que incluyamos texto informativo que pueda ayudar a entender los escenarios y el objetivo de la característica. BDD nos permite incluir esta descripción y no nos limita con el formato. Utilizaré un ejemplo que vi hace poco en un [video](http://vimeo.com/39660655) de [Matt Wynne](http://blog.mattwynne.net/) que describe una característica muy común en los sistemas: el registro de usuario.

    Característica: Registro de usuario.

    Como visitante
    Yo quiero registrarme en el sistema
    Para acceder a sus funciones

    El registro funciona en tres etapas:
    1. Solicitar el registro con un formulario en la página web. El solicitante recibe un correo.
    2. Seguir un enlace de confirmación en el correo para activar la cuenta.
    3. Llenar la información del perfil. En esta etapa el usuario ya tiene una cuenta pero tratamos de recolectar más información acerca de él.

Como podemos ver, con solo leer el texto queda bastante claro en que consiste el procedimiento en general, y no se ahonda en mucho detalle.
    
## Agregando los escenarios y pasos ##

Luego de la descripción, procedemos a expresar los distintos escenarios que pueden presentarse para el uso de esa característica. Aqui es importante que pensemos en los escenarios más comunes, la idea no es describir cada posible variación que pueda tener la característica si esto no agrega valor para describir el sistema. Cuando tengamos procedimientos que tienen múltiples etapas como el caso del ejemplo anterior, está bien poner cada etapa como un escenario separado. En general, queremos que cada escenario describa un comportamiento de la aplicación bajo unas condiciones dadas. El título del escenario es importante también y debe ser sencillo de distinguir de los otros escenarios.

Cada escenario lo describiremos en pasos, y lo ideal es que sean pocos pasos por escenario (3 idealmente, pero hasta 6 estará bien). Cualquier cosa más alla de 6 pasos pudiera sugerirnos que quizá podemos dividir el escenario en dos (O generalizar más el lenguaje). Lo ideal es que el documento que estamos escribiendo funcione como documentación del sistema, por tanto ser breves es importante, despues de todo ¡A nadie le gusta leer documentación muy larga!. Utilizamos la plantilla Dado/Cuando/Entonces para ir listando nuestros pasos en cada escenario.

    Característica: Registro de usuario.

    Como visitante
    Yo quiero registrarme en el sistema
    Para acceder a sus funciones

    El registro funciona en tres etapas:
    1. Solicitar el registro con un formulario en la página web. El solicitante recibe un correo.
    2. Seguir un enlace de confirmación en el correo para activar la cuenta.
    3. Llenar la información del perfil. En esta etapa el usuario ya tiene una cuenta pero tratamos de recolectar más información acerca de él.

    Escenario 1: Solicitar una cuenta
      Dado que no tengo una cuenta
      Cuando sigo el enlace de registro de la página de inicio
      Y lleno la forma con detalles válidos y la envío
      Entonces debo ver un mensaje de confirmación diciéndome que revise mi correo.

    Escenario 2: Confirmar cuenta
      Dado que he solicitado una cuenta
      Y que he confirmado mi solicitud
      Cuando ingreso al sistema
      Entonces no debo ver un mensaje de que confirme mi cuenta
      Pero debo ver un mensaje de bienvenida
      Y debo ver un formulario pidiéndome que llene el perfil de mi cuenta

    Escenario 3: Llenar el perfil de la cuenta
      Dado que he ingresado con una cuenta recién creada
      Cuando lleno los detalles de mi perfil
      Y salgo e ingreso al sistema nuevamente
      Entonces no debo ver el formulario pidiéndome llenar el perfil de mi cuenta

Es importante tomar en consideración lo siguiente: el nivel de granularidad con que describiremos nuestros escenarios debe ser entre alto y medio. Debemos generalizar algunos pasos para evitar que cambios futuros hagan que nuestros escenarios y pasos fallen, y que nuestras pruebas automatizadas se vuelvan difíciles de mantener. Este es quizá el aspecto que requiere mayor práctica en BDD de historias: conseguir la combinación de escenarios y el nivel de detalle ideal para describir el sistema sin que ahondemos en cosas superficiales o innecesarias. Del ejemplo podemos aprender algunas cosas: 

*    Del escenario 1 y 3, podemos notar que cuando se trata de llenar formularios, no estan especificando campos, y mucho menos valores o id's de elementos HTML. Esto es una buena práctica porque en caso de que se quiera agregar o eliminar algun campo de los datos que se deben introducir, los escenarios siguen siendo perfectamente válidos, haciendo que la mantenibilidad sea mínima. Esta técnica es útil con todo tipo de ingreso de información, asi que podemos tenerla en cuenta cuando vayamos a escribir un paso que requiere información del usuario. Noten además que habla de detalles válidos, y detalles de perfil. A medida que exploramos el dominio del cliente, podemos darle a esa información conjunta un nombre que nos ayude a ir construyendo este lenguaje común que nos permita evitar ambiguedades. Por ejemplo, podriamos llamarle datos de registro y datos del perfil. 

*    Nótese tambien que en general los escenarios estan describiendo el camino "feliz" de la característica. Se pueden describir algunos caminos alternos que sean importantes, pero tambien usar la técnica usada en el escenario 2, donde yo afirmo haber confirmado la solicitud y describo que el comportamiento del sistema es que no me muestra el mensaje de confirmar la cuenta sino el de bienvenida. Puedieramos haber estado tentados de escribir un escenario diciendo que cuando entro al sistema sin confirmar mi solicitud, debo ver un mensaje de que confirme mi cuenta, pero habría esto agregado valor realmente? Esto es un caso alterno poco probable de que suceda, pues informamos al usuario que revisara su correo en el escenario 1. Introduciendo un paso "negativo" en el escenario del camino feliz (no debo ver), se puede inferir que el mensaje aparece si no he confirmado mi solicitud. Asi que enfoquemos nuestros escenarios a actividades que generan valor al cliente, y dejemos las excepciones que no sean importantes para validar que no sucedan en pasos del camino feliz.

*    Noten tambien que el texto exacto de los mensajes no esta en el escenario. Nuevamente es una técnica que ayuda a que la mantenibilidad de los escenarios sea mínima en el tiempo. Si desean cambiar el mensaje de confirmación de la cuenta a otra frase, o a una imagen, el escenario sigue siendo válido.

*    Finalmente noten que no hay detalles de interfaz de usuario, como colores, estilos, logos, etc. Estos detalles son irrelevantes en cuanto al comportamiento del sistema se refiere. Si el logo es el viejo o el nuevo, o la pagina tiene fondo azul, el sistema debería comportarse igual. 

Para el caso del ejemplo, el autor puso expresiones como "seguir el enlace de registro" y "página de inicio", que nos indican que el sistema es web. Trabajando un poquito más estos escenarios, podriamos generalizar estos pasos a actividades en lenguaje de negocios como "acceder al formulario de registro", y esta es una actividad más generalizada, en caso de que en un futuro cambiemos la manera de acceder, sustituyendo el enlace con un botón. Son detalles que podemos ir refinando a medida que trabajamos la aplicación y conocemos el negocio. La práctica nos hara mejorar día a día. 

Para más ideas y tips referentes a como describir los escenarios, sugiero leer [¿Qué hay en una historia?](/2012/08/que-hay-en-una-historia/).

En el próximo post estaré tratando cómo automatizar la verificación del sistema, partiendo de los escenarios y pasos que hemos trabajado en este artículo.

