---
date: "2011-08-10"
slug: estableciendo-la-zona-horaria-en-turnkeylinux
status: publish
title: Estableciendo la zona horaria en TurnkeyLinux
comments: true
categories:
- TurnkeyLinux
tags:
- turnkeylinux
type: post
---

Para algunas aplicaciones de turnkeylinux, es importante fijar las fechas y horas del sistema antes de comenzar a trabajar. Por ejemplo, si estamos instalando un blog o foro, y queremos saber la fecha y hora exacta en que se produce una publicación. O si estamos usando una herramienta de control de incidencias, y necesitamos precisión en cuanto a la fecha y hora en que se crea y responde una incidencia. Finalmente, en aplicaciones de base de datos, si es importante realizar una auditoria, es importante que el sistema refleje correctamente las fechas y horas de los registros de la base de datos.
<!--more-->
Al desplegar una aplicación turnkeylinux, esta viene configurada por defecto en la zona horaria UTC, a partir de la cual se calculan el resto de las zonas horarias. Configurar la zona horaria que nos interesa es muy sencillo:


## Configurando la zona horaria via la interface de administración webmin


Por defecto, turnkeylinux no incluye el modulo para manejar la hora del sistema, por lo que procedemos a instalarlo:

1. Accedemos a webmin apuntando nuestro navegador a https://ip-de-la-aplicación:12321, haciendo login como root con la contraseña que hayamos configurado al momento de la instalación.

![](/images/2011/08/turnkey-login.png)

2. En el menu principal, seleccionamos System->Software Packages, y en la sección Install a New Package seleccionamos Package from APT y colocamos webmin-time como el nombre del paquete. Procedemos a hacer click en el botón Install.

![](/images/2011/08/tkl-softwarepackages.png)

3. Una vez que confirmamos que el modulo se ha instalado correctamente, seguimos el enlace de Return to module index. Ahora tendremos disponible en el menu System la opción System Time.

![](/images/2011/08/tkl-installpackage.png)

4. Accedemos a la opción System Time, y seleccionamos Change timezone. Alli podremos establecer nuestra zona horaria y automáticamente el servidor tomará la fecha y hora correspondiente.
![](/images/2011/08/tkl-systemtime-1.png)
![](/images/2011/08/tkl-systemtime-2.png)


## Configurando la zona horaria via la linea de comando


1. Hacemos ssh a nuestro servidor como root, usando el password que establecimos durante la instalación.

2. Ejecutamos el comando dpkg-reconfigure tzdata. Se nos presentara una lista desplegable donde podremos seleccionar nuestra zona horaria.

![](/images/2011/08/console-tzdata.png)

Eso es todo, ahora nuestro servidor estara trabajando con la fecha y hora de nuestro país, y podremos proceder a comenzar a utilizar nuestra aplicación Turnkeylinux.
