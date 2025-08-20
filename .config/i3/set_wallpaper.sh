#!/bin/bash
for ws in $(i3-msg -t get_workspaces | jq -r '.[].name'); do
    feh --bg-scale ~/Pictures/background.jpg
done
