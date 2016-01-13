---
title: "Utilizando el patron Databuilder en nuestras pruebas unitarias"
date: "2013-07-30"
comments: true
categories: 
- Testing
- Patrones
- JUnit
type: post
---

Para aplicar TDD o BDDSpec de manera efectiva, es importante que conozcamos algunos patrones y técnicas que nos permitan mantener nuestra suite de pruebas ordenada y mantenible. El código de prueba debe ser tratado como ciudadano de primera categoría al igual que el de nuestra aplicación. A continuación describiré el uso del patrón DataBuilder, y cómo nos ayuda a escribir pruebas más expresivas.

<!--more-->

Recordemos que en una prueba unitaria automatizada, existen tres partes que debemos expresar con claridad: 

**Arrange (Given)**: En esta parte establecemos el contexto inicial de nuestra prueba.

**Act (When)**: La parte que ejecuta el código que deseamos probar.

**Assert (Then)**: La parte donde verificamos que el resultado es el esperado.

Durante la parte de establecer el contexto, muchas veces necesitamos construir varios objetos de nuestro dominio con ciertos valores predefinidos que son importantes o determinantes en la manera en que nuestro objeto se va a comportar cuando ejecutemos la operación que estamos probando. 

Para este propósito, me he encontrado que el patrón databuilder es esencial. Nos permite construir distintas versiones de un objeto con las características que necesitamos para cada prueba, reduciendo la cantidad de código que hay que escribir y aumentando la expresividad de la prueba. 

## El patrón Databuilder en las pruebas ##

Supongamos que queremos diseñar la operación de transferencia entre dos cuentas de un AccountManager. Necesitamos instanciar 2 objetos de tipo cuenta con un saldo conocido y luego llamar a la operación y definir los resultados esperados. Si nuestro objeto cuenta está definido asi:

``` java
//Account.java
public class Account {

    private String number;
    private int balance;
    
    public Account(String number, int balanceInicial) {
        this.number = number;
        this.balance = balanceInicial;        
    }
    
    //Setters y Getters
}
```

Entonces nuestra prueba se vería así:
``` java
//AccountManagerSpec.java
    @Test
    public void it_should_transfer_between_two_accounts(){
        //Given
        Account account1 = new Account("12345", 100);
        Account account2 = new Account("54321", 200);
```

Como pueden ver, este ejemplo es muy sencillo y sin embargo no queda muy claro a qué se refieren los parámetros del constructor de Account. Veamos entonces como nos puede ayudar un databuilder para los objetos Account.

## Construyendo un databuilder para Account ##

### Paso 1: Clase Builder ###
El primer paso para crear un databuilder para nuestro objeto es definir una clase (que generalmente lleva el mismo nombre de la clase y el sufijo "Builder") y definir propiedades iguales a las de nuestro objeto. Nuestra clase Account tiene dos propiedades, por lo tanto nuestro builder comenzaría inicialmente asi:

``` java
//AccountBuilder.java
public class AccountBuilder {
    private String number;
    private int balance;
    
}
```

### Paso 2: Constructor con valores por defecto ###
Como segundo paso, agregamos a nuestro builder un constructor que establece valores genéricos válidos para cada propiedad. Para el caso de nuestro Account, inicialicemos en el constructor el número de cuenta y el balance como sigue:

``` java
//AccountBuilder.java
    public AccountBuilder(){
        number = "12345";
        balance = 0;
    }
```

### Paso 3: Agregamos métodos para cambiar los valores por defecto ###
El nombre de los métodos usualmente se establece con el nombre de la propiedad con el sufijo "with". Los métodos devuelven la misma instancia del databuilder (this) de manera que podamos construir un API fluente. Veamos el ejemplo:

``` java
//AccountBuilder.java
    public AccountBuilder withNumber(String number){
        this.number = number;
        return this;
    }
    
    public AccountBuilder withBalance(int balance){
        this.balance = balance;
        return this;
    }
```

### Paso 4: Creamos un método build() ###
Este método es el que se encarga de construir nuestro objeto final, por lo que devuelve una instancia del mismo. Para ello, hace uso de los valores establecidos en las propiedades del builder.

``` java
//AccountBuilder.java
    public Account build(){
        return new Account(number, balance);
    }
```

### Paso 5: Agregamos un método estático para obtener una instancia del builder ###
Este paso es solo para añadir más expresividad a la prueba (uno de los objetivos de usar el patrón). Aqui usualmente llamamos al método con el nombre del objeto y el prefijo "a" (o "an" si comienza por vocal).

``` java
//AccountBuilder.java
    public static AccountBuilder anAccount(){
        return new AccountBuilder();
    }
```

## Usando el AccountBuilder ##
Ahora veamos como usamos nuestro builder recien creado, y como expresa mejor el contexto de nuestra prueba. Lo primero es importar el método estático del Builder:

``` java
//AccountManagerSpec.java
import static com.adrianmoya.specbddsample.builders.AccountBuilder.anAccount;
```

Y luego podemos usarlo para establecer el contexto:

``` java
//AccountManagerSpec.java
    @Test
    public void it_should_transfer_between_two_accounts(){
        //Given
        Account account1 = anAccount()
                .withBalance(100)
                .build();
        Account account2 = anAccount()
                .withBalance(200)
                .build();
```

Como pueden ver, la prueba se vuelve más expresiva, y al leer el contexto es más fácil de entender que se trata de una cuenta con un balance de 100 y una cuenta con un balance de 200. Además, podemos sacar del contexto cualquier valor que no nos interese para la prueba, en este caso el número de cuenta no aparece por ningun lado (es asignado a un valor por defecto por el builder). Si quisiéramos que la transferencia verificara que no se trata de la misma cuenta, podemos agregar el numero asi:

``` java
//AccountManagerSpec.java
        Account account1 = anAccount()
                .withNumber("12345")
                .withBalance(100)
                .build();
```
Cuando los objetos tienen muchas más propiedades, el builder nos ayuda a entender bien cuales son las propiedades que afectan la prueba.

## Combinando builders ##

Ahora veamos el caso en el que tenemos objetos complejos que contienen otros objetos. Supongamos que una cuenta tiene una lista de transacciones asociadas. 

``` java
//Account.java
public class Account {

    private String number;
    private int balance;
    private List<Transaction> transactions;
        
    public Account(String number, int balanceInicial) {
        this.number = number;
        this.balance = balanceInicial;
        transactions = new ArrayList<Transaction>();
    }
```
``` java
//Transaction.java
public class Transaction {
    private int amount;
    private String type;
    private Date date;
    
    public Transaction(int amount, String type, Date date){
        this.amount = amount;
        this.type = type;
        this.date = date;
    }
}
```

Para este caso, cuando queremos crear una cuenta con unas transacciones específicas, estos son los pasos que debemos realizar:

### Paso 1: Construir un builder para el objeto asociado ###
En este caso seguimos los pasos antes establecidos y construimos un builder para nuestro objeto Transaction.
``` java
//TransactionBuilder.java
public class TransactionBuilder {
    private int amount;
    private String type;
    private Date date;
    
    public TransactionBuilder(){
        this.amount = 10;
        this.type = "Credito";
        this.date = new Date();
    }
    
    public TransactionBuilder withAmount(int amount){
        this.amount = amount;
        return this;
    }
    
    public TransactionBuilder withType(String type){
        this.type = type;
        return this;
    }
    
    public TransactionBuilder withDate(Date date){
        this.date = date;
        return this;
    }
    
    public Transaction build(){
        return new Transaction(amount, type, date);
    }
    
    public static TransactionBuilder aTransaction(){
        return new TransactionBuilder();
    }
}
```

### Paso 2: Creamos un método que recibe como parámetro el builder (o array de builders) del otro objeto ###
Un Account contiene varios Transactions. En el caso de las colecciones, podemos hacer uso de los argumentos variables introducidos en java 5 (operador tres puntos). El método recibe el Builder del objeto asociado para evitar tener que llamar build por cada objeto adicional que queremos crear cuando usemos los builders en la prueba. Delegamos la llamada a build() a nuestro método with, como se ve en el ejemplo:

``` java
//AccountBuilder.java
    public AccountBuilder with(TransactionBuilder... transactionBuilders){
        transactions = new ArrayList<Transaction>();
        for(TransactionBuilder transactionBuilder: transactionBuilders){
            transactions.add(transactionBuilder.build());
        }
        return this;
    }
```

Podemos recibir cualquier cantidad de TransactionBuilder. Limpiamos la lista de transacciones existentes en el AccountBuilder, y por cada builder que recibimos, llamamos build() y lo añadimos a la cuenta. Noten tambien que hemos llamado al método solamente `with()`. Como java nos permite sobrecargar métodos, llamarlos with nos ayudara con la expresividad de la prueba, como vamos a ver a continuación.

## Usando los builders combinados ##
Finalmente, podemos ver como se ve el uso del AccountBuilder en combinación con el TransactionBuilder, y como expresa claramente la condición inicial de la prueba que estamos escribiendo:

``` java
//AccountManagerSpec.java
        //Given
        Account account1 = anAccount()
                .withNumber("12345")
                .withBalance(100)
                .with(
                    aTransaction().withType("Credito").withAmount(200),
                    aTransaction().withType("Credito").withAmount(100),
                    aTransaction().withType("Debito").withAmount(200))
                .build();
```

Cualquier desarrollador que lea el código de esta prueba ve claramente que la cuenta 1 tiene número "12345", balance 100, y tres transacciones, 2 créditos de 200 y 100 respectivamente, y un débito de 200. Podemos notar que no establecimos fecha para las transacciones, quizá porque no es importante para la prueba en cuestión la fecha en que fueron realizadas. 

## Tips y notas finales ##

Espero que en el artículo haya podido demostrar la utilidad de este patrón para generar datos (contexto) para nuestras pruebas unitarias. Por último les dejaré algunos tips de mi experiencia usándolos.

- Construir los builders a medida que construimos los objetos: Como comenté comenzando el artículo, debemos darle importancia al código de prueba. Lo ideal es que a medida que diseñamos el sistema y vamos añadiendo propiedades a nuestros objetos, vayamos actualizando los builders para poder construir objetos válidos con esas propiedades. De lo contrario las pruebas pudieran comenzar a romperse y fallar.

- Puede parecer que hay mucho código que escribir adicional solamente para instanciar un objeto en el contexto, pero créanme, vale el esfuerzo. Una vez escrito el builder puedes usarlo a través de toda tu suite de pruebas, acelerando la creación de nuevas pruebas que requieran del objeto. Además cuando vuelves luego de meses sin ver el código y lees la prueba, entiendes claramente como esta construido cada objeto gracias a las técnicas descritas para lograr mejor expresividad.

- Puedes tambien añadir métodos withoutX si deseas establecer a null alguna propiedad (en caso de que esto sea importante para el contexto).

- Puedes traducir los métodos si prefieres programar en castellano: conNumero(), conBalance(), unaCuenta(), con(), sin(), construir() etc.
