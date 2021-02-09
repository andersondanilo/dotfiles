#!/bin/bash

VIDEO_PLAYERS=(google-chrome vlc zoho)
SOUND_STATUS_PATH=/proc/asound/card0/pcm0c/sub0/status
FOCUSED_WINDOW_ID=$(xprop -root _NET_ACTIVE_WINDOW | awk -F' ' '{print $NF}')

if cat $SOUND_STATUS_PATH | grep -q RUNNING; then
    SOUND_IS_RUNNING=1
else
    SOUND_IS_RUNNING=0
fi

if xprop -id ${FOCUSED_WINDOW_ID} _NET_WM_STATE | grep -q _NET_WM_STATE_FULLSCREEN; then
    FOCUSED_IS_FULLSCREEN=1
else
    FOCUSED_IS_FULLSCREEN=0
fi

FOCUSED_IS_VIDEO_PLAYER=0

for VIDEO_LAYER in ${VIDEO_PLAYERS[@]}; do
    if xprop -id ${FOCUSED_WINDOW_ID} | grep -qi $VIDEO_LAYER; then
        FOCUSED_IS_VIDEO_PLAYER=1
    fi
done

CAN_LOCK_SCREEN=1

if [ "$FOCUSED_IS_FULLSCREEN" -eq 1 ] && [ "$FOCUSED_IS_VIDEO_PLAYER" -eq 1 ]; then
    CAN_LOCK_SCREEN=0
fi

echo "Auto Lock Status ---------------------------------"
echo "Focused window id: $FOCUSED_WINDOW_ID"
echo "Sound is running: $SOUND_IS_RUNNING"
echo "Focused is fullscreen: $FOCUSED_IS_FULLSCREEN"
echo "Focused is video player: $FOCUSED_IS_VIDEO_PLAYER"
echo "Can lock screen: $CAN_LOCK_SCREEN"

if [ "$CAN_LOCK_SCREEN" -eq 1 ]; then
    CURRENT_BIN_DIR=$(dirname ${BASH_SOURCE[0]})
    echo "The screen will be locked"
    bash $CURRENT_BIN_DIR/lock.sh
else
    echo "The screen can not be locked"
fi

echo "--------------------------------------------------"
