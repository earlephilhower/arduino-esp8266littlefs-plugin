#!/usr/bin/env bash

if [[ -z "$INSTALLDIR" ]]; then
    INSTALLDIR="$HOME/Documents/Arduino"
fi
echo "INSTALLDIR: $INSTALLDIR"

pde_path=`find /usr/local/bin/arduino-1.8.1/ -name pde.jar`
core_path=`find /usr/local/bin/arduino-1.8.1/ -name arduino-core.jar`
lib_path=`find /usr/local/bin/arduino-1.8.1/ -name commons-codec-1.7.jar`
if [[ -z "$core_path" || -z "$pde_path" ]]; then
    echo "Some java libraries have not been built yet (did you run ant build?)"
    return 1
fi
echo "pde_path: $pde_path"
echo "core_path: $core_path"
echo "lib_path: $lib_path"

set -e

mkdir -p bin
javac -target 1.8 -cp "$pde_path:$core_path:$lib_path" \
      -d bin src/ESP8266FastROMFS.java

pushd bin
mkdir -p $INSTALLDIR/tools
rm -rf $INSTALLDIR/tools/ESP8266FastROMFS
mkdir -p $INSTALLDIR/tools/ESP8266FastROMFS/tool
zip -r $INSTALLDIR/tools/ESP8266FastROMFS/tool/esp8266fastromfs.jar *
popd

dist=$PWD/dist
rev=$(git describe --tags)
mkdir -p $dist
pushd $INSTALLDIR/tools
rm -f $dist/*.zip
zip -r $dist/ESP8266FastROMFS-$rev.zip ESP8266FastROMFS/
popd
