+++
categories = ["TDD", "Testing"]
date = "2017-11-28T00:00:00-05:00"
description = ""
keywords = ["tdd"]
title = "Pensando TDD (II)"

+++
En mi [artículo anterior](/post/pensando-tdd-i/), exploramos el tren de pensamientos cuando se usa desarrollo guiado por pruebas (TDD) diseñando un componente para convertir dinero de USD a COP. En esta segunda parte, añadiré algo de diseño adicional e introduciré el tema de los dobles. 

<!--more-->

Hasta ahora, hemos diseñado un componente `MoneyConverter` con un método `convertUSDtoCOP()` que usa una tasa de conversión fija como parámetro del constructor. Obviamente, la tasa de conversión va a variar con el tiempo y vamos a querer obtener la tasa actual al momento de hacer la conversión para tener resultados reales. 

Siguiendo el principio de responsabilidad simple, queremos que otro componente se encargue de obtener la última tasa de cambio entre ambas monedas.

# Introduciendo colaboradores

Dado que estoy diseñando el `MoneyConverter` usando TDD, los colaboradores serán introducidos como dobles (comúnmente conocidos como mocks). Para esto, añado la dependencia de Mockito al proyecto, pues esta es la librería que uso para mocking en Java. Para este ejemplo, es simplemente añadirla al pom.xml:

```xml
<dependency>
    <groupId>org.mockito</groupId>
    <artifactId>mockito-core</artifactId>
    <version>2.8.47</version>
</dependency>
```
Luego, imagino a este colaborador como un servicio, al cual le llamaré `ExchangeRateService`. Declararé un mock en mi prueba para comenzar a usarlo. 

```java
@Mock private ExchangeRateService mockedExchageRateService;
```

Para usar este doble, debo inicializarlo durante el `setup()` de la prueba:

```java
MockitoAnnotations.initMocks(this);
```

El IDE se va a quejar inmediatamente acerca de que `ExchangeRateService` no existe. Deja que el IDE lo cree por tí, como una interface. ¿Por qué una interface? Pudiera ser una clase concreta, pero prefiero trabajar en una interface en este punto porque quiero enfocar mis esfuerzos de diseño en el protocolo usado para colaborar con ese objeto, osea, lo que voy a enviar y lo que voy a recibir de él. Cuando comience a diseñar el componente `ExchangeRateService`, será más fácil implementar esta interface para respetar el protocolo que voy a establecer ahora mismo. Aqui está lo que produjo el IDE: 

```java
package net.velocitypartners.money;
 
public interface ExchangeRateService {
}
```

# Obteniendo la tasa de cambio

El próximo paso es pensar como quiero obtener la tasa de cambio del servicio. Creo que llamaré a un método de nombre `getExchangeRate(String fromCurrencyCode, String toCurrencyCode)`, pasando un par de códigos de moneda y esperando un resultado `BigDecimal`. Estoy decidiendo que este servicio debería manejar cualquier moneda como parámetro, aunque solo pasaré las que me interesan en este momento, COP y USD. Esto es porque pienso envolver un servicio externo con éste, asi que dejo la API abierta para el futuro. Añadamos esto a la interface de manera que quede como de esta manera:

```java
public interface ExchangeRateService {
    BigDecimal getExchangeRate(String fromCurrencyCode, String toCurrencyCode);
}
```

# ¿Qué tan frecuentemente debería actualizar la tasa de cambio? 

La frecuencia de las actualizaciones es también otra decisión de diseño. Para este ejemplo sencillo, decido consultar la tasa de cambio en cada llamada, y expresaré esto a través de mi prueba. Puede que esta no sea la mejor decisión a nivel de rendimiento, pero funcionará para el ejemplo. Comencemos entonces modificando el método `setup()` de la prueba para enviar el `ExchangeRateService` en el constructor del `MoneyConverter` en lugar de la tasa actual. El IDE va a quejarse de que no existe un constructor con ese tipo de parámetro, asi que le pedimos que cambie el constructor actual. Esto va a romper el constructor, pero por ahora, comentaré el código del constructor para poder seguir configurando el test. También voy a remover el `usdToCopExchangeRate`, que ya no es necesario. Mi método de `setup()` se ve asi:

```java
@Before public void setup(){ 
    MockitoAnnotations.initMocks(this);  
    converter = new MoneyConverter(mockedExchangeRateService); 
}
```

Ahora, cambiemos la prueba: en la sección "Given", voy a preparar un valor para cuando se llame al servicio de conversión, en este caso, voy a mantener la tasa de conversión de 2920.82 pesos por dólar del artículo anterior, para no tener que modificar mi aserción. La sección "When" va a ser la misma, llamando al método `convertUSDtoCOP()`. En la sección "Then", quiero verificar que mi componente interactua con el `ExchangeRateService` de la manera que he decidido, actualizando la tasa con cada llamado al servicio de conversión. Usare la función `verify` de Mockito para esto. El código final se ve de esta manera:

```java
@Test public void itConvertsUSDtoCOP(){ 
    //Given 
    BigDecimal amountToConvert = new BigDecimal("10.00"); 
    when(mockedExchangeRateService.getExchangeRate("USD", "COP")).thenReturn(new BigDecimal("2920.82")); 
    //When 
    BigDecimal result = converter.convertUSDtoCOP(amountToConvert); 
    //Then 
    assertEquals(new BigDecimal("29208.20"), result); 
    verify(mockedExchangeRateService).getExchangeRate("USD", "COP"); 
}
```

Asi tenemos nuestra prueba que falla, expresando nuestro diseño. Podemos ahora implementar los cambios para hacerla pasar:

```java
public class MoneyConverter { 
    private static final int SCALE = 2;  
    private ExchangeRateService exchangeRateService;
 
    public MoneyConverter(ExchangeRateService exchangeRateService) { 
        this.exchangeRateService = exchangeRateService; 
    }
 
    public BigDecimal convertUSDtoCOP(BigDecimal amountInUSD) { 
        BigDecimal usdToCopExchangeRate = exchangeRateService.getExchangeRate("USD", "COP"); 
        return amountInUSD.multiply(usdToCopExchangeRate).setScale(SCALE); 
    }
}
```
Ejecutamos la prueba y bingo! prueba en verde. Hemos codificado nuestro diseño de manera exitosa. Puedes ver el código de este artículo en mi [Github](https://github.com/adrianmoya/moneyconverter-tdd/), haciendo checkout de la rama "part2". 

# Cerrando

Espero que estos dos artículos expongan la idea de como aplicar el pensamiento del desarrollo guiado por pruebas en tus proyectos. Recuerda que aunque son tests, el propósito real es crear el API y expresar la relación y el protocolo de comunicación entre los componentes. Un buen conocimiento de las herramientas y librerías usadas te hará sentir en casa cuando estes aplicando esta técnica. Feliz desarrollo guiado por pruebas!