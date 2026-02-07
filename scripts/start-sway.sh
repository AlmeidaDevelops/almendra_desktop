#!/bin/bash

# Import user environment variables
if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# Set XDG variables manually if not set
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

# Fix for Java applications
export _JAVA_AWT_WM_NONREPARENTING=1

# Fix for Mozilla/GTK applications
export MOZ_ENABLE_WAYLAND=1
export GDK_BACKEND=wayland

# Fix for Intel GPUs (prevents grey screen/cursor hang)
# export WLR_DRM_NO_MODIFIERS=1
export WLR_DRM_NO_ATOMIC=1

# Wait for DRM/GPU to stabilize (fixes race condition with display manager)
sleep 2

# Start Sway with debug logging
exec sway -d $@ > ~/sway.log 2>&1
