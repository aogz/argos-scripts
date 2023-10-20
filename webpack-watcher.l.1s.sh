#!/usr/bin/env bash
WEBPACK_STATUS_TITLE=$(~/scripts/wpn.sh short)
WEBPACK_ICON=$(curl -s "https://webpack.js.org/assets/icon-square-small-slack.png" | base64 -w 0)

echo "$WEBPACK_STATUS_TITLE | image='$WEBPACK_ICON' imageWidth=20"
echo "---"
if [ "$ARGOS_MENU_OPEN" == "true" ]; then
  echo "$(~/scripts/wpn.sh full) | font=monospace"
else
  echo "Loading..."
fi
