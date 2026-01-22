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

## Sistema de Fondos de Pantalla (Wallpaper System)
Cada tema de Sway tiene su propio set de fondos.

### Estructura
- **Fondos**: `sway/.config/sway/themes/<tema>/wallpapers/`
- **Script**: `~/dotfiles/scripts/wallpaper_rotator.sh`
- **Persistencia**: Cache en `~/.cache/sway_wallpaper_<tema>`

### Uso
- **Atajo**: `Super+Shift+w` abre un selector de `wofi`.
- **Inicio**: Sway ejecuta `wallpaper_rotator.sh --init` para restaurar el último fondo del tema activo.

## Mantenimiento y Sincronización
- **`~/dotfiles/sync.sh`**: Script para hacer commit de todos los cambios locales.
- **Agregar nuevos archivos**: Colocarlos en la estructura de `~/dotfiles` y ejecutar `stow <nombre_carpeta>`.

## Notas para futuras IAs
1. **Preferencias Estéticas**: El usuario prefiere un diseño **monocromático minimalista** (tonos grises, negros y blancos).
2. **Fuentes**: Mantener siempre fuentes monospaced reales (ej. DejaVu Sans Mono, Ubuntu Mono) para Alacritty.
3. **Temas**: Al crear nuevos temas, incluir siempre una carpeta `wallpapers/` y configurar los colores en `themes/<tema>/colors`.
4. **Links**: Mantener la estructura de enlaces simbólicos mediante `stow` para evitar que los cambios en `dotfiles` no se reflejen en `~/.config`.
