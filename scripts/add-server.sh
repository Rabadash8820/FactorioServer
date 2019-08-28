#!/bin/bash

# Make sure we have root permissions (for creating files)
if [ ! $(whoami) = root ]; then
  echo "Please run this script with sudo privileges."
  exit 1
fi

# Make sure the requested server doesn't already exist
serversPath=${InstallPath}/servers
if [ -n $FACTORIO_SERVER_NAME ]; then
  serverPath=$serversPath/$FACTORIO_SERVER_NAME
elif [ -n $1 ]; then
  serverPath=$serversPath/$1
else
  echo "Please provide a filename for the new server, or set the FACTORIO_SERVER_NAME environment variable."
fi
if [ -e "$serverPath" ]; then
  echo "There is already a server at '$serverPath'"
  exit 1
fi

# Copy example files for the new server
# `-rp` options same as `--recursive --preserve=mode,ownership,timestamps`
mkdir -p "$serverPath"
cp -rp "$installPath/data/map-gen-settings.example.json" "$serverPath/map-gen-settings.json"
cp -rp "$installPath/data/map-settings.example.json" "$serverPath/map-settings.json"
cp -rp "$installPath/data/server-settings.example.json" "$serverPath/server-settings.json"
cp -rp "$installPath/data/server-whitelist.example.json" "$serverPath/server-whitelist.json"
cp -rp "$installPath/data/server-whitelist.example.json" "$serverPath/server-banlist.json"  # Copy whitelist b/c banlist is in same format
cp -rp "$installPath/config/config.ini" "$serverPath/config.ini"
cp -rp "$installPath/server-id.json" "$serverPath/server-id.json"
mkdir "$serverPath/mods"
cp -rp "$installPath/mods/mod-list.json" "$serverPath/mods/mod-list.json"
chown -R factorio:factorio "$serversPath"

echo "Server added at $serverPath"
