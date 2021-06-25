#!/bin/bash

PASS_STORAGE_PATH="$HOME/.password-store/"
PROMPT_MESSAGE=""

function rofi_ask_option()
{
    echo ${@:1} | rofi -dmenu -matching fuzzy -sort -sorting-method fzf -theme-str 'configuration { show-icons: false; } listview { lines: 3; columns: 1; }' -p "$PROMPT_MESSAGE" -sep " "
}

function get_pass_options()
{
    find $PASS_STORAGE_PATH -type f -iname "*.gpg" | sed 's/.gpg//' | sed "s:$PASS_STORAGE_PATH::"
}
