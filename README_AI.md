# Documentación para IA - Dotfiles & Sistema Sway

Este archivo centraliza el contexto del sistema para futuras sesiones de IA.

## Resumen del Proyecto
El sistema es una configuración de **Sway** en Ubuntu, gestionada como **dotfiles** usando `stow` y `git`.

- **Directorio Raíz**: `~/dotfiles`
- **Gestión**: GNU Stow
- **Control de Versiones**: Git local
- **Dependencias**: Ver [packages.txt](file:///home/alm/dotfiles/packages.txt)

## Componentes y Configuración
- **Window Manager**: Sway
- **Barra**: Waybar
- **Lanzador**: Wofi
- **Notificaciones**: Mako (alineado con ventanas: `margin=15,15`)
- **Terminal**: Alacritty (Tema claro `#f5f5f5`, fuente `DejaVu Sans Mono`)
- **Scripts**: Ubicados en `~/dotfiles/scripts/`

## Atajos de Teclado
| Atajo | Acción |
|-------|--------|
| `Super + Return` | Abrir terminal (Alacritty) |
| `Super + d` | Lanzador (Wofi) |
| `Super + b` | Brave Browser |
| `Super + w` | Whatsie |
| `Super + e` | Nautilus (archivos) |
| `Super + n` | nmtui (gestión de red) |
| `Super + t` | Selector de temas |
| `Super + Shift + w` | Selector de wallpaper |
| `Super + Shift + c` | Recargar Sway |
| `Super + Shift + q` | Cerrar ventana |
| `Super + f` | Pantalla completa |
| `Print` | Screenshot completo |
| `Shift + Print` | Screenshot área seleccionada |
| `Fn + F1/F2/F3` | Mute/Bajar/Subir volumen |

## Sistema de Temas
Cada componente (sway, wofi, waybar) tiene su propia carpeta de temas.

### Estructura
```
sway/themes/<tema>/colors       # Colores de sway
sway/themes/<tema>/wallpapers/  # Fondos de pantalla
wofi/themes/<tema>/colors.css   # Colores de wofi
waybar/themes/<tema>/colors.css # Colores de waybar
```

### Selector de Temas (`Super + t`)
El script `~/dotfiles/scripts/theme_selector.sh`:
1. Lista temas desde `~/.config/sway/themes/`
2. Actualiza colores de sway, wofi y waybar
3. Recarga sway automáticamente

## Sistema de Fondos de Pantalla (Wallpaper System)
Cada tema de Sway tiene su propio set de fondos.

### Uso
- **Atajo**: `Super+Shift+w` abre un selector de `wofi`.
- **Inicio**: Sway ejecuta `wallpaper_rotator.sh --init` para restaurar el último fondo del tema activo.
- **Persistencia**: Cache en `~/.cache/sway_wallpaper_<tema>`

## Control de Medios (Waybar MPRIS)
El widget de música en waybar responde a:
- **Click**: Play/Pause
- **Scroll Up**: Siguiente pista
- **Scroll Down**: Pista anterior

Usa debounce de 500ms para evitar acciones múltiples.

## Mantenimiento y Sincronización
- **`~/dotfiles/sync.sh`**: Script para hacer commit de todos los cambios locales.
- **Agregar nuevos archivos**: Colocarlos en la estructura de `~/dotfiles` y ejecutar `stow <nombre_carpeta>`.

## Notas para futuras IAs
1. **Preferencias Estéticas**: El usuario prefiere un diseño **monocromático minimalista** (tonos grises, negros y blancos).
2. **Fuentes**: Mantener siempre fuentes monospaced reales (ej. DejaVu Sans Mono, Ubuntu Mono) para Alacritty.
3. **Temas**: Al crear nuevos temas, incluir carpetas `wallpapers/` y configurar colores en sway, wofi y waybar.
4. **Links**: Mantener la estructura de enlaces simbólicos mediante `stow`.
5. **Rutas**: Usar `~/.config/` para configuraciones y `~/dotfiles/scripts/` para scripts.

