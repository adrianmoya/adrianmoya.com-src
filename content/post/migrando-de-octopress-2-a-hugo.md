+++
date = "2016-01-11T20:40:28-05:00"
title = "Migrando de Octopress 2 a Hugo"
draft = false 
+++

Hace [algún tiempo atrás](/2012/06/migrando-mi-blog-a-octopress-y-relanzamiento/), migré mi blog desde [Wordpress](https://es.wordpress.org/) a [Octopress 2](http://octopress.org/). Para el momento representaba un gran avance para mi y me introdujo al mundo de los generadores de sitios estáticos. Escribir en markdown es un placer y llevar el "código" de mi blog en git es muy natural para mi como desarrollador. Sin embargo el tiempo paso y encontré algunas dificultades. 

<!--more-->

Preparar una máquina nueva para trabajar con el blog era super incómodo y problemático, partiendo del hecho que tenía que instalar Ruby, instalar las gemas, y hacer el setup de ambas ramas del repo para que siguiera funcionando tal como venían funcionando en el equipo original. Octopress 2 tenía serios errores de diseño que [el mismo autor reconoció](http://octopress.org/2015/01/15/octopress-3.0-is-coming/), y prometió corregir en la futura versión 3. Entre ellas me molestaba tener que clonar el repositorio original de Octopress cada que quisiera iniciar un nuevo sitio. Instalar los temas tampoco era muy elegante. 

## Primera opción: esperar a Octopress 3

Mi primer plan era simplemente esperar Octopress 3, siendo fiel a este generador que me sirvió mucho a pesar de sus defectos. Sin embargo me di cuenta de que el desarrollo iba demasiado lento. Esperé durante mucho tiempo un release oficial, que nunca llegó. La verdad es que octopress se convirtió en una gema de Ruby, y está disponible actualmente, pero la documentación a la fecha nunca se publicó, nunca hubo disponible una guía de migración oficial, y al parecer el tema por defecto tampoco estaba listo. Lo que si noté es que el autor [@imathis](https://twitter.com/imathis) hizo un esfuerzo por desacoplar todas las partes de Octopress y alinearse a la comunidad del generador de sitios estáticos sobre el cual se basaba, [Jekyll](https://jekyllrb.com/). Siendo esto así, decidí cambiar el plan.

## Segunda opción: migrar el blog a Jekyll

Comencé a leer un poco la documentación de Jekkyl que es excelente. Y a migrar los primeros posts. Busqué un tema nuevo y me puse manos a la obra. Pero para ese momento Jekyll estaba por lanzar la version 3. Venía con nuevas características, mejor rendimiento, mejoras para la instalación de plugins, etc etc. Entonces comencé a sentir que el esfuerzo se perdería si no me pasaba de inmediato a Jekkyl 3. Decidí una vez más esperar al release, que finalmente [se dió en Octubre de 2015](http://jekyllrb.com/news/2015/10/26/jekyll-3-0-released/). 

Durante la espera comencé a aprender de [Go](https://golang.org/), e investigando un poco de generadores de sitios estáticos, di con [Hugo](http://gohugo.io/). Decidí darle una oportunidad por las siguientes razones: 

- Soportaba markdown (todas mis entradas están escritas en markdown).
- La descarga es un binario. Ya no tendría que instalar Ruby en mi equipo, simplemente bajar el ejecutable y comenzar a trabajar. 
- Utiliza por defecto el sistema de plantillas de Go, el cual es parte de las cosas que estoy aprendiendo, y el blog sería el mejor proyecto para practicar.

## La tercera es la vencida: migrar el blog a Hugo

Probé un poco Hugo y leí la documentación, que es muy completa (aunque desordenada en mi opinión). Y me gustó. Así que me puse manos a la obra. Aquí algunos puntos relativos a la migración:

### Tema

Elegí el tema [Hyde-X](http://themes.gohugo.io/hyde-x/), un tema algo común pero que me gusta, y tiene soporte para varias cosas interesantes, entre ellas los comentarios de Disqus que usaba en el blog, Google Analitycs y algunas cosillas más. Me tocó hacer algunas pequeñas modificaciones a las plantillas para traducir por ejemplo la información de la entrada al castellano y cambiar el formato de las fechas. 

### Imágenes

Las imágenes que tenía en algunas entradas en el blog utilizaban una sintáxis de un plugin de Octopress. No lo había notado hasta esta migración. Decidí utilizar la sintáxis nativa de markdown que aunque no ofrece tanto control como el plugin, hace que el contenido sea más compatible con cualquier sistema que soporte markdown (por si en un futuro decido migrar a otra cosa).

### Formato de Fechas

El formato de fechas en el [front-matter](http://gohugo.io/content/front-matter/) de las entradas es distinto al que usaba en Octopress. Me tocó corregir el formato para Hugo lo entendiera y pudiera generar los contenidos.

### URLs de las entradas

Para mí era importante mantener las urls originales de las entradas. Hugo por defecto utiliza urls en otro formato, por tanto me tocó realizar una modificación a la configuración por defecto para que las entradas anteriores usaran sus urls originales, y que las nuevas utilizaran el formato nuevo que me parece un poco mejor. Eso me llevo a cambios en el [config.toml](https://github.com/adrianmoya/adrianmoya.com-src/blob/00c99f2655606db51e5a8f9332fc03683a1fa4e2/config.toml#L7-L8) y en la [plantilla principal](https://github.com/adrianmoya/adrianmoya.com-src/blob/00c99f2655606db51e5a8f9332fc03683a1fa4e2/layouts/index.html#L4) del tema que elegí. Adicionalmente, tuve que definir el "slug" específico en cada post, puesto que Hugo maneja los acéntos y caracteres internacionales de manera distinta cuando construye las urls. 

### Comentarios de Disqus

Al realizar la migración a Hugo, los comentarios de las entradas desaparecieron. Esto se debió a que originalmente tenía configurado el dominio de github para el blog (adrianmoya.github.io). Por suerte, Disqus tiene una herramienta de migración de dominio, y al realizar la migración al dominio del blog (adrianmoya.com) los comentarios fueron reestablecidos. 

### Botones de compartir en redes sociales

El tema que utilicé no traía botones para compartir las entradas por las redes sociales, algo que me gusta para facilitar que los lectores compartan el contenido. Decidí comenzar a usar [ShareThis](http://www.sharethis.com/), por tanto abrí una cuenta y modifiqué el tema para incluir el código necesario en cada entrada.

### Despliegue

Para el tema de automatizar el despliegue, utilicé [la recomendación de la documentación de Hugo](http://gohugo.io/tutorials/github-pages-blog/#hosting-personal-organization-pages:fcefb200141ace3e7bfd6542457b7a72) de crear un repo adicional con las fuentes y utilizar un [script de deploy](https://github.com/adrianmoya/adrianmoya.com-src/blob/e2a526c0ed30214c1ba71befd8c2f6b8b4592f39/deploy.sh) que publica los cambios al submodulo. Había intentado usar un solo repositorio y utilizar subtree y dos ramas, pero a verdad se puso complicado el asunto y siempre reportaba conflictos, por lo que decidí irme por la via simple. 

### Configuraciones finales

Finalmente configuré algunas cosas que me ofrecía el tema, como las urls de las páginas sociales, el gravatar, etc. El resultado final es lo que ven ahora. Aún faltan detallitos pero creo que ya está bastante completo para seguir agregando contenido!
