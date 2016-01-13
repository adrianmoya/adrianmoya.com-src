---
title: "Escribiendo mejores escenarios"
date: "2014-04-25"
comments: true
categories: 
- BDD
- Análisis
- Escenarios
type: post
---

Al momento de describir las características de un sistema a través de BDD, utilizamos ejemplos planteados en forma de escenarios para expresar cómo debe comportarse el sistema. Dichos escenarios son esenciales porque en ellos está plasmado el conocimiento del dominio de la aplicación, y sirven para documentar el sistema y también como insumo en el proceso de validación cuando los automatizamos utilizando herramientas BDD. A continuación veremos algunas preguntas que surgen y recomendaciones para lograr escenarios de calidad en nuestro proyecto.

<!--more-->
## El lenguaje es importante##

La idea de escribir escenarios en lenguaje legible por personas no técnicas es mejorar la comunicación. Siendo así, no recomiendo mezclar distintos idiomas en un documento de características. Las herramientas modernas soportan todos los lenguajes disponibles, por tanto podemos usar el idioma en que nuestro equipo se comunica principalmente, y no mezclas de palabras claves en inglés con frases en castellano, como "Given que el usuario hace login".

## Longitud del escenario##

Un punto importante a considerar cuando escribimos escenarios es su longitud. El tamaño ideal de un escenario es de 3 líneas, una para el contexto, la acción y el resultado respectivamente. Los escenarios muy largos son aburridos de leer, y complejos de automatizar. Escenarios con 3 pasos (o 2 si no hay un contexto relevante que mencionar) son simples de leer por todo el equipo. Cinco pasos sería lo máximo aceptable, más de cinco toca ver como podemos refactorizarlo, quiza dividiendo en 2 el escenario o creando antecedentes al conjunto de escenarios.

Para lograr escenarios cortos, podemos prescindir en el contexto de todo detalle innecesario, pudiendo hacer uso de la descripción de la característica en el documento para expresar más detalles si es necesario. Así debemos procurar colocar los datos relevantes de entrada en una sola línea. Detalles de navegación/autenticación no son relevantes al escenario, a menos que estemos describiendo algún tema particular de seguridad. 

La acción debe ser simple y no una serie de pasos encadenados. Si el proceso por alguna razón requiere que el usuario interactue con más de un elemento de la interfaz, podemos utilizar el término de negocio del proceso en lugar de encadenar pasos en el escenario. Por ejemplo "CUANDO el usuario aprueba la cotización" es mejor que "CUANDO el usuario hace click en aprobar Y hace click en el botón si".

El resultado debe ser expresado como lo debe percibir nuestro usuario, y no como cambios a bajo nivel, osea expresa comportamiento observable, por ejemplo un mensaje de éxito, y no especifiques cosas como que un registro se haya creado en la base de datos.

## Imperativo vs. Declarativo##

Este es un punto que depende un poco de la situación particular del proyecto. Un escenario escrito de forma imperativa se refiere a cuando escribimos cada paso a ejecutar en la interfaz de usuario, por ejemplo:

    Dado que ingreso "Adrian" en el campo "nombre"
    Y que ingreso "Moya" en el campo "apellido"
    Cuando presiono el boton "Crear"
    Entonces veo el mensaje "Usuario creado exitosamente"

Este tipo de escenario provee más detalles al lector acerca de los pasos a realizar para lograr un resultado, y es más sencillo de automatizar pues el paso hace una sola acción, pero crea escenarios muy largos, y es sensible a cambios de la interfaz, lo que no es deseable. Este tipo de escenario puede ser usado donde se requieren detalles para comunicar claramente como funciona una característica. 

El escenario declarativo obvia los detalles y habla más del proceso como tal:

    Dado que ingreso los datos de "Adrian"
    Cuando creo el usuario
    Entonces debo ver un mensaje de éxito.

Estos pasos son más complejos de automatizar (cada paso es un conjunto de acciones que hay que automatizar), y perdemos detalles de los datos usados, pero obtenemos como resultado escenarios cortos que hablan del proceso y que son muy robustos si hay constantes cambios en la interfaz (como en las etapas tempranas del proceso). Aqui las recomendaciones para mantener corta la longitud del escenario son escenciales (haciendo uso de la descripción y utilizando antecedentes).

La recomendación es escribir de forma más declarativa para los casos que son bien entendidos por todos los miembros del equipo, y pasar a un modo más imperativo en los casos en que hay alguna funcionalidad compleja donde el entendimiento es poco o esta concentrado en una sola persona. 

## Nunca utilizar detalles de implementación##

En líneas generales, debemos evitar escribir escenarios atados a detalles específicos de la interfaz,como "id's" de elementos html o elementos asociados a la tecnología particular en la que estamos desarrollando la interfaz. Esto hará que los escenarios se tornen débiles ya que cada cambio en la interfaz implicaría cambiar el escenario. 

## Identificando reglas de negocio##

A medida que vas explorando el dominio a través de ejemplos, de los mismos puedes inferir las reglas de negocio. Una regla de negocio viene a ser lo más general en que podemos describir el problema, y podemos colocarla en la descripción de la característica y no en los ejemplos. Algunas herramientas como Cucumber permiten utilizar las reglas de negocio como plantillas (Esquema de escenario) y ejecutar una tabla de valores concretos sobre esta plantilla, lo que es también válido y ayuda a reducir la cantidad de escenarios en un documento de característica. Veamos un ejemplo:

    Esquema del escenario: Suma
      Cuando sumo <numero1> con <numero2>
      Entonces el resultado es <resultado>

    Ejemplos:
      | numero1 | numero2 | resultado |
      |    2    |    2    |     4     |
      |   -2    |    2    |     0     |
      |   -2    |   -2    |    -4     |

En este caso la regla de negocio es la suma de dos números que da un resultado, y la tabla muestra los ejemplos y resultados concretos que deben obtenerse. Con esta funcionalidad evitamos escribir multiples escenarios que se repiten.

## Usar terminos familiares##

Nunca escribamos escenarios con variables, ya que automatizarlos implicaría desarrollar la aplicación en el código de prueba. Cosas como "Dado que sumo A con B Entonces obtengo C", fuera de usarlo como plantilla para valores concretos como vimos en el punto anterior, son totalmente indeseables. Por el contrario, la sugerencia es utilizar valores concretos que sean sencillos de recordar para el lector. Recordemos que la principal función del escenario es comunicar. 

Si vamos a crear usuarios, podemos darles nombres y personalidades, de manera que los escenarios se conviertan en pequeñas historias acerca de ese usuario. Al ser humano se le hace sencillo recordar y llevar seguimiento en su mente de nombres como "Adrian" más fácilmente que Usuario1. Utiliza números sencillos si el escenario maneja números. Los montos tambien deben ser simples para que leer el escenario sea una tarea ligera. Tus pruebas unitarias se encargarán de casos de calculos más complejos. 

Los titulos del escenario deben ser sencillos también. Queremos que cuando se discutan los escenarios, sea fácil recordar un escenario particular. 

## Un ejemplo final##

Veamos un ejemplo aplicando todas estas técnicas, colocando contexto en la descripción de la característica, escenarios cortos, forma declarativa, usando antecedentes, nombres familiares y titulos sencillos:

    Característica: Consulta de saldos

      La consulta de saldos permite que el usuario registrado en el sistema pueda ver los saldos de sus cuentas corrientes y de ahorro. Si el usuario es premium, ademas puede ver un enlace para consultar los movimientos. Estos ejemplos asumen que existe un usuario registrado llamado "Adrian" y un usuario registrado premium (ver wiki para detalles del usuario premium) llamado "Andreina"

      Narrativa:
      Para consultar los saldos de mis instrumentos financieros
      Como cliente del banco
      Yo quiero consultar mis saldos

    Antecedentes:
      Dado un cliente del banco llamado "Adrian" 
      Y un cliente premium llamado "Andreina"

    Escenario: Adrian consulta las cuentas
      Dado que estoy logueado como "Adrian"
      Cuando consulto las cuentas
      Entonces veo los saldos
      Pero no veo el enlace de movimientos

    Escenario: Andreina consulta las cuentas
      Dado que estoy logueado como "Andreina"
      Cuando consulto las cuentas
      Entonces veo los saldos
      Y veo el enlace hacia la consulta de movimientos

Espero que estas recomendaciones les ayuden a escribir mejores escenarios! 
