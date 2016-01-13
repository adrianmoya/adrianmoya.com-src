---
title: "Migrando mi blog a octopress y relanzamiento"
date: "2012-06-11"
comments: true
categories: 
- General
published: true
type: post
---

Finalmente he migrado mi blog a [Octopress](http://octopress.org/), un framework de blogueo para hackers! Existen muchas razones técnicas por las que varios programadores/gente de IT esta migrando su blog a esta plataforma, entre ellas la velocidad, escalabilidad y la seguridad. Sin embargo la escalabilidad no es uno de los problemas de mi site, que tiene tráfico bastante bajo (cosa que espero mejorar), pero aqui estan mis razones por las que quise migrar:
<!--more-->

* **Llevo muchas notas para post en documentos de texto**. Esta es la principal razon, siempre ando haciendo anotaciones para bloguear, pero nunca lo hago. Creo que me daba fastidio entrar a wordpress, hacer login, y el editor de wordpress. Ademas actualizar wordpress, los plugins, etc, sobre todo para poder renderizar bien codigo fuente. La verdad era una barrera psicológica para pasar las notas a blog posts.

* **Estoy enamorado de [GitHub](http://github.com)**. De mi [esposa](http://andreinaromero.com) tambien por cierto!. Pero en el plano técnico, GitHub me ha comprado totalmente. [Git](http://git-scm.com/) como control de versiones, el concepto de codificación social, la potencia para contribuir a proyectos abiertos, las páginas de github, en fin, no se como viví sin esto tanto tiempo :) Y pues poder editar mi blog como código y empujar a github (donde esta alojada esta nueva versión del blog) era algo que me entusiasmo a relanzar el blog, con esperanzas de que el flujo de llevar las ideas a posts sea mas suave.

* **Soy malo para los temas y el diseño**. Octopress incluye un tema HTML5/CSS3 limpio, que se adapta a dispositivos móviles, y con todas las cosas que queria poner como botones sociales, enlaces a github, delicious, etc. Asi que visualmente me gusta saliendo-de-la-caja. Ya luego le daré mi toque personal. 

Asi pues probamos (mi esposa y yo) Octopress en el [blog de la compañía](http://solucioneshospedadas.com/blog/) y finalmente me decidí migrar el mio. El proceso resumido fue mas o menos asi:

1. Instale Octopress y cree [el repositorio](https://github.com/adrianmoya/adrianmoya.github.com) para el codigo de mi blog.
2. Leyendo la [sección de migración](https://github.com/mojombo/jekyll/wiki/blog-migrations) de la documentación de Octopress, decidi usar [ExitWP](https://github.com/thomasf/exitwp) para convertir los posts exportados de wordpress a formato markdown.
3. Una vez migrados, descargué las imagenes de los post anteriores (eran pocas, por eso este paso lo pude hacer manualmente) y reescribí los urls de los posts apuntando a la nueva ubicación de las imagenes.
4. Retoque un poco los posts que tenían codigo, para aprovechar los plugins que Octopress trae para esta tarea. 
5. Luego refresque mi cuenta de [Disqus](http://disqus.com/), ya que tenia tiempo sin usarla y ni recordaba el password. Añadi el plugin a wordpress al blog viejo, exporte los comentarios que tenía a Disqus y de esta manera pude migrarlos hacia este nuevo formato de blog.
6. Finalmente hice push y publish para guardar el codigo fuente en github y publicar el sitio. 
7. Hice los cambios de dominio correspondientes para que apuntaran al ip de github y que la nueva versión quedara en línea.

Ha sido un proceso de un par de días a tiempo parcial, y he quedado satisfecho con el resultado. Espero ahora animarme a compartir más algunas de mis notas en línea!
