PERF='{"text": "", "tooltip": "KA ZOW", "class": "performance"}'
DEF='{"text": "", "tooltip": "Balanced", "class": "balance"}'
BAT='{"text": "", "tooltip": "Please dont kill me", "class": "battery"}'
if tuned-adm active | grep -q "accelerator-performance"; then echo $PERF; else if tuned-adm active | grep -q "balanced"; then echo $DEF; else echo $BAT; fi; fi
