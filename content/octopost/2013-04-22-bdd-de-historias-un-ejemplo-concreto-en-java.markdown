---
title: "BDD de historias: un ejemplo concreto en Java"
date: "2013-04-22T00:00:01-05:00"
comments: true
categories: 
- BDD
- Java
- Cucumber
- Agilidad
- Selenium
type: post
---

A continuación, veamos como es la implementación en Java del ejemplo presentado en [BDD de historias: un ejemplo concreto](/2013/04/bdd-de-historias-un-ejemplo-concreto/).

<!--more-->

## Las librerías y herramientas ##

En el artículo anterior [Automatizando la verificación de historias en BDD](/2013/03/automatizando-la-verificacion-de-historias-en-bdd/), nombré algunas de las herramientas y frameworks utilizados para la automatización de las pruebas BDD en varios lenguajes. Si deseas ver que herramientas utilizar para tu lenguaje particular, te recomiendo ver ese artículo. Para este ejemplo concreto, realizado en Java, voy a utilizar las siguientes librerías y herramientas:

[**JavaEE 6**](http://www.oracle.com/technetwork/java/javaee/tech/index.html): El ejemplo, a pesar de ser muy sencillo, he decidido implementarlo en JavaEE 6, con la intención de demostrar el uso que puede tener BDD en la construcción de aplicaciones a nivel empresarial.

[**Cucumber-JVM**](https://github.com/cucumber/cucumber-jvm): Cucumber ha sido la herramienta más popular utilizada para BDD de historias, y la versión para java permite utilizarla para varios lenguajes que corren en la jvm, no solo para Java.

[**Selenium Webdriver**](http://docs.seleniumhq.org/docs/03_webdriver.jsp): Selenium Webdriver es una capa de abstracción que permite manipular, a través de un API en java, cualquier navegador de los populares del mercado (Firefox, IE, Chrome, etc). Para el caso de este ejemplo, usaremos un navegador sin interfaz, que simula las peticiones de los navegadores tradicionales pero a nivel de código, llamado [HTMLUnit](http://htmlunit.sourceforge.net/), desarrollado justamente para realizar este tipo de pruebas, y el cual es soportado por Selenium Webdriver.

[**Maven**](http://maven.apache.org/): Maven es una herramienta de manejo de dependencias, automatización de la construcción de una aplicación, de aplicación de pruebas, generación de documentación y varias cosas más. Es un estándar en el mundo Java, y aunque existen alternativas más modernas y que requieren menos XMLs para configurar, siempre es una apuesta segura porque esta ampliamente difundido y tiene muchos plugins e integraciones. 

[**JUnit**](http://junit.org/): El framework de pruebas unitarias de la familia xUnit, del cual solo usaremos las aserciones, para validar los resultados al final de la ejecución de un escenario. 

## Implementando el ejemplo ##

La intención de este artículo no es entrar en profundidad en las herramientas, pues cada quien eligirá las herramientas que desee, y ninguna de las seleccionadas es necesaria para implementar BDD. Sin embargo, trataré de explicar en lo posible como funciona cada parte del ejemplo, dejando como tarea al lector investigar más a fondo cada herramienta.

### Preparando el ambiente para BDD ###

![](/images/2013/04/setup-cucumber-java.png)
**pom.xml**: En el [pom](http://maven.apache.org/pom.html#What_is_the_POM) (Project Object Model de maven), hemos agregado las siguientes dependencias necesarias: junit (para usar una versión más reciente a la que integra maven por defecto), cucumber-java (las librerias de cucumber), cucumber-junit (integración de cucumber con junit), selenium-htmlunit-driver (selenium para java, especificamente el driver htmlunit. Más información de otros drivers [aquí](http://docs.seleniumhq.org/download/maven.jsp)), javaee-web-api (el api de JEE6, pues la app esta implementada en JSF). Ademas de esto, hemos agregado el plugin failsafe (para ejecutar las pruebas de cucumber durante la fase de pruebas de integración) y cargo (para desplegar la aplicación automáticamente cuando pasemos esto a un servidor de [integración continua](http://es.wikipedia.org/wiki/Integraci%C3%B3n_continua)). También actualizamos las versiones de los plugins war (que empaqueta la app) y surefire (que ejecuta las pruebas unitarias).

**CucumberIT.java**: Esta clase la colocamos en los paquetes de pruebas para que ejecute Cucumber. Se puede llamar como sea, pero se le puso IT al final para que el plugin failsafe de maven ejecutara la clase durante las pruebas de integración (este plugin ejecuta todas las clases cuyos nombres contienen el patrón IT). 

**StepDefinition.java**: Esta clase contiene el codigo de cada uno de los pasos de nuestros escenarios. También podemos llamarla como queramos, lo importante es que se encuentre en el classpath al momento de ejecutar las pruebas. Cada método de prueba se casa con un paso de nuestro archivo de características a través de una expresión regular, definida mediante una anotación particular de Cucumber. El mismo Cucumber se encarga de sugerirnos el nombre del método y la expresión regular, pero OJO, es solo una sugerencia y debemos tener cuidado de verificar que la expresión regular realmente cumple el texto que queremos igualar. En este ejemplo particular, tuve que modificar la expresión regular sugerida por Cucumber para que tambien detectara los números negativos.

**Suma.feature**: Este es nuestro archivo de característica, donde ponemos en lenguaje natural la historia y los escenarios, y que podemos extender a medida que profundizamos más en la característica. Nos sirve como documentación de la característica, y Cucumber ejecuta cada paso y verifica que nuestro sistema este cumpliendo con ellos.

### La aplicación que cumple las especificaciones ###

La aplicación esta implementada con JSF, y por tanto requiere un servidor que cumpla con el perfil web de JEE6. 

![](/images/2013/04/src-bddsample-java.png)
**index.xhtml**: Un simple facelet que contiene un formulario con dos campos y un botón para calcular.

**Index.java**: El controlador que atiende las peticiones del usuario y actualiza los campos. 

## Como puedo utilizar el ejemplo ##

Lo primero que hay que hacer es clonar el repositorio con el código fuente. Para esto debes tener [Git](http://git-scm.com/) instalado en tu sistema. Las instrucciones sobre como clonar un repositorio puedes verlas en mi post [Usando git de manera remota](/2013/01/usando-git-de-manera-remota/), o en [Google](http://lmgtfy.com/?q=Como+clonar+un+repositorio+de+github). El repositorio está en mi [cuenta de GitHub](https://github.com/adrianmoya/bddsample-java), y puede clonarse así:

    git clone git@github.com:adrianmoya/bddsample-java.git

Una vez tengas una copia local del repositorio, puedes abrir el código fuente en tu IDE Java favorito. En mi caso particular usé NetBeans 7.3, pero todos los IDEs actuales soportan Maven, y debe ser sencillo cargar un proyecto maven.

![](/images/2013/04/bddsample.png)
Luego, ejecuta la aplicación. Si estas en NetBeans, puedes ejecutarla en Glassfish. Debería de correr en cualquier servidor de aplicaciones que soporte JEE6. NO va a correr en Tomcat, pero si en [TomEE](http://tomee.apache.org/apache-tomee.html). Asegurate de usar el puerto 8080 ó actualizar el número del puerto en el archivo StepDefinitions.java.

![](/images/2013/04/test-results.png)
Finalmente, puedes mandar a ejecutar CucumberIT.java. En Netbeans, con darle click derecho y seleccionar Test File es suficiente. Nos mostrará los resultados en el mismo IDE, aunque no muy organizados. Una mejor manera de verlos es a través del reporte web que genera Cucumber. En el ejemplo esta configurado para generarlo en target/cucumber. Si ves este reporte en cualquier servidor web, tendras una lista más organizada de los resultados.

![](/images/2013/04/test-results-web.png)

También puedes utilizar el ejemplo desde una consola, sin necesidad de IDE. Basta con ejecutar `mvn verify` y obtendremos los resultados en la consola. Esta es la manera en la que un servidor de [Integración Continua](http://es.wikipedia.org/wiki/Integraci%C3%B3n_continua) ejecutaria nuestros escenarios, publicando los resultados en algun servidor web donde podamos consultarlos. El ejemplo está configurado para que maven automáticamente descargue glassfish si es necesario, lo inicie, despliegue la aplicación, ejecute las pruebas y detenga el servidor de aplicaciones. ¡Nada como la automatización! Por esta razón, dependiendo de tu velocidad de acceso a internet, ejecutarlo desde la consola pudiera tardar unos minutos mientras descarga las dependencias y glassfish. Esto solo sucederá cuando sea la primera vez, luego ejecutará más rapido. 

![](/images/2013/04/test-results-console.png)


