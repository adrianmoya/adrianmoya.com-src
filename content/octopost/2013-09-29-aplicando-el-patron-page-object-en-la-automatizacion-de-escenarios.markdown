---
title: "Aplicando el patrón Page Object en la automatización de escenarios"
slug: aplicando-el-patron-page-object-en-la-automatizacion-de-escenarios
date: "2013-09-29"
comments: true
categories: 
- BDD
- Testing
- Selenium
- Cucumber
type: post
---

En los últimos dos post, he comentado acerca de patrones y técnicas para las pruebas unitarias. En esta oportunidad, hablaré de un patrón que podemos utilizar a nivel de nuestras pruebas de extremo a extremo (end to end). Se trata del patron Page Object.

<!--more-->

## El problema ##

Cuando comenzamos a escribir pruebas automatizadas que manipulan el sistema como si de nuestro usuario se tratase, como cuando automatizamos escenarios de BDD de historias, es normal que comencemos a escribir pruebas que tienen mucho conocimiento acerca de la estructura de nuestra aplicación, por ejemplo, el nombre de los campos, de los botones, de los enlaces, etc., pues de esta estructura nos valemos para decirle a nuestro navegador donde va a introducir texto, que va a pulsar, y de donde leer el mensaje esperado para poder realizar los asserts en nuestra prueba.

El problema surge en que a medida que la aplicación evoluciona, la interfaz de usuario tambien lo hace. Generalmente, al ser la cara visible del sistema, es la parte en donde nuestro cliente nos da retroalimentación y donde se pone creativo. Pon aqui una lista, quitale esta columna y añade esta, cámbiale el botón por un enlace, y pare usted de contar. Como buenos agilistas que somos, abrazamos los cambios con alegría (no?). Pero cada cambio sencillo como reemplazar un campo de texto por un selector, puede quebrar nuestras pruebas automatizadas, en múltiples puntos.

## Una estrategia para pruebas más robustas ##

La recomendación cuando automatizamos escenarios es que desacoplemos totalmente los temas relativos a la estructura de nuestra interfaz de usuario (elementos con los que interactuamos como botones, enlaces, etc) del código de nuestras pruebas, encapsulando esta información en objetos que representan los elementos de la interfaz de nuestra aplicación. De esta manera si la prueba necesita crear un usuario con nombre "Adrian" de edad 35, no importa si el nombre se introduce con un teclado virtual en la pantalla, o si la edad es un campo de texto o un selector de numeros, lo importante es que la prueba logra introducir esos datos a través de nuestra interfaz.

## El patrón Page Object ##

El patrón [Page Object](http://code.google.com/p/selenium/wiki/PageObjects) nos ayuda con la tarea de robustecer nuestras pruebas. Consiste en crear un objeto por cada conjunto de elementos significativos de la interfaz con la que interactuamos. Aunque el nombre nos sugiera (y generalmente suceda) que cada objeto debe representar una pagina de nuestra aplicación, lo cierto es que si dentro de la pagina tenemos componentes visuales que reutilizamos en otras partes, podemos construir un Page Object de ese elemento para poder reutilizarlo. Un ejemplo de esto sería el menu de navegación, que probablemente aparezca en muchas de nuestras páginas de la aplicación, o un selector de ciudad/estado, que podemos usar en distintos procedimientos, o hasta un area de notificaciones que siempre este presente durante el uso de la app. El objeto recibiría nuestro controlador del navegador y escondería su uso del código de la prueba.

```java 
//PaginaPrincipal.java
public class PaginaPrincipal {
    private final WebDriver driver;
    private final BarraNavegacion barraNavegacion;

    public PaginaPrincipal(WebDriver driver) {
        this.driver = driver;
        barraNavegacion = new BarraNavegacion(driver);
    }
}
```

Dicho objeto de página debe exponer métodos que permitan al usuario que escribe la prueba hacer las cosas que pudiera hacer un humano interactuando con ese componente o página. Así, nuestra definición de pasos usaría estos métodos:

``` java
//StepDefinitions.java
PaginaPrincipal.irAModuloUsuario() // Nos permite navegar al modulo de usuarios
PaginaPrincipal.introducirNombre("Adrian") // Nos permite introducir el nombre del usuario
PaginaPrincipal.enviarFormulario() // Nos permite enviar el formulario de datos
PaginaPrincipal.selecionarLenguaje("Inglés") // Nos permite seleccionar el lenguaje inglés
PaginaPrincipal.leerMensajeRecibido() // Nos permite obtener el mensaje recibido despues de la operación.
PaginaPrincipal.leerSiElUsuarioDeseaRecibirInformacion() // Nos permite saber si el usuario quiere recibir correos de nuestra parte.
```
Malos ejemplos de aplicar el patrón es tener métodos como estos:

``` java
PaginaPrincipal.pulsarBotonEnviar() // Estamos revelando que la manera de enviar el formulario es con un botón.
PaginaPrincipal.leerCampoConId("nombre") // Estamos revelando id de elementos html en la firma.
PaginaPrincipal.escribirEnCampoConNombre("nombre", "Adrian") // Nuevamente hay elementos html en la firma. 
PaginaPrincipal.pulsarEnlace("Usuario") // Si el elemento cambia de ser un enlace?
PaginaPrincipal.ponerRecibirInformacionEn(false) // Estamos asumiendo que el componente sera de verdadero/falso.
```
La regla de oro es: esconder detalles estructurales de la página, y expresar las cosas de manera más procedimental. Luego, dentro de este conjunto de métodos podemos trabajar con nuestro navegador y la estrucura de la página para realizar lo que queremos. 

## Navegando a otras páginas ##

Cuando una llamada a una operación resulta en la navegación a otra página, nuestro Page Object debe encargarse de construir y devolver otro Page Object que representa la otra página, de manera que nuestro usuario continúe realizando las operaciones en la otra página. Veamos un ejemplo:
```java
//PaginaPrincipal.java
public PaginaUsuarios irAModuloUsuarios() {
    return barraNavegacion.irAModuloUsuarios();
}
```
```java
//BarraNavegacion.java
public PaginaUsuarios irAModuloUsuarios() {
    driver.findElement(By.linkText("Usuarios")).click();
    return new PaginaUsuarios(driver);
}
```

Y en el lado de la prueba se usaría asi:

```java
//StepDefinitions.java
PaginaUsuarios paginaUsuarios = PaginaPrincipal.irAModuloUsuario();
```

## Donde van los asserts ##

Ahora toquemos el tema de los asserts que debemos hacer en la prueba. Si hablamos de responsabilidades de cada clase, la responsabilidad del Page Object es abstraernos de la estructura de la interfaz de usuario, y la responsabilidad de la prueba es verificar que cierta condición se cumple. Esto nos lleva a la conclusión de que dichos asserts DEBEN IR en la prueba y no en el page object. Por tanto los asserts ideales serían de la forma:

``` java
//StepDefinitions.java
assertThat("Mensaje de éxito inesperado", PaginaPrincipal.leerMensajeRecibido(), is("El usuario se ha creado con éxito"));
```

Hay una aserción sin embargo que podríamos dejar dentro del page object, y es para verificar que el objeto se cargó correctamente. Queremos asumir que el objeto al instanciarlo se encuentra en la página correcta, de otro modo sus operaciones podrían fallar y generarnos algunos dolores de cabeza innecesarios. Esto podemos hacerlo en el constructor del objeto página, verificando algún elemento como el titulo de la página que sea el correcto.

```java
//PaginaPrincipal.java
public PaginaPrincipal(WebDriver driver) {
    this.driver = driver;
    barraNavegacion = new BarraNavegacion(driver);
    //Validemos que nos encontramos en PaginaPrincipal
    assertThat("La pagina cargada no es la principal", driver.getTitle(), is("Pagina Principal"));
}
```
## LLamadas asíncronas ##

Para el tema del manejo de llamadas asíncronas, tambien deberíamos tratarlo dentro del objeto de página. Si una operación resulta en una llamada ajax, queremos esconder de nuestro usuario del objeto que dicha llamada debe esperar a que cargue el div resultado con la tabla de resultados, ya que esto tambien representa un detalle de implementación más que de procedimientos. Al esconder estos detalles, ayudamos a que el objeto sea más sencillo de usar, ya que se trataría como si fuera un objeto síncrono, evitando reescribir el código de esperas en multiples pruebas.

## Tips adicionales ##

* Podemos tambien exponer operaciones completas que reutilicen varios métodos, como por ejemplo el siguiente para autenticarnos:

``` java
//PaginaPrincipal.java
public PaginaPrincipal autenticarseComo(String usuario, String password){
    introducirNombre(usuario);
    introducirPassword(password);
    return enviarFormulario();
}
```

* El nombre del paso dentro del escenario nos da una pista de como debe llamarse el nombre del método que debe exponer nuestro page object. Usando el tip anterior podemos exponer la operación como un solo método, haciendo que las implementaciones de nuestros pasos sean de 1 o muy pocas líneas de codigo.

* Para el caso en que una acción nos lleve a otra página distinta al camino feliz, por ejemplo un login con usuario equivocado que en lugar de llevarnos a la página principal, nos va a devolver a la página de login nuevamente, debemos crear un método separado que devuelva la página que esperamos recibir en este flujo alternativo, de manera que podamos seguir interactuando con la interfaz. En ese caso debemos usar un nombre expresivo para la operación, como por ejemplo `autenticarseComoUsuarioInvalido("Adrian","passwordmalo");`, para que sea más claro al que utiliza nuestro objeto que debe utilizar este si espera que el login falle. 
