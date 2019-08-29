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
    --mod-directory "$serverPath/mods" \
    $@
if [ ! $? = 0 ]; then exit 1; fi

# Move the new config file into the server directory, and tweak it
cfgFile=$serverPath/config.ini
mv "$installPath/config/config.ini" "$cfgFile"
sed \
  -e "s|read-data=.*|read-data=$installPath/data|" \
  -e "s|write-data=.*|write-data=$serverPath/data|" \
  --in-place $cfgFile
if [ ! $? = 0 ]; then exit 1; fi

# Clean up other auto-generated files
mv "$installPath/achievements.dat" "$serverPath/achievements.dat"
if [ ! -d "$serverPath/data" ]; then mkdir "$serverPath/data"; fi
mv "$installPath/player-data.json" "$serverPath/data/player-data.json"
rm "$installPath/factorio-current.log"
rmdir "$installPath/temp"

echo "Created save file at $serverPath/save.zip"
