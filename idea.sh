

IMAGE=${1:-kobikis/docker-intellij:latest}

DOCKER_GROUP_ID=$(cut -d: -f3 < <(getent group docker))
USER_ID=$(id -u $(whoami))
GROUP_ID=$(id -g $(whoami))
HOME_DIR=$(cut -d: -f6 < <(getent passwd ${USER_ID}))

# Need to give the container access to your windowing system
export DISPLAY=:0
xhost +

PULL="docker pull ${IMAGE}"
echo ${PULL}
${PULL}

docker run --detach=true -it --name IntelliJ --rm -v C:\Users\kkisos:/home/kobi -e DISPLAY=192.168.14.53:0.0 kobikis/intellij-local

CMD="docker run --detach=true \
                --group-add ${DOCKER_GROUP_ID} \
                --env HOME=${HOME} \
                --env DISPLAY=unix${DISPLAY} \
                --interactive \
                --name IntelliJ \
                --net "host" \
                --rm \
                --tty \
                --user=${USER_ID}:${GROUP_ID} \
                --volume $HOME:${HOME} \
                --volume /tmp/.X11-unix:/tmp/.X11-unix \
                --volume /var/run/docker.sock:/var/run/docker.sock \
                --workdir ${HOME} \
                ${IMAGE}"

echo $CMD
$CMD

echo $CMD
CONTAINER=$($CMD)

# Minor post-configuration
docker exec --user=root -it $CONTAINER groupadd -g $DOCKER_GROUP_ID docker

docker attach $CONTAINER
