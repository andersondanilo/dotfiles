#!/usr/bin/python

from i3ipc import Connection
import time

i3 = Connection()


while True:
    current = i3.get_tree().find_focused()

    print("------------------------------------------")
    print("window width => %d" % current.window_rect.width)
    print("window height => %d" % current.window_rect.height)
    print("window class => %s" % current.window_class)
    print("window instance => %s" % current.window_instance)
    print("window role => %s" % current.window_role)
    print("window name => %s" % current.name)
    print("------------------------------------------")

    time.sleep(1)
