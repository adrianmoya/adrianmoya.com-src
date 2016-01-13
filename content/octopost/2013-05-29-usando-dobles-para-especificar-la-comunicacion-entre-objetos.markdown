---
title: "Usando dobles para especificar la comunicación entre objetos"
date: "2013-05-29"
comments: true
slug: usando-dobles-para-especificar-la-comunicacion-entre-objetos
categories: 
- BDD
- Testing
- Agilidad
- Mocking
type: post
---

Cuando usamos [BDD de especificaciones para diseñar objetos](/2013/05/disenando-objetos-con-bdd-de-especificaciones/), queremos describir el comportamiento de nuestros objetos como una unidad. Pero ¿qué pasa cuando este objeto debe interactuar con otros para lograr su propósito?. A continuación explicaré cómo hacer uso de dobles de prueba para describir la comunicación entre distintos objetos.
<!--more-->

## ¿Qué son los dobles de prueba?##

Un doble de prueba es un objeto que imita el comportamiento de otro objeto en nuestra aplicación. Su principal función es permitirnos mantener las especificaciones centradas en el objeto que estamos describiendo, y los mensajes que intercambia con sus colaboradores, sin depender del estado de estos objetos adicionales.

Siendo BDD una técnica de diseño, cuando usamos un doble podemos determinar que métodos del colaborador debo llamar, que parámetros recibirá del objeto que estoy diseñando, y puedo escribir las respuestas que debe enviarme, para establecer las condiciones que necesito y poder describir como debe comportarse el objeto que hace uso de este colaborador cuando recibe dicha respuesta.

## ¿Por qué usar dobles?##
Los dobles permiten que tengamos mayor control en las especificaciones del comportamiento de nuestros objetos, ayudándonos a:

- Enfocarnos en la unidad: nos permiten mantener las pruebas enfocadas en un solo objeto a la vez.
- Especificar la interacción con objetos que aún no existen: Si nuestro colaborador aún no ha sido implementado, un doble puede permitir que continúe con mi especificación simulando la existencia del otro objeto.
- Controlar el estado del colaborador: Los objetos pueden comportarse de manera distinta dependiendo de su estado. Con un doble, puedo asegurarme de que el colaborador responde de acuerdo a un estado particular que yo mismo determino, sin dejar nada al azar.
- Simular un estado difícil de reproducir: Errores de conexión, pruebas relacionadas a la hora o fecha, son condiciones difíciles de reproducir en una prueba. Con el uso de dobles, podemos simular una respuesta como si se hubiese presentado la condición necesaria.
- Aumentar la velocidad de ejecución de las pruebas: un colaborador puede ser costoso de instanciar, sea porque requiere de la presencia de varios otros colaboradores o condiciones específicas del sistema, o sea que realiza una operación que tiene grandes costos de procesamiento o tiempo. Usar un doble nos permite que la prueba de código se efectúe más rápidamente al simular la respuesta.

El uso de dobles evita que tengamos que añadir métodos exclusivos para realizar pruebas al objeto, algo que siempre debemos evitar, pues el diseño no debe verse afectado por temas ajenos al funcionamiento de la aplicación.

## Los tipos de dobles##

Existen distintos tipos de dobles que podemos usar en nuestras especificaciones. A continuación sus características:

*Dummy*: se trata de un doble que no tiene comportamiento. Lo usamos para reemplazar cualquier colaborador que necesitemos en nuestra clase, pero que no vamos a utilizar durante nuestra especificación, por ejemplo cuando el constructor de nuestro objeto requiere algun colaborador.

*Fake*: el fake es un doble de un colaborador cuyos métodos debemos llamar, pero no nos importa su respuesta. Simplemente definimos que retorne null a la llamada para cumplir con la especificación. Por ejemplo, una llamada a un método que escribe un log. No nos importa que devuelva algo, sino que se haga la llamada.

*Stub*: el stub es un doble al que le programamos valores definidos para las llamadas a sus métodos, de manera de garantizar que las respuestas sean las esperadas para la especificación. Un ejemplo es cuando queremos que un colaborador nos devuelva un valor particular, para describir el comportamiento de nuestro objeto cuando recibe ese valor. O cuando queremos que el colaborador devuelva una excepción.

*Mock*: el mock es un doble que nos permite especificar los mensajes que debemos realizar a nuestro colaborador, incluyendo los valores que debemos pasar y la cantidad de veces que debemos hacer la llamada, además de controlar la respuesta recibida. El mock requiere de una configuración previa en la que especificamos nuestras espectativas, definiendo que métodos serán llamados, el orden, los valores, y que retornará. Luego ejercitamos el código que estamos especificando y finalmente validamos que se cumplieron nuestras espectativas. Un ejemplo sería cuando nuestro código dispara un evento, y queremos asegurarnos que nuestro colaborador lo recibe, por tanto especificamos que debe existir esa llamada y con el valor correcto del evento, y solo una vez.

*Spy*: el spy es un doble que podemos utilizar durante nuestra especificación, y al que podemos interrogar al final de la ejecución del código especificado para validar si se cumplieron nuestras espectativas. Funciona similar a un mock pero no requiere que especifiquemos las espectavias al inicio, lo que hace que el código sea un poco más simple. Al igual que el ejemplo con mock, podríamos usar un espía para validar si nuestro colaborador esta recibiendo un evento que generamos en el código, solo que interrogando al colaborador al final para saber cuantas veces recibió la llamada y si la recibió con los valores correctos.

Cada tipo de mock nos ayuda en casos particulares, el dummy cuando no nos importa su comportamiento, el fake y stub cuando nos interesa controlar la respuesta que recibimos del colaborador, el mock y el spy cuando queremos verificar detalles del paso del mensaje con el colaborador.

## Algunos tips finales##

- Solo debemos utilizar dobles de los objetos que nos pertenecen (osea que forman parte del codigo que estamos desarrollando): no debemos doblar librerías de terceros puesto que cualquier cambio que se suceda en esa librería dejaría a nuestras pruebas inválidas, ya que no tenemos control de los cambios que se puedan realizar. 

- Para el caso de interfaces con librerias externas, podemos construir una capa adaptador delgada, con una interfaz que manaje los objetos de nuestro dominio. Esta capa de adaptador debemos probarla con pruebas de integración, cuidando de inicializar correctamente el estado en que queremos ejercitar la integración (por ejemplo, si es una capa de acceso a datos, borrando todos los datos existentes en la BD). 

- El uso de dobles nos ayuda a expresar la manera en que nuestros objetos deben comunicarse e intercambiar mensajes, complementando las prácticas del post anterior y permitiendo una descripción completa del objeto que se diseña.

Proximamente algunos ejemplos. Saludos! 
