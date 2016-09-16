+++
categories = ["TDD", "Testing"]
date = "2016-09-16T14:51:09-05:00"
description = ""
keywords = ["tdd"]
title = "Pensando TDD (I)"

+++
Siempre escuchamos que TDD es una técnica de diseño que es guiada por pruebas. Pero dado que tenemos que escribir la prueba primero, nuestra mente comienza a pensar en términos de pruebas en lugar de diseño. Entonces comenzamos a pensar en casos borde, malas entradas, y cosas que son importante pensar, pero desvían nuestra atención del objetivo principal de la técnica, que es diseñar.

En esta entrada voy a volcar mi tren de pensamientos cuando diseño a través de TDD, para que puedan contrastar la diferencia acerca de pensar enfocado en pruebas y pensar acerca de diseño. Así mismo, cada decisión de diseño va a resultar en código para nuestra prueba.

<!-- more -->

# El ejercicio

Nuestra area es construir un convertidor de dinero. Para hacer las cosas simples, solo necesitamos convertir entre dólares americanos (USD) y pesos colombianos (COP).

# Seleccionando un nombre para el componente
La primera decisión de diseño es el nombre del componente. He decidido llamarlo MoneyConverter, que denota su funcionalidad principal. Pense en llamarlo USD2COPConverter pero no sonaba muy bien. Voy a crear esta clase en paquete com.adrianmoya.money. Habiendo decidido el nombre y el paquete, primero creo una clase de prueba llamada MoneyConverterTest en ese paquete. Luego añado una instancia privada de la clase que estoy a punto de crear. El IDE se va a quejar de que la clase no existe, asi que simplemente le digo que la cree para mi. Asi se ve el código:

```java
package com.adrianmoya.money;

public class MoneyConverterTest {

	private MoneyConverter converter;
	
}
```

# Pensando en las responsabilidades

Cuando diseño un objeto, me gusta pensar en terminos de [Modelos CRC](https://es.wikipedia.org/wiki/Tarjetas_CRC), definiendo el nombre de la clase, las responsabilidades y finalmente los colaboradores. Ya decidi el nombre, y la responsabilidad de esta clase es muy simple: convertir entre dólares y pesos. Tambien tengo muy presente el [Principio de Responsabilidad Simple](https://es.wikipedia.org/wiki/Principio_de_responsabilidad_%C3%BAnica), para que mi componente haga solo una cosa y la haga bien. Esto me ayuda a crear componentes que son pequeños y fáciles de mantener.

Teniendo clara la responsabilidad, pensemos acerca del [API](https://es.wikipedia.org/wiki/Interfaz_de_programaci%C3%B3n_de_aplicaciones). ¿Cómo quiero llamar la funcionalidad de este convertidor, y con qué parámetros? Para esto, pienso en un primer escenario, convertir dólares a pesos, y escribo una prueba con ese nombre. Divido la prueba en 3 secciones, [Dado/Cuando/Entonces](/2013/09/aumentando-la-expresividad-de-nuestras-especificaciones/#separar-contexto). Me gustan estos términos ya que inicialmente aprendí de pruebas haciendo BDD, pero podría haber usado Arreglar/Actuar/Asertar o cualquier otra plantilla. Luego, pienso en como llamar esta función, y lo escribo en la sección "Cuando". Digamos que la llamo `convertUSDtoCOP()` y que recibirá la cantidad de dólares a convertir, retornando el resultado en pesos. Como se trata de dinero, me iré con un BigDecimal como el tipo de dato. Quiero que este ejemplo convierta 10 dólares, asi que mi código se ve así:

```java
@Test
public void itConvertsUSDtoCOP(){
	//Given
	BigDecimal amountToConvert = new BigDecimal("10.00");
	//When
	BigDecimal result = converter.convertUSDtoCOP(amountToConvert);

}
```

El IDE se va a quejar nuevamente, asi que le digo que cree el método en la clase. Asi se ve la clase MoneyConverter en este momento:

```java
package com.adriamoya.money;

import java.math.BigDecimal;

public class MoneyConverter {

	public BigDecimal convertUSDtoCOP(BigDecimal bigDecimal) {
		// TODO Auto-generated method stub
		return null;
	}

}
```

# La tasa de conversión

Todavía necesitamos decidir como estará disponible la tasa de conversión para la clase. Podría pasarla como un parámetro adicional al método, pero no me gusta asi. Creo que para esta primera pasada, me iré con un argumento en el constructor. Añadiré un `Before` a la prueba para que instancie correctamente a la clase:

```java
@Before
public void setup(){
	BigDecimal usdToCopExchangeRate = new BigDecimal("2920.8167"); //Today! 
	converter = new MoneyConverter(usdToCopExchangeRate);
}
```

El IDE se queja de nuevo! Vamos, crea ese constructor para mi. Listo. Asi queda la clase en este momento:

```java
package com.adriamoya.money;

import java.math.BigDecimal;

public class MoneyConverter {

	public MoneyConverter(BigDecimal usdToCopExchangeRate) {
		// TODO Auto-generated constructor stub
	}

	public BigDecimal convertUSDtoCOP(BigDecimal bigDecimal) {
		// TODO Auto-generated method stub
		return null;
	}

}
```

Ya tenemos todo lo necesario para completar una prueba que falle. Dado una tasa de conversion de 2.920,82 pesos por dólar, mi expectativa es que 10 dólares sean convertidos a 29.208,20 pesos. Completo la prueba y la ejecuto:

```java
@Test
public void itConvertsUSDtoCOP(){
	//Given
	BigDecimal amountToConvert = new BigDecimal("10.00");
	//When
	BigDecimal result = converter.convertUSDtoCOP(amountToConvert);
	//Then
	assertEquals(new BigDecimal("29208.20"), result);
}
```

Noten que he decidio utilizar una escala de 2 decimales para este ejemplo. Es una decisión de diseño, expresada como una prueba. Esto podría cambiar en el futuro, pero para mi esta bien empezar así.

# Añadiendo una implementación

Voy a añadir una implementación para que pase la prueba:

```java
public class MoneyConverter {
	
	private static final int SCALE = 2; 
	private BigDecimal usdToCopExchangeRate;

	public MoneyConverter(BigDecimal usdToCopExchangeRate) {
		this.usdToCopExchangeRate = usdToCopExchangeRate.setScale(SCALE);
	}

	public BigDecimal convertUSDtoCOP(BigDecimal amountInUSD) {
		return amountInUSD.multiply(usdToCopExchangeRate).setScale(SCALE);
	}

}
```

# Cerrado y próximos pasos
Como pueden ver del ejercicio, he tomado varias decisiones de diseño para nuestra clase mientras escribía la prueba. Mi mente ha estado enfocada en el componente y como quiero que trabaje y no en probar todos los casos posibles buscando hacerlo fallar. 

Este diseño inicial va a evolucionar con el tiempo a medida que la aplicación comienza a demandar más características. Si bien no he seguido los pasos de bebé recomendados por TDD, tampoco me he ido de bruces a tratar de diseñar un convertidor-de-todas-las-monedas genérico que podría no necesitar al final. 

Finalmente, si mi aplicación solo necesita convertir entre dólares y pesos, sé que la tasa de cambio no va a ser tan estable como quisiera. Así que ¿Cómo podría obtener la tasa actualizada para la conversión? En el próximo artículo, voy a diseñar esa parte usando TDD e introduciré un poco del uso de dobles. 

Descarga el código de este artículo en [Github](https://github.com/adrianmoya/moneyconverter-tdd/archive/firstpass.tar.gz). 
