#!/bin/sh
# Auto-detects the default interface (works for wifi or ethernet).
IFACE=$(ip route 2>/dev/null | awk '/default/ {print $5; exit}')
[ -z "$IFACE" ] && { printf "-- KB/s"; exit; }

CACHE="/tmp/tmux_net_$IFACE"
RX_NEW=$(cat "/sys/class/net/$IFACE/statistics/rx_bytes" 2>/dev/null || echo 0)
NOW=$(date +%s)

if [ -f "$CACHE" ]; then
    read RX_OLD TIME_OLD < "$CACHE"
    DT=$((NOW - TIME_OLD))
    [ "$DT" -lt 1 ] && DT=1
    BPS=$(( (RX_NEW - RX_OLD) / DT ))
    if [ "$BPS" -gt 1048576 ]; then
        printf "%d MB/s" $((BPS / 1048576))
    elif [ "$BPS" -gt 1024 ]; then
        printf "%d KB/s" $((BPS / 1024))
    else
        printf "%d B/s" "$BPS"
    fi
else
    printf "-- KB/s"
fi

echo "$RX_NEW $NOW" > "$CACHE"
