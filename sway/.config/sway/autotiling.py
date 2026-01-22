#!/usr/bin/env python3

import sys
from i3ipc import Connection, Event

def main():
    sway = Connection()

    def on_window_focus(sway, e):
        focused = sway.get_tree().find_focused()
        if focused and focused.type == 'con':
            # Horizontal split if width > height, Vertical otherwise
            if focused.rect.width > focused.rect.height:
                sway.command('split horizontal')
            else:
                sway.command('split vertical')

    sway.on(Event.WINDOW_FOCUS, on_window_focus)
    sway.on(Event.WINDOW_NEW, on_window_focus)
    sway.main()

if __name__ == "__main__":
    main()
