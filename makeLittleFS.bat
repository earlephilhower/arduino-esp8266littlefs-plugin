ECHO off

REM set pde_path=C:/temp/JavaTrials/Arduino-master/build/windows/work/lib/pde.jar
REM set pde_path=C:/temp/JavaTrials/Arduino-master/app/pde.jar
set pde_path=D:/Program Files (x86)/Arduino/lib/pde.jar

REM set core_path=C:/temp/JavaTrials/Arduino-master/build/windows/work/lib/arduino-core.jar
REM set core_path=C:/temp/JavaTrials/Arduino-master/arduino-core/arduino-core.jar
set core_path=D:/Program Files (x86)/Arduino/lib/arduino-core.jar
REM set lib_path=C:/temp/JavaTrials/Arduino-master/build/windows/work/lib/commons-codec-1.7.jar
REM set lib_path=C:/temp/JavaTrials/Arduino-master/app/lib/commons-codec-1.7.jar
REM set lib_path=C:/temp/JavaTrials/Arduino-master/arduino-core/lib/commons-codec-1.7.jar
set lib_path=D:/Program Files (x86)/Arduino/lib/commons-codec-1.7.jar

echo pde_path: %pde_path%
echo core_path: %core_path%
echo lib_path: %lib_path%

mkdir bin

ECHO on
javac -target 1.8 -source 1.8 -cp "%pde_path%;%core_path%;%lib_path%" -d bin src/ESP8266LittleFS.java
ECHO off

mkdir tools
mkdir tools\ESP8266LittleFS
mkdir tools\ESP8266LittleFS\tool
erase tools\ESP8266LittleFS\tool\esp8266littlefs.jar

cd bin

jar cfveM ..\tools\ESP8266LittleFS\tool\esp8266littlefs.jar -C com\esp8266\mklittlefs ESP8266LittleFS.class ESP8266LittleFS$1.class ESP8266LittleFS$2.class

cd ..

exit /B

REM popd

REM dist=$PWD/dist
REM rev=$(git describe --tags)
REM mkdir -p $dist
REM pushd $INSTALLDIR/tools
REM rm -f $dist/*.zip
REM zip -r $dist/ESP8266LittleFS-$rev.zip ESP8266LittleFS/
REM popd
