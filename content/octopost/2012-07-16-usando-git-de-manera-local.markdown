---
title: "Usando git de manera local"
date: "2012-07-16"
comments: true
categories: 
- git
type: post
---

Han pasado meses desde que me cambié de usar subversion en mis proyectos a git. Si bien al principio me parecio complicado, la verdad es que git es bastante sencillo. Los comandos que se usan a diario son fáciles de aprender. Y para los casos complicados de resolución de conflictos, siempre hay respuesta por internet. Asi que me he animado a escribir una serie de artículos referente al uso de este poderoso [sistema de control de versiones](http://es.wikipedia.org/wiki/Control_de_versiones) distribuido.
<!--more-->

El artículo de hoy sera referente al uso local de git en el terminal. Para los usuarios de windows (que estan poco acostumbrados al terminal) recomendaría que usaran algo como [tortoiseGit](http://code.google.com/p/tortoisegit/). Los conceptos son los mismos, solo que en lugar de escribir los comandos, accederan a las operaciones a través de menus contextuales. 

Siendo un SCV distribuido, es posible trabajar con el de manera local, sin necesitar un servidor central para hacer commit a los cambios. A continuación los comandos más comunes:

## Conceptos básicos ##

Para manejar los conceptos básicos de control de control de versiones, recomiendo la [pagina de wikipedia](http://es.wikipedia.org/wiki/Control_de_versiones) referente al tema. 

## Configuración inicial ##

Podemos configurar nuestro nombre e email a nivel global (para todos los repositorios) con los comandos

```bash
$ git config --global user.name "Firstname Lastname"
$ git config --global user.email "your_email@youremail.com"
```

Ademas, podemos configurar la salida de git para que la misma sea a color en el terminal.

```bash
$ git config --global color.ui true
```

## Uso local de Git ##

Lo primero que debemos hacer para usar git es inicializar un repositorio. Basta con entrar al directorio que queremos convertir en un repositorio y ejecutar el comando:

```bash
$ git init
```

Esto creara un directorio oculto .git que tendra toda la información del control de versiones. No mas directorios .svn en todos lados! 

## Trabajando con el repositorio ##

### Estado de cambios ###

Para ver el estado del repositorio, o lo que es lo mismo un informe de los cambios realizados a archivos/directorios, tenemos el comando status:

```bash
$ git status
```

El comando status nos devuelve la siguiente información:

**Rama en la que nos encontramos:** Git promueve el uso de ramas, y aca nos informa en que rama nos encontramos.

**Cambios que seran publicados:** Los archivos que hemos modificado y hemos añadido al commit.

**Cambios que no seran publicados:** Si hemos hecho cambios a algun archivo pero no lo hemos añadido al commit.

**Archivos a los que no se les esta haciendo seguimiento (untracked):** Son los archivos que se encuentran presentes en el directorio, pero que aun no han sido añadidos a git para hacerles seguimiento. Inicialmente todos los archivos se encuentran de esta manera. 

### Añadir cambios al commit ###

Git maneja el concepto de área de transición (o staging area). Para publicar un grupo de cambios, debemos indicarle a git que archivos debe incluir en el commit pasándolos al area de transición. Para esto usamos el comando:

```bash
$ git add nombre_del_archivo
```

Si queremos añadir todos los cambios:

```bash
$ git add .
```

### Para remover un archivo del área de transición ###

```bash
$ git reset HEAD nombre_del_archivo
```

### Mover o Eliminar archivos ###

Para mover/renombrar archivos:

```bash
$ git mv archivo_original archivo_destino
```

Para eliminar archivos:

```bash
$ git rm nombre_del_archivo
```

Si eliminamos el archivo sin usar git, podemos recuperarlo con:

```bash
$ git checkout nombre_del_archivo
```

Y luego eliminarlo de la manera correcta (con git rm).

## Ramas ##

El uso de ramas es sencillo y poderoso en git:

### Listar ramas ###

```bash
$ git branch
```

### Crear una nueva rama ###

```bash
$ git branch nombre_de_la_rama
```

### Cambiarse a una rama ###

```bash
$ git checkout nombre_de_la_rama
```

### Combinar ramas ###

Para combinar una rama con otra, debemos primero pasarnos a la rama destino, y luego ejecutar el comando merge:

```bash
$ git checkout rama_destino
$ git merge rama_a_combinar 
```

### Eliminar una rama ###

Para eliminar una rama, existen dos métodos:

Forma segura (verificando que la rama haya sido combinada):

```bash
$ git branch -d nombre_de_la_rama
```

Para forzar la eliminación de un branch sin combinar:

```bash
$ git branch -D nombre_de_la_rama
```

## Ignorando archivos ##

Para ignorar archivos, git utiliza un archivo especial llamado .gitignore (nótese el punto al inicio, para hacerlo oculto en sistemas mac/linux). Este archivo contiene una lista separada por retorno de carro de los archivos y directorios que git ignorará (no tomara en cuenta los cambios). Debe ser agregado al repositorio en la raiz y hacerle commit.

Esto cubre todos los comandos básicos para trabajar local con git. Para conocer los comandos más comunes para trabajar con repositorios remotos, consulta el próximo artículo, [Usando git de manera remota](/2013/01/usando-git-de-manera-remota/) 
