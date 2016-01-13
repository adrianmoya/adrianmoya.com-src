---
title: "Participando en dojos de agilidad"
date: "2013-02-11"
comments: true
categories: 
- Agilidad
- Dojo
- Kata
type: post
---

La semana pasada tuve la oportunidad de participar en 3 Dojos de agilidad patrocinados por [Kleer](http://www.kleer.la/), dictados por Carlos Peix [@carlospeix](https://twitter.com/carlospeix), instructor y coach de agilidad. El sitio de encuentro fue [HackBo](http://www.hackbo.co/), un espacio comunitario para la realización de eventos relacionados a tecnología y nuevas tendencias en Bogotá. A continuación les comento mis impresiones:

<!-- more -->

## ¿Qué son los dojos de agilidad? ##
El término [dojo](http://es.wikipedia.org/wiki/D%C5%8Dj%C5%8D) proviene de las artes marciales, y en esencia es un sitio para la práctica y aprendizaje. En el caso de la agilidad, se ha tomado el término para referirse a espacios donde practicar las técnicas ágiles de desarrollo de software. El más común es el dojo de codificación, pero en esta oportunidad, le sumaron dos actividades bien interesantes, el dojo de arquitectura y el dojo de coaching.

## Dojo de arquitectura ##
Comenzamos el viernes con el dojo de arquitectura. No había escuchado de este tipo de actividad, y basicamente se trata de un ejercicio donde el facilitador trae varios retos de aplicaciones que se quieren construir, y los participantes forman equipos para discutir, en un tiempo limitado de 40 minutos, las posibles tecnologías y herramientas a utilizar para el desarrollo de dicho sistema. Al comenzar, se forman los equipos, en este caso formamos 2 equipos de 4 personas cada uno, y se elige al azar que reto le corresponde a cada equipo. Luego comenzo la diversión: para el caso de nuestro ejercicio, involucraba el desarrollo de una aplicación de subastas en tiempo real, con buscador, reputación de participantes, escablable a miles de subastas con cientos de participantes, y con video streaming del evento. 

La verdad el ejercicio era bastante complejo, y no pudimos completarlo, sin embargo la discusión de equipo, donde teníamos diversos perfiles y experiencias, nos llevo a una propuesta de arquitectura en la que mezclamos elementos de la nube con bases de datos orientadas a grafos, caché y otras tecnologías interesantes.

Finalmente ambos equipos tuvimos la oportunidad de exponer nuestra solución a todos los participantes, donde hubo preguntas y comentarios muy enriquecedores. Cerramos con una retrospectiva de la actividad.

## Dojo de codificación ##
El sábado temprano nos reencontramos con un grupo diferente para participar en el resto de las actividades. Comenzamos con el dojo de codificación, el cual a petición de los que estabamos presentes, lo realizamos bajo la modalidad de ATDD/TDD. Personalmente para mi fue un dojo BDD, pues las herramientas utilizadas (cucumber/rspec) me fueron familiares de mis investigaciones de BDD. 

El dojo fue dirigido por Carlos Peix y Luis Mulato, quienes tenían una laptop preparada para la actividad, y se realizó bajo la modalidad [Randori](http://codingdojo.org/cgi-bin/wiki.pl?RandoriKata), donde un participante iba codificando mientras otro servía de copiloto (practicando asi la técnica llamada programación en pares) y cada 7 minutos nos rotábamos. El kata seleccionado fue el [Kata tennis](http://codingdojo.org/cgi-bin/wiki.pl?KataTennis), y utilizamos ruby con sinatra para implementar la solución. 

Durante el ejercicio escribimos dos historias iniciales y un par de escenarios, y pudimos dar una vuelta por el ciclo completo de especificar desde el punto de vista del cliente y especificar una clase de la aplicación. Finalmente tambien tuvimos una retrospectiva y discutimos el ejercicio.

## Dojo de coaching ##
Seguidamente del dojo de codificación, comenzamos el de coaching. Este es bien interesante y busca aprender técnicas de como dar un buen coaching ágil. La mecánica fue la siguiente: planteamos entre los presentes algún problema o inquietud acerca de agilidad. Luego, se realizó una votación para decidir cuál era el tema más interesante. Se seleccionaron 2 temas, relacionados con la implantación de [Scrum](http://es.wikipedia.org/wiki/Scrum) que se han presentado en casos reales de los participantes. 

Luego se permite que algún voluntario haga el rol de coach. En este caso fui voluntario para dar coaching en el tema de manejar multiples equipos de Scrum con un solo Scrum Master, puesto que la empresa no justificaba que se contratara uno por equipo. Fue una experiencia interesante, la verdad como coach me fue bastante mal, pero aprendí mucho de la discusión final :), entre otras cosas que no debo tomarme el problema de manera personal e indagar más la causa raíz de lo que está sucediendo.

Luego de los tips y las impresiones de los presentes, nos llevamos excelentes recomendaciones en cuanto a coaching, sobre todo de la experiencia de Carlos como coach. 

## Futuros dojos ##

Este tipo de experiencias son muy constructivas, pero lo más valioso es poder mantenerse practicando constantemente mediante la participación en futuros dojos. El hecho de que sean un ambiente controlado, sin el estress del trabajo real, permite que uno sienta menos temor a cometer errores, y aprender de las experiencias de los otros participantes. Espero poder participar nuevamente en este tipo de sesiones, y a animarme a facilitar algunas sesiones a futuro. 

## Agradecimiento especial ##

Dejo un agradecimiento a Carlos Peix [@carlospeix](https://twitter.com/carlospeix) y a Luis Mulato [@luismulato](https://twitter.com/luismulato) quienes organizaron las sesiones y facilitaron las actividades, espero que compartamos nuevos eventos pronto!
