#!/usr/bin/env bash

## Shamelessly yoinked from reddit user Sliiated https://www.reddit.com/r/waybar/comments/1p5r29i/first_analog_clock_in_waybar/ (user fshaxe on github) and ported to dash

H=$(date +%H)
M=$(date +%M)
S=$(date +%S)

# Strip leading zeros safely without bashisms
h=$(echo "$H" | sed 's/^0*//'); [ -z "$h" ] && h=0
m=$(echo "$M" | sed 's/^0*//'); [ -z "$m" ] && m=0

minute_of_12h=$(( (h % 12) * 60 + m ))
codepoint=$((57344 + minute_of_12h)) # 0xE000 in decimal is 57344

# POSIX compliant way to convert decimal to 4-digit hex
hex=$(printf '%04X' "$codepoint")

# Use standard \u for 4-digit unicode points
glyph=$(printf "\\u$hex")

tooltip="${H}:${M}:${S}"
printf '{"text":"%s","tooltip":"%s"}\n' "$glyph" "$tooltip"

