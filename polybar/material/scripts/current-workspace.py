#!/usr/bin/env python3

from i3ipc import Connection, Event
from sys import argv
import subprocess

i3 = Connection()
monitor = argv[1]

last_urgent_workspace_name = None

def refresh_urgent_state():
    global last_urgent_workspace_name
    workspaces = i3.get_workspaces()
    new_urgent_workspace_name = None

    for workspace in workspaces:
        if workspace.urgent:
            new_urgent_workspace_name = workspace.name

    if new_urgent_workspace_name != last_urgent_workspace_name:
        last_urgent_workspace_name = new_urgent_workspace_name
        on_new_urgent()

def on_new_urgent():
    if last_urgent_workspace_name is None:
        return


    if is_focused_workspace():
        subprocess.Popen(['notify-send', 'Urgent workspace', last_urgent_workspace_name])

def on_workspace_focus(self, e):
    display_current_workspace()

def display_current_workspace():
    refresh_urgent_state()
    visible_workspace = get_visible_workspace()

    if visible_workspace is not None:
        display_workspace(visible_workspace)

def get_visible_workspace():
    workspaces = i3.get_workspaces()

    for workspace in workspaces:
        if workspace.output == monitor and workspace.visible:
            return workspace

def is_focused_workspace():
    visible_workspace = get_visible_workspace()

    return visible_workspace is not None and visible_workspace.focused

def display_workspace(workspace):
    append = ""

    if last_urgent_workspace_name is not None:
        append = ' %{F#ad471c}(' + last_urgent_workspace_name + '*)%{F-}'

    print(" %s%s%s" % (workspace.name, " %{F#002b36}%{F-}" if workspace.focused else "", append), flush=True)

def on_window_urgent(self, e):
    display_current_workspace()

def on_workspace_urgent(self, e):
    display_current_workspace()

i3.on(Event.WORKSPACE_FOCUS, on_workspace_focus)
i3.on(Event.WORKSPACE_RENAME, on_workspace_focus)
i3.on(Event.WINDOW_URGENT, on_window_urgent)
i3.on(Event.WORKSPACE_URGENT, on_workspace_urgent)

display_current_workspace()

i3.main()

