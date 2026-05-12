# adrianmoya.com source

Código fuente para mi blog http://adrianmoya.com. Para inicializar un equipo nuevo:

`$ git clone --recursive git@github.com:adrianmoya/adrianmoya.com-src.git`

Inicialmente, los submódulos de este repo se configuraron de la siguiente manera:

```
$ git submodule add -b master git@github.com:adrianmoya/adrianmoya.github.com.git public
$ git submodule add git@github.com:adrianmoya/hyde-x.git themes/hyde-x
$ git submodule init
$ git submodule update
```

## Workflow para publicar un nuevo post

Para crear y publicar contenido en este blog, sigue estos pasos:

1. **Crear el nuevo post**:
   Usa el comando `hugo new` para generar el esqueleto del post. Hugo lo creará en la carpeta `content/post/`.
   ```bash
   hugo new post/mi-nuevo-post.md
   ```

2. **Escribir el contenido**:
   Edita el archivo creado en `content/post/mi-nuevo-post.md`. Puedes previsualizar los cambios localmente ejecutando el servidor de desarrollo:
   ```bash
   hugo server -D
   ```
   El sitio estará disponible en `http://localhost:1313`. La opción `-D` permite ver los posts marcados como `draft: true`.

3. **Generar el sitio estático**:
   Una vez que el post esté listo (asegúrate de que `draft` sea `false` en el front-matter), genera el sitio ejecutando:
   ```bash
   hugo
   ```
   Esto actualizará la carpeta `docs/`, que es la que GitHub Pages utiliza para servir el sitio.

4. **Publicar en GitHub**:
   Añade los cambios, haz un commit y súbelos al repositorio:
   ```bash
   git add .
   git commit -m "Nuevo post: Título del Post"
   git push origin master
   ```

GitHub Pages detectará los cambios en la carpeta `docs/` y actualizará el sitio automáticamente.


