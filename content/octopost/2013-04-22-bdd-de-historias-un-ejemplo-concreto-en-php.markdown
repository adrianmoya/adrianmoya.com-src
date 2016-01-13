---
title: "BDD de historias: un ejemplo concreto en PHP"
date: "2013-04-22T00:00:02-05:00"
comments: true
categories: 
- BDD
- PHP
- Behat
- Agilidad
- Mink
type: post
---

A continuación, veamos como es la implementación en PHP del ejemplo presentado en [BDD de historias: un ejemplo concreto](/2013/04/bdd-de-historias-un-ejemplo-concreto/).

<!-- more -->
## Las librerías y herramientas ##

Para este ejemplo concreto, realizado en PHP, voy a utilizar las siguientes librerías y herramientas:

[**Silex**](http://silex.sensiolabs.org/): Silex es un micro framework basado en los componentes de [Symfony2](http://symfony.com/), el cual permite construir rápidamente una aplicación sencilla en PHP. También utilice [Twig](http://twig.sensiolabs.org/) como mecanismo de plantillas para la vista.

[**Behat**](http://behat.org/): Behat es un proyecto inspirado en Cucumber, y que es capaz de interpretar nuestras características y escenarios usando el mismo formato Dado/Cuando/Entonces (llamado Gherkin). Es la herramienta BDD por excelencia para el lenguaje PHP.

[**Mink**](http://mink.behat.org/): Mink es una capa de abstracción que permite manipular, a través de un API en php, cualquier navegador de los populares del mercado (Firefox, IE, Chrome, etc). Para el caso de los navegadores tradicionales, mink hace uso de otras librerías como Selenium (que utilicé en la implementación del ejemplo en Java) Para el caso de este ejemplo, usaremos un navegador sin interfaz, que simula las peticiones de los navegadores tradicionales pero a nivel de código, llamado [Goutte](https://github.com/fabpot/goutte/), desarrollado justamente para realizar este tipo de pruebas, y el cual es soportado por Mink.

[**PHPUnit**](https://github.com/sebastianbergmann/phpunit/): PHPUnit es una librería de la familia xUnit que permite hacer pruebas unitarias en PHP. Para el caso de este ejemplo particular, usaremos las aserciones de PHPUnit para validar los resultados de nuestras historias.

[**Composer**](http://getcomposer.org/): Composer es un manejador de dependencias para PHP. Es moderno y fácil de usar, y permite definir dependencias externas en nuestro proyecto tanto para desarrollo como para el proyecto final. 

## Implementando el ejemplo ##

Al igual que en la [implementación en Java](/2013/04/bdd-de-historias-un-ejemplo-concreto-en-java), la idea no es entrar en profundidad en las herramientas, esa será tarea de cada lector. Pero explicare a grandes rasgos como funcionan todas para nuestro ejemplo BDD:

### Preparando el ambiente para BDD ###

![](/images/2013/04/setup-behat-php.png)
**composer.json**: En el [composer.json](http://getcomposer.org/doc/01-basic-usage.md#composer-json-project-setup) definimos todas las dependencias de nuestro proyecto. Para la implementación de la aplicación, requerimos Silex y Twig. Para el desarrollo, requerimos behat (el framework BDD), mink (la capa de abstracción para controlar los navegadores), mink-extension (la extensión de Behat para integrar el uso de Mink), mink-goutte-driver (el driver de mink para controlar Goutte) y PHPUnit (para las aserciones).

**FeatureContext.php**: Esta clase contiene el codigo de cada uno de los pasos de nuestros escenarios. Aqui es donde estan definidos los métodos y las expresiones regulares que utiliza Behat para identificar las frases en el archivo de características y saber que método ejecutar.

**Suma.feature**: Este es nuestro archivo de característica, donde ponemos en lenguaje natural la historia y los escenarios, y que podemos extender a medida que profundizamos más en la característica. Nos sirve como documentación de la característica, y Behat ejecuta cada paso y verifica que nuestro sistema este cumpliendo con ellos. 

### La aplicación que cumple las especificaciones ###

La aplicación esta implementada con Silex y Twig, a continuación comento los archivos del código fuente:

![](/images/2013/04/src-bddsample-php.png)
**index.twig**: Es la plantilla que contiene el formulario con los campos de ingreso de las cifras y el botón calcular.

**index.php**: El controlador que atiende las peticiones del usuario y actualiza los campos. 

**.htaccess**: Archivo de configuración para apache para tener una URL más limpia (ver [cómo desplegar una app Silex](http://silex.sensiolabs.org/doc/web_servers.html)).

## Como puedo utilizar el ejemplo ##

Lo primero que hay que hacer es clonar el repositorio con el código fuente. Para esto debes tener [Git](http://git-scm.com/) instalado en tu sistema. Las instrucciones sobre como clonar un repositorio puedes verlas en mi post [Usando git de manera remota](/2013/01/usando-git-de-manera-remota/), o en [Google](http://lmgtfy.com/?q=Como+clonar+un+repositorio+de+github). El repositorio está en mi [cuenta de GitHub](https://github.com/adrianmoya/bddsample-php), y puede clonarse así:

    git clone git@github.com:adrianmoya/bddsample-php.git

Una vez tengas una copia local del repositorio, debes instalar las dependencias. Para esto es necesario [instalar Composer](http://getcomposer.org/doc/00-intro.md#installation-nix). Una vez instalado composer, ejecuta el siguiente comando:

    php composer.phar install --dev

Composer comenzará a descargar todas las dependencias. 

![](/images/2013/04/bddsample-php.png)
Luego despliega la aplicación, y comprueba que esté funcionando. Por defecto, Behat espera encontrarla en localhost/bddsample.

![](/images/2013/04/test-results-php.png)
Finalmente, puedes ejecutar Behat, llamando al comando bin/behat. A diferencia de JUnit, hasta donde conozco no existe un IDE con integración para mostrar los resultados de Behat o PHPUnit. Puedes ver los resultados ejecutando el comando por la consola. 

Pero tambien puedes visualizar los resultados en el reporte html, que para el ejemplo esta configurado para generarse en behat/html-report. Se ve mucho mejor, y puedes configurarlo para que se despliegue en un servidor que todos puedan acceder para ver los resultados.

![](/images/2013/04/test-results-php-web.png)

