#!/usr/bin/python

from i3ipc import Connection
import sys

i3 = Connection()

current = i3.get_tree().find_focused()
window_rect = current.window_rect
workspace = current.workspace()

print("workspace width => %d" % workspace.rect.width)
print("workspace height => %d" % workspace.rect.height)

print("window width => %d" % window_rect.width)
print("window height => %d" % window_rect.height)

def change_size(direction: str, target_size_str: str):

    if direction == 'width':
        current_screen_size = workspace.rect.width
        current_window_size = window_rect.width
    else:
        current_screen_size = workspace.rect.height
        current_window_size = window_rect.height

    if '%' in target_size_str:
        target_size = int(current_screen_size * (float(target_size_str.replace('%', '')) / 100))
    else:
        target_size = int(target_size_str)

    print("target %s => %d" % (direction, target_size))

    diff_size = int(target_size - current_window_size)

    print("diff %s => %d" % (direction, diff_size))


    if diff_size != 0:
        resize_command = "resize %s %s %d or %d ppt" % ('grow' if diff_size > 0 else 'shrink', direction, abs(diff_size), abs(diff_size))
        print("executing %s" % resize_command)
        i3.command(resize_command)
    else:
        print("no resize necessary")

if sys.argv[1] is not None:
    change_size('width', sys.argv[1])

if len(sys.argv) > 2 and sys.argv[2] is not None:
    change_size('height', sys.argv[2])


i3.command("move position center")
