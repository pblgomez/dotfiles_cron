#!/usr/bin/env bash

DEVICE=($(xinput list | grep Touchpad | cut -f2 | cut -d "=" -f2))
echo $DEVICE

DEVICEPROP=$(xinput --list-props $DEVICE | grep "Tapping Enabled (" | awk -F '[()]' '{print $2}')
echo $DEVICEPROP

xinput set-prop $DEVICE $DEVICEPROP 1
