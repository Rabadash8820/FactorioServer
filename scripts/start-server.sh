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
  echo "Please provide a name for the server to start."
  exit 1
fi
serverPath=$serversPath/$1
if [ ! -d "$serverPath" ]; then
  echo "There is no server at '$serverPath'"
  exit 1
fi

# Run the requested server
"$installPath/bin/x64/factorio" \
    --start-server "$serverPath/save.zip" \
    --server-settings "$serverPath/server-settings.json" \
    --server-banlist "$serverPath/server-banlist.json" \
    --server-whitelist "$serverPath/server-whitelist.json" \
    --server-id "$serverPath/server-id.json" \
    --config "$serverPath/config.ini" \
    --mod-directory "$serverPath/mods" \
    $@
