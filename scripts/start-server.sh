#!/bin/bash

# Make sure we have root permissions (so Factorio can create files?)
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
    --start-server "$serverPath/save.zip" \
    --server-settings "$serverPath/server-settings.json" \
    --server-banlist "$serverPath/server-banlist.json" \
    --server-whitelist "$serverPath/server-whitelist.json" \
    --server-id "$serverPath/server-id.json" \
    --config "$serverPath/config.ini" \
    --mod-directory "$serverPath/mods"
