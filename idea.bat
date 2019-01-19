

set IMAGE=kobikis/docker-intellij:latest
set IP=192.168.14.53
set MOUNT_DIR=C:\Users\kkisos

# Need to give the container access to your windowing system
export DISPLAY=:0

PULL="docker pull ${IMAGE}"
echo ${PULL}
${PULL}

CMD="docker run --detach=true \
                -it \
                --name IntelliJ \
                --rm \
                -v %MOUNT_DIR%:/home/kobi \
                -e DISPLAY=%IP%:0.0 \
                %IMAGE%

echo $CMD
$CMD
