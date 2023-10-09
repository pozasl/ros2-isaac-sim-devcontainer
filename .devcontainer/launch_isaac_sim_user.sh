#!/bin/sh
# create persistent folders to bind
PF=~/docker/isaac-sim
ISAAC_USER=isaac-sim
ISAAC_USER_DIR=/home/$ISAAC_USER
mkdir -p $PF/cache/Kit $PF/.nvidia-omniverse $PF/documents $PF/.nv $PF/.cache $PF/.local
# Run isaac-sim GUI in isaac-sim container
docker run --user $ISAAC_USER --name isaac-sim --entrypoint bash -it --gpus all --rm --network=host \
-e "ACCEPT_EULA=Y" \
-e DISPLAY \
-e XAUTHORITY \
-e "NVIDIA_DRIVER_CAPABILITIES=all" \
-e "__NV_PRIME_RENDER_OFFLOAD=1" \
-e "__GLX_VENDOR_LIBRARY_NAME=nvidia" \
-e "FASTRTPS_DEFAULT_PROFILES_FILE=/isaac-sim/ros2_workspace/fastdds.xml" \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v $PWD:/tmp/project \
-v $PF/cache/Kit:/isaac-sim/kit/cache/Kit:rw \
-v $PF/.cache:$ISAAC_USER_DIR/.cache:rw \
-v $PF/.nv:$ISAAC_USER_DIR/.nv:rw \
-v $PF/.nvidia-omniverse:$ISAAC_USER_DIR/.nvidia-omniverse:rw \
-v $PF/.local:$ISAAC_USER_DIR/.local:rw \
-v $PF/documents:$ISAAC_USER_DIR/Documents:rw \
isaac-sim-user:2022.2.1 \
-c "unset LD_LIBRARY_PATH && ./runapp.sh"