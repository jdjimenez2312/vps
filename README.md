> [!IMPORTANT]
> Está en desarrollo y contiene fallos.

## Herramientas para VPS recién creados

Para que a la hora de crear un VPS no tengas que instalar todo a mano.

### Menú Principal

Hemos unificado todas las herramientas en un solo menú interactivo y con un diseño visual mejorado. Para ejecutar el menú principal, utiliza el siguiente comando:

#### Usando GitHub Pages (Recomendado)
Si tienes habilitado **GitHub Pages** en tu repositorio, la URL es mucho más amigable:

```sh
bash <(curl -s https://jdjimenez2312.github.io/vps/menu.sh)
```

> **Nota para habilitar GitHub Pages:** Ve a la pestaña **Settings** de tu repositorio en GitHub, luego en el menú lateral haz clic en **Pages**. Selecciona como fuente (Source) "Deploy from a branch", elige la rama `main` y la carpeta `/(root)`, y luego guarda. ¡Tu URL corta estará lista en un par de minutos!

#### Usando la URL Raw (Por defecto)
Si prefieres no usar GitHub Pages, utiliza el siguiente comando:

```sh
bash <(curl -s https://raw.githubusercontent.com/jdjimenez2312/vps/refs/heads/main/menu.sh)
```