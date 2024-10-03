#!/usr/bin/env bash

echo -e "\0use-hot-keys\x1ftrue"
case $ROFI_RETV in
    10) 
        coproc ( rofi -show drun -theme ~/.config/rofi/style-2.rasi)
        exit 0 ;;
esac

echo $ROFI_RETV