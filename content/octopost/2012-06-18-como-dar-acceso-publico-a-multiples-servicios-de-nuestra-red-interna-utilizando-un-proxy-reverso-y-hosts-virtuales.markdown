---
title: "Como dar acceso público a multiples servicios de nuestra red interna utilizando un proxy reverso y hosts virtuales."
slug: "como-dar-acceso-publico-a-multiples-servicios-de-nuestra-red-interna-utilizando-un-proxy-reverso-y-hosts-virtuales"
date: "2012-06-18"
comments: true
categories: 
- Sysadmin
type: post
---

Es común tener en nuestra red interna (ya sea de casa o en la empresa) varios servicios corriendo y querer exponer dos o más de ellos públicamente a través de internet. Existen muchas maneras de realizar esto, pero personalmente me gusta una técnica conocida como Proxy Reverso combinada con el uso de hosts virtuales, que describo a continuación:
<!--more-->

## Algunos términos antes de comenzar ##

**IP Pública**: Es la IP que nuestro proveedor de servicio nos da y es única en internet. Generalmente es dínamica, lo que quiere decir que el proveedor no garantiza que sea siempre la misma, aunque no cambia tampoco con tanta frecuencia. El mismo proveedor puede vendernos IPs públicas fijas, pero tienen un costo elevado. La IP Pública nos permite llegar hasta nuestro router desde internet. Podemos saber la IP accediendo desde nuestra red a [WhatIsMyIP.com](http://www.whatismyip.com/)

**IP Privada**: Es la IP que nuestros dispositivos reciben dentro de la red interna. Generalmente de la forma 192.168.x.x. Esta IP no puede ser accedida desde internet, pues es privada a cada red. 

**Router**: Es el dispositivo que conecta nuestra red interna y el internet. Para mayor detalles del concepto, pueden ver [wikipedia](http://es.wikipedia.org/wiki/Router). Para el tema de este artículo nos interesa es saber que es el encargado de hacer lo que llamamos **Reenvio de puertos**.

**Reenvio de puertos**: Es la capacidad del router de encaminar un paquete de datos proveniente de internet hacia cualquier servidor/dispositivo conectado a nuestra red interna. Dependiendo de la marca/modelo, el reenvio de puertos se configura de manera distinta, pero el resultado es el mismo: un conjunto de reglas que le dicen al router que hacer cuando llega un paquete de datos a nuestra IP Pública en un puerto específico. Por ejemplo, si hay una petición http (cuyo puerto estándar es el 80), podemos especificar que servidor (IP Privada) atenderá la petición.

**Dominio**: Es el nombre unico que identifica a un sitio web o servicio. Los dominios internamente son traducidos a direcciones IP. 

**Proxy Reverso**: Es un servidor que recibe y despacha las peticiones de entrada y salida. En el caso de este artículo, las peticiones web (a los puertos 80 y 443).

**Host Virtual**: Es un concepto que permite a un servidor web atender peticiones para varios dominios, como si se tuvieran distintos servidores web.

## Instalando el proxy reverso ##

Necesitamos instalar un servidor que hará la función de proxy reverso. Puede ser físico o virtual (recomendado), y pueden usar cualquier distribución de Linux y ajustar los pasos, yo para este artículo usaré [Ubuntu 12.04 Server](http://www.ubuntu.com/). Luego de instalarlo (que hay miles de guías en internet de como hacerlo) accedemos a él con el usuario administrador y seguimos estos pasos:

* Instalamos los componentes necesarios (Apache, certificados SSL).

``` bash
$ apt-get update && apt-get install apache2 ssl-cert
```

* Editamos el archivo de puertos de apache, para deshabilitar el puerto 80 que es el puerto de http, y habilitar los host virtuales para el puerto 443 (https). Este    paso es opcional, pero me gusta hacerlo porque es mas seguro acceder via https a los servicios, sobre todo si vamos a introducir contraseñas para hacer login. Simplemente basta con comentar la linea `Listen 80` en el archivo `/etc/apache2/ports.conf` y agregar la linea `NameVirtualHost *:443` debajo de `Listen 443`.

``` apache
    #NameVirtualHost *:80
    #Listen 80
    
    <IfModule mod_ssl.c>
        # If you add NameVirtualHost *:443 here, you will also have to change
        # the VirtualHost statement in /etc/apache2/sites-available/default-ssl
        # to <VirtualHost *:443>
        # Server Name Indication for SSL named virtual hosts is currently not
        # supported by MSIE on Windows XP.
        Listen 443
        NameVirtualHost *:443
    </IfModule>
```
* Habilitamos los modulos de apache `ssl`, `proxy` y `proxy_http` y reiniciamos el servidor.

``` bash
    $ sudo a2enmod ssl proxy proxy_http
    $ sudo service apache2 restart
```

* Deshabilitamos el sitio por defecto de apache.

``` bash
    $ sudo a2dissite default
```

* Ahora, por cada servicio que queremos exponer, creamos un host virtual en apache, asignándole un dominio. Aqui pueden usar dominios gratuitos (por ejemplo de [NO-IP](http://www.no-ip.com/)), subdominios de algun dominio que les pertenezca. Estos dominios debemos configurarlos para que apunten a la IP Pública de nuestra red. Luego para cada uno de ellos, creamos la configuración en la ruta `/etc/apache2/sites-available/`. La plantilla es como sigue (usare como ejemplo un sitio blog ficticio con un dominio gratuito):

``` apache
#/etc/apache2/sites-available/miblog.no-ip.org
#VHost configuration for miblog

<VirtualHost *:443>
        ServerName miblog.no-ip.org
        ProxyPass               /       http://192.168.1.x/
        ProxyPassReverse        /       http://192.168.1.x/
        SSLCertificateFile    /etc/ssl/certs/ssl-cert-snakeoil.pem
        SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
        SSLEngine on
        SSLProxyEngine on
</VirtualHost>

```
Noten que a pesar de que para acceder al proxy uso https, internamente puedo usar http. El certificado SSL del proxy esta cubriendo todas los servicios internos y por tanto no es necesario instalar un certificado en cada uno de ellos. Por supuesto los datos viajan desde el proxy al servicio sin encriptación, por tanto si desean una seguridad en la red interna, simplemente expongan cada servicio por https y configuran el proxy de manera acorde.

Si no deseamos usar SSL (no recomendado) simplemente usamos una plantilla como la que sigue (y en este caso no comentar la linea `Listen 80` en la configuración de puertos de apache):

``` apache
#/etc/apache2/sites-available/miblog.no-ip.org
#VHost configuration for miblog

<VirtualHost *:80>
        ServerName miblog.no-ip.org
        ProxyPass               /       http://192.168.1.x/
        ProxyPassReverse        /       http://192.168.1.x/
</VirtualHost>

```

* Luego de crear el sitio, lo activamos y reiniciamos apache

``` bash
$ sudo a2ensite miblog.no-ip.org
$ sudo service apache2 reload
```
Cada vez que queremos añadir un sitio nuevo, repetimos los 2 pasos anteriores.

* El siguiente paso debemos realizarlo en la aplicación de administración del router. La misma varía por cada modelo, asi que deben consultar el manual, pero generalmente se accede a ella en la dirección 192.168.1.1. Lo que debemos configurar aqui es el redireccionamiento de puertos. Queremos apuntar el puerto 80 (si usamos http) y el puerto 443 (https) para que se redirijan a la dirección interna del proxy usando el protocolo TCP. En mi router (un Belkin) la cosa se ve mas o menos asi:

![](/images/2012/06/portforward.png)

Y listo. Esto es lo que va a pasar la proxima vez que hagamos una petición al dominio:

1. Nos dirigimos al dominio en el navegador (ejemplo miblog.no-ip.org) y el mismo nos lleva a nuestra IP Pública (puesto que lo hemos configurado asi en nuestro manejador del dominio)
2. El router redirige la petición al proxy.
3. El proxy atiende la petición, y basado en el dominio, elige a que servidor debe redirigir la misma. 
4. El servicio responde al proxy, quien a su vez le responde al navegador.

Asi podemos tener varios servicios corriendo y acceder a ellos asignandoles un dominio distinto. Saludos!
