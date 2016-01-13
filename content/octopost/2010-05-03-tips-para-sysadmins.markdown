---
date: '2010-05-03'
slug: tips-para-sysadmins
status: publish
title: Tips para Sysadmins
comments: true
categories:
- Sysadmin
type: post
---

En este post he decidido recopilar una serie de comandos que son utiles para aquellos que administramos sistemas linux, de manera de tener una referencia rápida al momento que haga falta. Espero que alguien la encuentre útil ademas de mi:
<!--more-->

### MySQL


**Crear base de datos MySQL y usuario con todos los permisos.**




    
    amoya@amoya-laptop: $ mysql -u root
    mysql> create database basededatos;
    mysql> use basededatos;
    mysql> grant all on basededatos.* to 'usuario'@'localhost' identified by 'contraseña';





**Ver bases de datos, tablas y campos en mysql:**




    
    mysql> show databases;
    mysql> use basededatos;
    mysql> show tables;
    mysql> desc tabla;





**Respaldar y restaurar una base de datos MySQL**




    
    amoya@amoya-laptop: $ mysqldump -u username -p --opt dbname > dump.sql
    amoya@amoya-laptop: $ mysql -u username -p --database=dbname < dump.sql







### SSH y SCP


**Copiar llave publica a un servidor:**




    
    amoya@amoya-laptop: $ ssh-copy-id servidor-destino





**Crear un proxy con ssh en puerto 5000:**




    
    amoya@amoya-laptop: $ ssh usuario@servidor-destino -D5000





**Copias con scp**




    
    amoya@amoya-laptop: $ scp archivo-origen usuario@servidor-destino:path-destino







### Recuperación de disco con fallas (boteando con un liveCD):






    
    amoya@amoya-laptop: $ sudo fdisk -l  #Para ver el punto de montaje
    amoya@amoya-laptop: $ mount #Chequea el tipo de filesystem
    amoya@amoya-laptop: $ sudo fsck -y -t ext3 /dev/sda1 #Para ext3 montado en /dev/sda1







### Miscelaneos:


**Colocar la tilde en la consola:**

Alt Gr + ñ


**Buscar archivos:**




    
    amoya@amoya-laptop: $ find path-base -name "nombrearchivo"





**Memoria libre en el sistema:**




    
    amoya@amoya-laptop: $ free -m





**Espacio libre en disco:**




    
    amoya@amoya-laptop: $ df -h





**Crear Enlace Simbolico:**




    
    amoya@amoya-laptop: $ ln -s /ruta/real/archivo /ruta/destino/del/enlace





Listo, hasta un proximo post de tips para sysadmins!
