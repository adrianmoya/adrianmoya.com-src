+++
title = "Convirtiéndome en un ingeniero de IA"
date = "2026-05-12T11:45:00-05:00"
description = ""
keywords = ["ia"]
categories = ["IA"]
+++

Hace más de un año que no escribo una línea de código. Como ingeniero de backend, solía disfrutar de escribir código y enorgullecerme de lo impecable y bien diseñado que quedaba a mis ojos. Pero la IA llegó y como a muchos, me tomó por sorpresa. Y como muchos, la miré con escepticismo en nuestro primer encuentro. 

<!--more-->

Para ese momento estaba escribiendo un backend en Python. En mi carrera, el 90% de mis proyectos habían sido Java. Pero por mi cuenta y en algún que otro cliente, siempre tenía la oportunidad de probar lenguajes nuevos. Conocer un nuevo lenguaje después de mucho tiempo programando no era algo muy complicado, la típica búsqueda en Google que terminaba en Stack Overflow. Sin embargo, esta compañía tenía unas licencias de Copilot. 

Y entonces me encontré en la situación en la que comenzaba a escribir mi código, y Copilot me sugería TODO LO QUE NECESITABA ESCRIBIR a cambio de darle a la tecla tab. Y yo, bueno, entendió lo que estoy haciendo. Tab. Luego continuaba por su cuenta y escribía el resto que faltaba. Tab. Finalmente borraba, refactorizaba, escribía la prueba, tab tab tab. Y en ese momento me asusté. La máquina está leyendo mi mente. ¿Cómo supo todo lo que iba a escribir? 

En ese momento entendí que esto era un juego. Donde la gente se reía de que la máquina era muy torpe (la mayoría comenzamos probando con los modelos pequeños, incluso para el momento en que escribo este post), yo estaba experimentando el futuro. Después del susto vino la emoción. Mi día de trabajo se convirtió en tab tab tab.

Luego salió esta cosa de modo agente. Emocionado, me dije probemos. Gran decepción. Qué desastre. En ese momento me dije, ok, esto de la IA funciona para autocompletar, pero ni se te ocurra el modo agente, eso es un desastre. Creo que no nos entendimos y quedé asustado de que saltara por todos lados haciendo cambios sin mi permiso. 

Pasaron algunas semanas y las noticias que veía eran sorprendentes. Comencé a notar las apps de codificación en el terminal. Así que empecé a probarlas. Y estas ya eran el agente. Y hacían muchas cosas. Comencé un proyecto personal para aquel entonces en un stack completamente ajeno a mi zona de confort. Y comencé probando los modelos grandes gratuitos en OpenCode. Y la cosa se estaba poniendo seria. 

Entendí que esto era, o me metía de cabeza en el asunto o quedaría fuera de la industria. Iba más allá del hype, había que ponerle ingeniería al asunto, para hacerla funcionar correctamente. Aprendí de modelos, de alucinaciones, de tokens, de contexto. Y de repente, quitaron los modelos gratuitos de OpenCode. Adiós Grok code fast, te voy a extrañar! 

Y de repente, no tenía IA para programar. Esa sensación de vacío. Enseguida me compré mi suscripción de IA para la casa. Dado que tengo ya suscripciones con Google, era natural que me fuera con Gemini. Y me pasé a Gemini CLI. El más malo de los grandes. Del que nadie habla. Y en aquel entonces estaba comenzando y wow, qué malo era. Me dio grandes frustraciones, pero lo he visto crecer y ya nos estamos entendiendo. 

Del lado del trabajo, comencé un proyecto que se desplegaría en Google Cloud. Generalmente de la infra se encargaba el arquitecto. Siempre tengo charlas interesantes con los arquitectos, pero nunca he asumido el rol. Pero este proyecto requería desarrollar e implementar la infraestructura. Justo en el cloud que no tenía experiencia (mis proyectos pasados fueron en AWS o Azure). No había arquitecto que fuera a crear las cosas para mí. Solo estábamos Copilot y yo. Y ahí conocí a OPUS. 

Tuve grandes conversaciones con OPUS acerca de cómo hacer realidad el proyecto dentro de la nube. Cómo configurar las cuentas de servicio, darle los permisos, crear el pipeline, desplegar el proyecto, habilitar los secretos, las colas de mensajes, el API Gateway, desplegar las funciones. Conversábamos de buenas prácticas, hacíamos las cloud functions, refactorizamos, qué gran amigo OPUS. ¡Te quiero OPUS! Aquí hago una pausa porque esto ha sido un factor clave con este cambio. OPUS siempre ha sido abierto a preguntas. Y contesta con cortesía. Es el gurú amable, de esos que se perdieron entre egos y aires de superioridad. OPUS me ayudaba a entender todo el panorama, y a estar preparado para mi reunión y para presentar las propuestas al cliente. ¡Trabajo en equipo! 

En este período, seguía profundizando en los agentes. MCPs, habilidades, comandos, subagentes, memoria. Todas las semanas Claude saca algo nuevo, y unas semanas después va cayendo en el resto de los agentes. Aprendí a apoyarme en estos avances para que el agente hiciera cada día un mejor trabajo. Conocía el proyecto, sabía las reglas que establecimos, y en general codificaba y desplegaba a diario con buena calidad. 

Gemini, siendo el más creativo (por no decir loco) de todos, me llevó a estudiar para mi proyecto personal de Desarrollo Guiado por Especificaciones. Probé speck-kit, luego me pasé a conductor, voy por openspec. Y comencé a verme más y más envuelto en definiciones y en ser un Product Owner y en comunicar claramente los requerimientos que en codificar. Veía una coma de más, y le pedía al agente que la quitara. ¿Yo tocar ese código? Por favor...

Y entonces noté lo siguiente: En el trabajo, el equipo encargado de definir los requerimientos no pudo crear suficiente trabajo para mí. Cada reunión, había preocupación por qué iba a trabajar ese día, dado que estaba todo hecho y lo que se les ocurría, quedaba hecho para el día siguiente. La velocidad de codificar aumentó tanto y la calidad del entregable era tan buena que el cuello de botella se movió hacia los requerimientos. Me tocaba proponer cosas para hacer. 

En el pasado, tuve roles de coach de agilidad para varios equipos. Entiendo el proceso de desarrollo de punta a punta. Y estoy entendiendo que así como era imposible ser ágil si no se alineaban todos con las prácticas ágiles, no se puede explotar el potencial de la IA si no se aplica en todas las áreas del desarrollo. Esos tickets vacíos, que sólo tienen un título y que el desarrollador tiene que inventarse los detalles, no tienen cabida en un mundo con IA. Le toca a los Product Owners conversar con los agentes y pedirles que generen los tickets con un resumen claro de lo que se discutió. Luego el equipo de ingenieros de IA tomará esos tickets y le pedirá al agente que elabore un plan de implementación detallado y lo codifique. 

Y luego, llegamos al QA. Hace mucho tiempo que no tengo QAs en mis equipos. Nunca estuve de acuerdo con eliminar el rol en favor de una suite de pruebas automatizadas, pero ahora pienso, si no usas IA en el proceso de calidad, no vas a poder mantener el ritmo. Es necesario ahora involucrar agentes para la validación. Y luego agentes para el despliegue, y para el monitoreo, y...

Recientemente los proveedores de los modelos han comenzado a apretar con los precios. Esto también me ha llevado a aprender de manejo de costos. De eficiencia. Porque la ansiedad es real cuando se van acabando los requests del día. Ya no todo es OPUS, ahora ponemos a Sonnet (el modelo mediano) a codificar el plan. Y luego hay que corregirlo un poco. Y ahora comienzan a salir los modelos locales para los casos triviales. Porque no todo el mundo tiene un monstruo de máquina lleno de tarjetas gráficas en la sala. 

¿A dónde vamos a parar con esta locura? Ha sido una temporada de mucha presión, es un cambio dramático en cómo construimos software y apenas nos estamos adaptando. Ha tocado estudiar una nueva carrera en meses prácticamente. Cambia el modo de construcción, y cambia el modo en que consumimos ese software. Seguimos en esa transición, pero personalmente lo noto en mi día a día donde me cuestiono todo lo que hago. ¿Será que la IA puede ayudarme a hacer esto mejor? ¿Y si me instalo un agente personal? O mejor, que me lo instale Gemini, total ya ella controla mi homelab. Así me queda más tiempo para... para seguir estudiando de IA.

Quizá deba dedicarme a la música...
