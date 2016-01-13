---
title: "Usando git de manera remota"
date: "2013-01-05"
comments: true
categories: 
- git
type: post
---

En el primer artículo, [Usando Git de manera local](/2012/07/usando-git-de-manera-local/), mostré algunos de los comandos más útiles a la hora de trabajar con git de manera local. Continuando la serie de artículos de git, en esta oportunidad tratare el tema de los remotos. Git es un sistema de control de versiones distribuido, lo que nos permite conectar nuestro repositorio local a otra copia remota, y de esa manera poder trabajar en equipo con otros desarrolladores. 
<!--more-->

## Trabajando con remotos ##

Las siguientes son las operaciones mas comunes que podemos realizar con repositorios remotos:

### Listar repositorios remotos ###

Para listar los remotos configurados en un repositorio git, utilizamos el comando `remote`. Si le agregamos la opción `-v` nos da la información completa con los urls de búsqueda y empuje de información.

```
$ git remote
$ git remote -v
```

### Clonando un remoto ###

La manera más sencilla de comenzar a trabajar con un remoto es clonándolo. Esta operación genera una copia del repositorio en nuestro sistema de archivos local, y establece un remoto de nombre "origin" para el repositorio original. De esta manera queda automáticamente "casado" nuestro repositorio con el remoto.

```bash
$ git clone url_del_repositorio_remoto
```

### Agregar/Eliminar remotos ###

Para agregar/eliminar un remoto, utilizamos `remote add` o `remote rm` con los parámetros del repositorio remoto que queremos agregar/eliminar:

```
$ git remote add nombre_remoto url_remoto
$ git remote rm nombre_remoto
```

### Buscando una rama del remoto ###

Para buscar los cambios realizados en una rama del repositorio remoto, utilizamos el comando `fetch`. Esto actualizará la rama que estemos buscando en nuestra copia local con las actualizaciones realizadas en el repositorio remoto. 

```
$ git fetch nombre_remoto nombre_rama
```

### Listado ramas remotas ###
Para ver las ramas remotas a las que hacemos seguimiento, utilizamos el comando `branch` con el parámetro `-r`:

```bash
$ git branch -r
```

### Mezclando las ramas remotas ###

Podemos mezclar una rama remota a nuestra rama local muy similar a como se hace trabajando de manera local. Primero nos pasamos a la rama destino, y luego utilizamos el comando `merge`, haciendo referencia a la rama remota (previamente buscada con `fetch`).

```
$ git checkout rama_destino
$ git merge nombre_remoto/nombre_rama
```

### Empujando cambios a una rama remota ###

Para empujar los cambios locales de una rama a una rama remota, se utiliza el comando `push`:

```
$ git push nombre_remoto nombre_rama
```

### Buscando y Mezclando en un mismo paso ###

Podemos realizar las operaciones de busqueda y mezcla de ramas remotas utilizando el comando `pull`. Debemos estar en la rama destino, y ejecutar:

```
$ git pull nombre_remoto nombre_rama
```

### Eliminando una rama remota ###

Si queremos eliminar una rama del repositorio remoto, utilizamos el comando `push` antecediendo el nombre de la rama con dos puntos (:).

```
$ git push nombre_remoto :nombre_rama
```

Esto cubre los comandos para trabajar con git de manera remota más comunes. Espero que sirvan de referencia rápida. En un próximo artículo comentaré de un flujo de trabajo en equipo usando git como control de versiones.
