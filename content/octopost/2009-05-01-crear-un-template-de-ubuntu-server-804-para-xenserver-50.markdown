---
date: '2009-05-01'
slug: crear-un-template-de-ubuntu-server-804-para-xenserver-50
status: publish
title: Crear un template de Ubuntu Server 8.04 para XenServer 5.0
comments: true
categories:
- Virtualización
tags:
- ubuntu
- xenserver
type: post
---

Hola! Bueno para inaugurar mi categoría de Virtualización en el Blog, he decidido escribir este breve tutorial a ver si le es útil a alguien en el planeta además de a mi. Esta basado en el único tutorial que consegui de este tema [aquí](http://community.citrix.com/blogs/citrite/anilma/2008/07/02/Installing+Ubuntu+on+XenServer). Le he dado unos toques personales que utilice en mi implementación. 
<!--more-->
En particular, utilice una imagen de Ubuntu JEOS de manera de solo tener la base del sistema operativo y poder desde ahí convertirlo en lo que queramos. Para conseguir el iso lo descargan desde [aquí](http://www.ubuntu.com/products/whatisubuntu/serveredition/jeos).

Comencemos:

1. En XenCenter, selecionamos nueva VM y seleccionamos el template de Windows Server 2003.

2. Colocamos el nombre, en mi caso "Ubuntu 8.04 Server", lo anotamos porque será necesario para un paso posterior, seleccionamos el ISO de Ubuntu JEOS, 1 cpu, 384 ram, las demas opciones por defecto pero antes de terminar le quitamos la opción Start VM automatically. 

3. Este paso es opcional: como no me gusta un disco virtual de 8GB para este template, selecciono la máquina recién creada, le doy a Storage, selecciono el disco y le doy Delete. Luego le pongo Add y le añado un disco de 5GB que me parece más acorde para un servidor linux de uso común. 

4. Arranco la máquina y en Console puedo seguir la instalación normal de ubuntu server (hay miles de guias por ahi de como hacerlo). Algunos detalles importantes aqui serían colocar un nombre genérico al usuario que se crea en la instalación, como administrador y un pass sencillo de recordar. Recordemos que esto será un template y luego a la máquina en si podemos cambiarle el password. 

5. Una vez finalizado comienza lo bueno, instalar el kernel xen y algunas herramientas. Ejecutamos el siguiente comando:

```
$ sudo apt-get install linux-image-xen openssh-server nano
```

6. Bueno una vez descargado e instalados, podemos entrar por ssh (con putty) para seguir trabajando con más comodidad. Para ello chequeamos que ip nos dio el servidor con:

```
$ ifconfig eth0
```

Y en nuestro cliente ssh (putty para windows) accedemos remotamente.

7. Ahora debemos corregir el grub para que tome el kernel nuevo:

``` 
$ sudo nano /boot/grub/menu.lst
```

Nos vamos al final del archivo y añadimos la línea del kernel que falta. Para hacer esto rapido simplemente me fui con el cursor hasta abajo para posicionarme debajo del ultimo kernel de la lista (en mi caso Ubuntu 8.04.2, kernel 2.6.24-23-virtual (recovery mode)), seleccione con el mouse las 5 lineas que describen el primer kernel y le di botón derecho. Esto me copia las 5 lineas al final. A partir de ahi edite las lineas para que en vez de decir virtual dijeran xen. El resultado debe verse como el que sigue:

![](/images/2009/05/ubuntuxen1.jpg)

Luego subí a la parte donde dice default y le coloque 2 (para que por defecto cargue el kernel que acabo de agregar). Finalmente ctrl+O, enter y ctrl+x para grabar y salir de nano.

8. Ahora hacemos un Force Shutdown del equipo para apagar la máquina virtual.

9. Nos conectamos al servidor XenServer vía SSH y ejecutamos los siguientes comandos (utilizar lo más que puedas TAB para autocompletar los comandos y no equivocarnos en la sintaxis o los uuid):

```
$ xe vm-list name-label="Ubuntu 8.04 Server" params=uuid --minimal
$ xe vm-param-set uuid= HVM-boot-policy=
$ xe vm-param-set uuid= PV-bootloader=pygrub
$ xe vm-param-set uuid= PV-args="console=tty0 xencons=tty"
$ xe vm-disk-list uuid=
$ xe vbd-param-set uuid= bootable=true
```

Aquí lo que hemos hecho es lo siguiente: Obtener el identificador unico de la máquina virtual, y a través del mismo setear los parámetros que quitan el modo HVM para que cargue Paravirtualizado. Además en los últimos dos comandos obtuvimos el id del disco duro virtual para setear que era booteable y que asi el pygrub (el cargador del kernel) supiera donde buscar el kernel xen. La cosa se ve asi en mi máquina:

![](/images/2009/05/ubuntuxen2.jpg)

Si cometen errores dice el tutorial original que los pueden corregir con

```    
$ xe-edit-bootloader
```

Yo tuve que corregir el menu.lst porque al copiar las lineas de arriba y pegarlas abajo me corto el UUID de la linea del kernel. Asi que con

```   
$ xe-edit-bootloader -n "Ubuntu 8.04 Server" -p 1
```

corregi lo que faltaba.

10. Listo, pues inician su VM y debe cargar ubuntu con el kernel virtual! Aparecen algunos mensajes de "Couldnt get a file descriptor referring to the console" que segun he buscado por ahi se pueden obviar sin problema. Ahora a instalar las xentools para tener la información adicional en XenCenter:

11. Accedemos via ssh al servidor y ejecutamos el siguiente comando:

``` 
$ sudo apt-get -y install bash && sudo dpkg-reconfigure dash
```

Respondemos No a la pregunta.

12. Montamos la imagen xstools.iso desde la pestaña Storage del XenCenter para colocar el disco en  la unidad. Lo montamos con:

```    
$ sudo mount /dev/xvdd /mnt
$ sudo dpkg -i /mnt/Linux/xe-guest-utilities_5.0.0-367_i386.deb
```

13. Listo, ya podemos apagar y convertir nuestra VM en un template para poder generar subsecuentes servidores Ubuntu en XenServer! La cosa quedó asi:

![](/images/2009/05/ubuntuxen3.jpg)

Si esto le ha sido útil a alguien, pueden dejar un comentario. Ahora intentaré instalar un Ubuntu 9.04 Server a ver...
