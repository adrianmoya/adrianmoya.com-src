---
date: '2010-12-14'
slug: ruby-basico-en-un-solo-post
status: publish
title: Ruby básico en un solo post
comments: true
categories:
- Desarrollo
type: post
---

La siguiente no intenta ser una guia para enseñar ruby a personas que no programen. Más bien es mi guia rapida para programar ruby, pero cualquiera que tenga nociones de programación la puede encontrar útil.
<!--more-->
**Consultar la documentación.**

Podemos consultar la documentación de ruby en linea en [http://www.ruby-doc.org](http://www.ruby-doc.org) o a través del comando:

```
$ ri Class.metodo
```

**Usar la consola interactiva:**

```
$ irb
```

**Arrays:**

Los arrays en ruby tienen indice basado en 0.

``` ruby
a = ['hola', 0, 'chao', 1] # Crea e inicializa un array.
a = %w{ hola chao avion carro } # Atajo para crear un array de palabras
a[0] # Retorna "hola" (Accede al elemento 0 del array)
```

**Hash:**

``` ruby
mi_hash = Hash.new(0) # Crea un nuevo Hash con valor por defecto 0
mi_hash['key1'] # Llave que no existe, devuelve 0 (valor por defecto)
mi_hash = { 'key1' => 'value1', 'key2' => 'value2' }  # Crear un hash con valores
mi_hash['key2'] # Retorna 'value2'
```

**If y unless:** Los bloques if y unless se terminan con end. Unless es el negado de if.

``` ruby
if cont > 5
  cont -= 1
end
```

Si es una sola linea dentro del if:

``` ruby
cont -= 1 if cont > 5
```

**While y Until:** Los bloques while y until tambien terminan con end. Until es el negado de while.

``` ruby
while cont < 10
  cont += 1
end
```

Si es una sola línea dentro del while:

``` ruby
cont += 1 while cont < 10
```

**Case:** los bloques case tienen dos formas de escribirse.

``` ruby
valor = case
          when a > 0 then true
          when a < 0 then false
          else false
end
    
case valor
when "valor1"
  codigo
when "valor2"
  codigo
else
  codigo
end
```

**Expresiones regulares:** Se escriben entre // y se verifican con =~

``` ruby
if hola =~ /pattern/
  match = true
end
``` 

**Bloques de código:** se asocian a un metodo y se ejecutan con yield dentro del método. Usar {} para una linea y begin/end para multiples. Para recibir parametros ponerlos entre ||.

``` ruby
def metodo
  yield
  puts "En la mitad del metodo"
  yield
end
metodo { puts "En mi bloque de codigo" } # Aqui estoy llamando a mi metodo con el bloque de codigo asociado
```

La salida de esto es:

```
En mi bloque de codigo
En la mitad del metodo
En mi bloque de codigo
```

**Un bloque con parámetros:**

``` ruby
def metodo { |param1, param2| bloquecodigo }  # metodo con un bloque de codigo con dos parámetros
  yield(param1, param2)     # Se ejecuta el bloque de codigo
  codigo                    # Aqui hay codigo del metodo
  yield(param1, param2)     # Se ejecuta nuevamente el bloque de codigo
end
```

**Ejemplo común:** El metodo each esta definido como una iteración de la colección con una llamada a yield con el elemento como parámetro. Por eso el siguiente bloque imprime cada palabra del hash:

``` ruby 
['Hola', 'Chao'].each {|palabra| print palabra, " "}
```

**For:** Los bloques de código son la base de los iteradores internos de ruby. El mas importante, each, es la base de un ciclo for:

``` ruby
for i in [1, 2, 3]
  print i
end
```

Que termina traduciendose en:

``` ruby
[1, 2, 3].each do |i|
  print i
end
```

**Clases:** A continuación una clase MiClase con su metodo inicializador y dos atributos (nombre y apellido). Los att_reader y attr_writer son atajos para definir metodos de lectura y escritura a los atributos de la clase, y crean un metodo parecido a este:

``` ruby
def mivariable
  @mivariable
end
def mivariable=(valor)
  @mivariable = valor
end
```
``` ruby
class MiClase < MiClasePadre            # Clase Miclase que hereda de MiClasePadre
  attr_reader :nombre, :apellido        # Métodos para acceder a los valores de estas variables
  attr_writer :nombre, :apellido        # Métodos para escribir en estas variables
  @@variable1                           # Variable de clase (igual en todas las instancias de esta clase)
  def initialize (nombre, apellido)     # Método initialize para inicializar las clases
    @nombre   = nombre                  # Variable de instancia
    @apellido = apellido
  end
  private                               # De aqui para abajo todo es private. Por defecto es public.
  def metodoprivado (nombre)            # Metodo privado de la clase
    nombre
  end
end
```

Clase singleton:

``` ruby
class MiSingleton
  private_class_method :new               # Hago el método privado para que no pueda crear una nueva instancia
  @@singleton = nil                       # Variable de clase, igual para todas las instancias de la clase
  def MiSingleton.create                  # Método de clase
    @@singleton = new unless @@singleton  # La crea a menos que exista
    @@singleton                           # Siempre devuelve la misma instancia. No funciona para programación multihilo.
  end
end
```

**Manejo de Excepciones:** El codigo se pone entre bloques begin end y se usa rescue para capturar las excepciones. El bloque else se ejecuta si no hubieron excepciones. El bloque ensure se ejecuta hubiera o no excepciones.

``` ruby
begin
  # Proceso
rescue SystemCallError
  # Codigo para manejar SystemCallError
rescue SyntaxError => error
  print "Se produjo un error:" + error
else
  puts "No se produjeron errores"
ensure
  puts "Bloque final"
end
```

**Throw y Catch:** Se pueden definir bloques catch y luego en cualquier parte hacer un throw que seran atrapados por los catch.

``` ruby
def metodo
  throw :salir if true
end
catch :salir do
  # Procesar info
end
```

**Modulos:** Ruby permite definir modulos, que vienen a ser namespaces. Se pueden llamar con require o incluir dentro de una clase con include (esto se llama mixin y hace las veces de herencia multiple).

``` ruby 
module MiModulo
  def metodo1
  end
end
module OtroModulo
  CONSTANTE = 1
  def OtroModulo.metodo1
  end
end
require 'MiModulo'
require 'OtroModulo'
MiModulo.metodo1      # Para llamar metodos igual que los metodos de clases
OtroModulo::CONSTANTE # Para leer constantes usar ::
class MiClase
  include MiModulo
end
MiClase.metodo1   # Llama a metodo1 definido en el modulo MiModulo
```

Para todo lo demas, consultar google y la documentación. A codificar!
