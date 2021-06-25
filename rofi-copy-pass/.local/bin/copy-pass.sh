#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source $SCRIPT_DIR/copy-pass/shared.sh

PROMPT_MESSAGE="Copy pass:"

OPTIONS=$(get_pass_options)
OPTION=$(rofi_ask_option $OPTIONS)

if [ ! -z "$OPTION" ]; then
    echo "chose option: $OPTION"
    pass -c $OPTION
fi
