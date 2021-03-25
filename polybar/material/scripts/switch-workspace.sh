#!/bin/bash

set -e

function main()
{
    OPTIONS=$(get_main_options)
    OPTION=$(rofi_ask_option "Switch to: " $OPTIONS)

    if [ -z "$OPTION" ]; then
	echo "Empty option"
	exit 1
    fi

    case $OPTION in
	"#move")
	    action_move
	    ;;
	"#rename")
	    action_rename
	    ;;
	"#find-app")
	    rofi -show window
	    ;;
	*)
	    action_switch $OPTION
	    ;;
    esac
}

function get_main_options()
{
    i3_get_workspaces
    echo "#move"
    echo "#rename"
    echo "#find-app"
}

function action_move
{
    OPTIONS=$(i3_get_workspaces)
    OPTION=$(rofi_ask_option "Move to: " $OPTIONS)

    if [ -z "$OPTION" ]; then
	echo "Empty option"
	exit 1
    fi

    i3-msg move container to workspace $OPTION
}

function action_rename
{
    NAME=$(rofi_ask_text "New name: ")

    if [ -z "$NAME" ]; then
	echo "Empty name"
	exit 1
    fi

    i3-msg rename workspace to $NAME
}

function action_switch
{
    i3-msg "[workspace=$1]" move workspace to output current
    i3-msg workspace "$1"
}

function i3_get_workspaces()
{
    i3-msg -t get_workspaces | tr ',' '\n' | grep "name" | sed 's/"name":"\(.*\)"/\1/g'
}

function rofi_ask_text()
{
    # rofi_ask_option($MESSAGE)
    rofi -dmenu -theme-str 'listview { enabled: false;}' -p $1
}

function rofi_ask_option()
{
    echo ${@:2} | rofi -dmenu -p $1 -sep " "
}

main
