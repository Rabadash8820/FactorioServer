#!/bin/bash

# Make sure we have root permissions (for creating files)
if [ ! $(whoami) = root ]; then
  echo "Please run this script with sudo privileges."
  exit 1
fi

# Make sure the requested server already exists
serversPath=${InstallPath}/servers
if [ -n $FACTORIO_SERVER_NAME ]; then
  serverPath=$serversPath/$FACTORIO_SERVER_NAME
elif [ -n $1 ]; then
  serverPath=$serversPath/$1
else
  echo "Please provide a filename for the new server, or set the FACTORIO_SERVER_NAME environment variable."
fi
if [ ! -e "$serverPath" ]; then
  echo "There is no server named '$serverPath'"
  exit 1
fi

# Run the requested server
"${InstallPath}/bin/x64/factorio" \
    --create "$serverPath/save.zip" \
    --map-gen-settings "$serverPath/map-gen-settings.json" \
    --map-settings "$serverPath/map-settings.json" \
    --server-settings "$serverPath/server-settings.json" \
    --server-id "$serverPath/server-id.json" \
    --config "$serverPath/config.ini" \
    --mod-directory "$serverPath/mods"

echo "Created save file $serverPath/save.zip"
