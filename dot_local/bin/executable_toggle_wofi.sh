#!/usr/bin/env bash

if pgrep -x "wofi" > /dev/null; then
    kill -9 $(pgrep -x "wofi");
else
    wofi --show drun
fi
