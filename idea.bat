set IMAGE=kobikis/intellij-local:latest
set IP=192.168.14.53
set MOUNT_DIR=C:\Users\kkisos
set M2_DIR=C:\Users\kkisos\.m2
set GRADLE_DIR=C:\Users\kkisos\.gradle
set INTELLIJ_CONFIG_DIR=C:\Users\kkisos\.IntelliJIdea2018.3

set PULL="docker pull %IMAGE%"
echo %PULL%
%PULL%

set CMD=docker run --detach=true -it --name IntelliJ --rm -v %INTELLIJ_CONFIG_DIR%:/home/intellij/.IdeaIC2018.3/ -v %MOUNT_DIR%:/home/intellij -v %GRADLE_DIR%:/home/intellij/.gradle -v %M2_DIR%:/home/intellij/.m2 -e DISPLAY=%IP%:0.0 %IMAGE%

echo %CMD%
%CMD%