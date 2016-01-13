---
date: "2011-08-23"
slug: anadir-acceso-via-apache-a-subversion-en-turnkeylinux-revision-control
status: publish
title: Añadir acceso via Apache a subversion en TurnkeyLinux Revision Control
comments: true
categories:
- TurnkeyLinux
type: post
---

La herramienta [TurnkeyLinux Revision Control](http://www.turnkeylinux.org/revision-control) ofrece de manera rápida un servidor de control de versiones con 4 conocidas y muy utilizadas herramientas para dicho trabajo: Subversion, Git, Bazaar y Mercurial. En lo personal yo lo utilizo más que todo para Subversion y Git. A pesar de venir preconfigurado con las opciones más deseables, en lo personal extraño la posibilidad de poder acceder subversion a través del protocolo http (usando Apache). A continuación explico el procedimiento para agregar esta característica  a esta herramienta:
<!--more-->
1. Acceder al servidor via ssh (o via webshell a través de http://ip-del-servidor:12320) con el usuario root y el password establecido al momento de la instalación.

2. Primero debemos instalar el módulo de apache que permite integrar svn. Para ello ejecutamos el siguiente comando (No olvidar ejecutar apt-get update si es la primera vez que instalamos paquetes en este servidor):

```
$ apt-get install libapache2-svn
```

3. Luego procedemos a crear un archivo para guardar los usuarios y passwords encriptados para acceder a los repositorios. El archivo estará ubicado en /etc/subversion y lo llamaremos svn-auth-file. Lo crearemos usando la herramienta de creación de usuarios de Apache htpasswd. Con la opción -cm creamos el archivo por primera vez. Luego para añadir usuarios adicionales solo usaremos -m. Nos preguntará el password del usuario 2 veces. Podemos revisar el archivo generado para ver el listado de usuarios.

```
$ htpasswd -cm /etc/subversion/svn-auth-file usuario1
$ htpasswd -m /etc/subversion/svn-auth-file usuario2
```

4. Luego debemos editar el archivo de apache para el sitio websvn. Vamos a agregarle seguridad a dicho sitio utilizando nuestro nuevo archivo de usuarios. Para esto editamos el archivo /etc/apache2/conf.d/websvn y agregamos 4 lineas en la descripción del sitio. El archivo debe quedar como sigue:

```
    Alias /svn /usr/share/websvn

    <Directory /usr/share/websvn>
      DirectoryIndex index.php
      Options FollowSymLinks
      Order allow,deny
      Allow from all
      AuthType Basic
      AuthName "Subversion repository"
      AuthUserFile /etc/subversion/svn-auth-file
      Require valid-user
    </Directory>
```

5. Configuramos el apache para poder acceder a los repositorios. Para ello creamos y editamos el archivo /etc/apache2/conf.d/svnprivate con el siguiente contenido: 

``` 
    <Location /svn-private>
      DAV svn
      SVNParentPath /srv/repos/svn/
      AuthType Basic
      AuthName "Subversion repository"
      AuthUserFile /etc/subversion/svn-auth-file
      Require valid-user
    </Location>
```

6. Procedemos a recargar apache para que tome las nuevas configuraciones. Debemos ademas darle a apache la propiedad de los archivos de los repositorios de subversion, que estan ubicados en /srv/repos/svn

```
$ service apache2 reload
$ chown -R www-data:www-data /srv/repos/svn/
```

7. Hasta aqui, ya podremos acceder via http a nuestros repositorios, puedes probar con tu navegador web abriendo el url http://ip-del-servidor/svn-private/nombredelrepositorio . Aparecerá el dialogo estándar de apache que solicita el usuario y la contraseña. Introducimos los datos del usuario y podremos ver el contenido del repositorio:

![](/images/2011/08/svn-http.png)


## Agregando Acceso Seguro SSL (https)


Si intentamos hacer checkout con el cliente subversion via https, vamos a recibir el siguiente error:
"Al certificado del servidor le falta el atributo commonName en el nombre del sujeto"
El cliente de subversion requiere, para poder acceder via https a un repositorio, que el certificado del servidor contenga el atributo commonName, cosa que el certificado por defecto no trae. Por tanto debemos crear un certificado nuevo que contenga ese atributo. Para esto, ejecutamos los siguientes comandos (utilizare el dominio svn.ejemplo.com como ejemplo):


## 1. Instalamos la herramienta openssl:

```
$ apt-get install openssl
```

2. Creamos la llave del certificado utilizando como nombre el dominio (esto es para recordar que la llave pertenece a ese dominio)

```
$ openssl genrsa 4096 > /etc/ssl/private/svn.ejemplo.com.key
```

3. Generamos el certificado, y nos aseguramos de colocar un valor en el atributo commonName, que puede ser el dominio del servidor (svn.ejemplo.com).

``` 
$ openssl req -new -key /etc/ssl/private/svn.ejemplo.com.key -x509 -days 365 -out /etc/ssl/certs/svn.ejemplo.com.pem
```

4. Editamos el archivo /etc/apache2/sites-available/default-ssl para configurar el acceso utilizando nuestro certificado recién creado. Para ello modificamos las lineas siguientes:

```
    SSLCertificateFile    /etc/ssl/certs/svn.ejemplo.com.pem
    SSLCertificateKeyFile /etc/ssl/private/svn.ejemplo.com.key
```

5. Desactivamos y activamos el sitio para que tome los cambios, y finalmente recargamos la configuración de apache:

```
$ a2dissite default-ssl
$ a2ensite default-ssl
$ service apache2 reload
```

Listo, ahora la primera vez que intentemos acceder al repositorio con el cliente de subversion, nos alertará de que el certificado es emitido por una autoridad marcada como confiable. Simplemente respondemos que aceptamos permanentemente el certificado. Luego intentamos de nuevo y nos pedira el nombre de usuario y password y podremos terminar de acceder al codigo fuente.
