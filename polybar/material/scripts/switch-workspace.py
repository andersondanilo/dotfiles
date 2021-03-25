#!/usr/bin/env python3

from i3ipc import Connection
import re
import subprocess
import rofi_menu
from rofi_menu.constants import OP_EXIT, OP_OUTPUT
from rofi_menu.menu import Item, Operation

i3 = Connection()
workspaces = i3.get_workspaces()
i3_tree = i3.get_tree()

def get_workspace_icon(workspace_name):
    for workspace in i3_tree:
        if workspace.name == workspace_name:
            for window in workspace.descendants():
                if window.window is not None:
                    return '/home/anderson/Workspace/personal/dotfiles/polybar/material/scripts/switch-icon.png'
                    # result = subprocess.run(['xprop', '-id', str(window.window), 'WM_ICON_NAME'], capture_output=True)

                    # if result.stdout is not None and len(result.stdout) > 0:
                    #     match = re.search('WM_ICON_NAME\(STRING\) = "(.+?)"', str(result.stdout))
                    #     if match is not None:
                    #         wm_class = match[1]
                    #         return wm_class

                    # result = subprocess.run(['xprop', '-id', str(window.window), 'WM_CLASS'], capture_output=True)

                    # if result.stdout is not None and len(result.stdout) > 0:
                    #     match = re.search('WM_CLASS\(STRING\) = "(.+?)"', str(result.stdout))
                    #     if match is not None:
                    #         wm_class = match[1]
                    #         return wm_class
                    # 


class MainMenu(rofi_menu.Menu):
    allow_user_input = True
    prompt = "Switch to: "

    async def generate_menu_items(self, meta):
        items = []

        for workspace in workspaces:
            if not workspace.focused:
                items.append(SwitchWorkspaceItem(workspace.name))

        items.append(rofi_menu.NestedMenu("Move", MoveMenu()))
        items.append(rofi_menu.NestedMenu("Rename", RenameMenu()))

        return items

    async def on_user_input(self, meta):
        i3_switch_workspace(meta.user_input)
        return rofi_menu.Operation(rofi_menu.OP_EXIT)

class MoveMenu(rofi_menu.Menu):
    allow_user_input = True
    prompt = "Move to: "

    async def generate_menu_items(self, meta):
        items = []

        for workspace in workspaces:
            if not workspace.focused:
                items.append(MoveToWorkspaceItem(workspace.name))

        if len(items) == 0:
            items.append(rofi_menu.Item(" "))

        return items

    async def on_user_input(self, meta):
        i3_move_too_workspace(meta.user_input)
        return rofi_menu.Operation(rofi_menu.OP_EXIT)

class RenameMenu(rofi_menu.Menu):
    prompt = "Rename to: "
    items = [rofi_menu.Item(" ")]
    allow_user_input = True

    async def on_user_input(self, meta):
        i3.command(f"rename workspace to {meta.user_input}")
        return rofi_menu.Operation(rofi_menu.OP_EXIT)

class BaseWorkspaceItem(rofi_menu.menu.Item):
    def __init__(self, text=None, **kwargs):
        self.icon = get_workspace_icon(text)
        super().__init__(text, **kwargs)

    async def render(self, meta):
        return f"<big><b>{self.text}</b></big>"

class SwitchWorkspaceItem(BaseWorkspaceItem):
    async def on_select(self, meta):
        i3_switch_workspace(self.text)
        return Operation(OP_EXIT)

class MoveToWorkspaceItem(BaseWorkspaceItem):
    async def on_select(self, meta):
        i3_move_too_workspace(self.text)
        return Operation(OP_EXIT)

def i3_switch_workspace(workspace_name):
    for con in i3.get_tree():
        if con.name == workspace_name:
            con.command(f"move workspace to output current")

    i3.command(f"workspace \"{workspace_name}\"")

def i3_move_too_workspace(workspace_name):
    i3.command(f"move container to workspace {workspace_name}")
    i3.command(f"workspace \"{workspace_name}\"")

if __name__ == "__main__":
    rofi_menu.run(MainMenu(), rofi_version="1.6")  # change to 1.5 if you use older rofi version
