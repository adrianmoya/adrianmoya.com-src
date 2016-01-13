---
date: "2011-09-11"
slug: probando-constraints-de-clases-de-dominio-en-grails
status: publish
title: Probando constraints de clases de dominio en Grails
comments: true
categories:
- Desarrollo
tags:
- grails
- tests
- unit
type: post
---

Comenzando con una serie de publicaciones que hare en el tema de las pruebas unitarias para grails, comenzaré detallando la manera de probar los constrains de una clase de Dominio. Para ello, tomare como ejemplo la siguiente clase, con dos propiedades y algunas restricciones:
<!--more-->
``` groovy    
class Person {

    String name
    Integer age

    static constraints = {
        name blank:false, unique:true, nullable: false
        age min:18, max:20
    }
}
```

Como se puede ver, debemos probar que name no sea null, ni blanco y que sea unico, y que age este comprendida entre 18 y 20. Comencemos:

1. Dentro de nuestra clase de pruebas unitarias, creamos el método TestConstraints() (puede ser cualquier nombre pero este deja bastante claro lo que hace). Si son muchos campos, se puede crear un método separado por cada campo, de manera que estén mas organizadas las pruebas. Para este ejemplo corto lo dejare como un solo método.

``` groovy
void testConstraints() {
}
```

2. Si necesitamos probar unicidad en algun campo, definimos una instancia (o varias) de la clase en nuestro método de prueba de manera correcta, para que durante las pruebas probemos que no admite campos duplicados. En el ejemplo, name debe ser unico, por lo que crearemos una instancia válida para poder probar este constraint mas adelante.

``` groovy 
def existingPerson = new Person(name:'Adrian', age:18)
```

3. Utilizamos el método mockForConstraintsTests aplicado a nuestra clase de dominio. Este paso añade los métodos de validación que Grails inyecta en la clase de dominio (y que no están presentes aqui en las pruebas unitarias). Recibe como segundo parámetro una lista de instancias de la clase. En nuestro ejemplo, le paso la que acabamos de crear, existingPerson.

``` groovy
mockForConstraintsTests(Person, [existingPerson])
```

 4. A partir de aqui comenzamos a probar cada una de las restricciones, creando instancias inválidas de la clase, ejecutando el método validate() y verificando que en el mapa de errores generado por validate, estan los errores que esperamos.

4.1. Para probar nullable: Creamos una instancia con el campo en null, verificamos que no sea válida y que el error asociado al campo sea nullable.

``` groovy
//Probando nullables
def person = new Person()
assertFalse person.validate()
assertEquals 'El campo name no es null', 'nullable', person.errors['name']
```

4.2. Para probar blank: Creamos una instancia con el campo en blanco, verificamos que no sea válida y que el error asociado al campo sea blank.

``` groovy
//Probando blanks
person = new Person(name:'')
assertFalse person.validate()
assertEquals 'El campo name no es blank', 'blank', person.errors['name']
```

4.3. Para probar unique, vamos a hacer uso de la instancia correcta definida mas temprano en el paso 2, en este caso duplicando el campo name (poniendo el valor 'Adrian') y verificando que no sea válida y que el error asociado sea unique:

``` groovy
//Probando unique
person = new Person(name:'Adrian')
assertFalse person.validate()
assertEquals 'El campo name no puede ser duplicado', 'unique', person.errors['name']
```

4.4. Para probar mínimos, creamos una instancia con el campo con el valor menor al aceptado, verificamos que no sea válida y que el error asociado sea min:

``` groovy
//Probando minimo
person = new Person(age:17)
assertFalse person.validate()
assertEquals 'El campo age debe ser mayor a 17', 'min', person.errors['age']
```

4.5. Para probar máximos, creamos una instancia con el campo con el valor mayor al aceptado, verificamos que no sea válida y que el error asociado sea max:

``` groovy
//Probando máximo
person = new Person(age:21)
assertFalse person.validate()
assertEquals 'El campo age debe ser menor a 20', 'max', person.errors['age']
```

4.6. Por ultimo construimos una instancia correcta y verificamos que sea válida.

``` groovy
//Probar exito
person = new Person(name:'Chuck', age: 18)
assertTrue 'La instancia Chuck SIEMPRE debe ser válida', person.validate()
```

Como pueden ver, el proceso es muy sencillo y pasa siempre por crear la instancia con el campo que rompa la restricción que queremos probar, verificar con assertFalse que el método validate() devuelve false (que no es válida) y verificar que en el error del campo este la descripción del constraint que violamos en la prueba. De esta manera podemos probar todos los constraints de nuestra clase de dominio.

Algunos tips finales: solo durante la creación de nuestra primera instancia usamos la palabra clave def, de ahi en adelante usamos la misma variable para el resto de las instancias. Esto es básico de groovy pero es una de esas conchas de mango que le hacen a uno perder tiempo. Tambien es recomendable colocar un mensaje descriptivo del error que estamos probando, como se ve en el ejemplo, para que los reportes de las pruebas sean más claros cuando fallen.

Esto es todo, hasta la próxima!
