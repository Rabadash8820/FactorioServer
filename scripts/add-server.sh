#!/bin/bash

# Make sure we are running as the factorio user (for creating files)
if [ ! $(whoami) = factorio ]; then
  echo "Please run this script as the 'factorio' user."
  exit 1
fi

# Make sure a server was provided that doesn't already exist
installPath=/opt/factorio
serversPath=$installPath/servers
if [ -z "$1" ]; then
  echo "Please provide a name for the new server."
  exit 1
fi
serverPath=$serversPath/$1
if [ -d "$serverPath" ]; then
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
mkdir "$serverPath/mods"

echo "Server added at $serverPath"
