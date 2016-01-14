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

