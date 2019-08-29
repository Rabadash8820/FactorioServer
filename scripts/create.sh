#!/bin/bash

# Make sure we are running as the factorio user (for creating files)
if [ ! $(whoami) = factorio ]; then
  echo "Please run this script as the 'factorio' user."
  exit 1
fi

# Make sure a server was provided that already exists
installPath=/opt/factorio
serversPath=$installPath/servers
if [ -z "$1" ]; then
  echo "Please provide a name for the server for which to create a map."
  exit 1
fi
serverPath=$serversPath/$1
if [ ! -d "$serverPath" ]; then
  echo "There is no server at '$serverPath'"
  exit 1
fi

# Create a save for the requested server
"$installPath/bin/x64/factorio" \
    --create "$serverPath/save.zip" \
    --map-gen-settings "$serverPath/map-gen-settings.json" \
    --map-settings "$serverPath/map-settings.json" \
    --server-settings "$serverPath/server-settings.json" \
    --server-id "$serverPath/server-id.json" \
    --config "$serverPath/config.ini" \
    --mod-directory "$serverPath/mods" \
    $@

echo "Created save file $serverPath/save.zip"
