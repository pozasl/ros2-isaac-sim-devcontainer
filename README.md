# ROS2 Humble devcontainer stack with isaac-sim container

Run a ROS2 Humble devcontainer alongside an Isaac Sim container for simulation purpose on Linux

## Prerequisites
- A [beefy PC](https://docs.omniverse.nvidia.com/isaacsim/latest/requirements.html) with NVidia RTX GPU
- NVIDIA proprietary driver (Version 525.60.11 or higher)
- docker-ce (Version 19.3 or higher)
- docker-compose
- [NVIDIA container Toolkit](https://github.com/NVIDIA/nvidia-docker)
- [NGC API key](https://docs.nvidia.com/ngc/ngc-overview/index.html#generating-api-key) to access nvcr.io repository
- VSCode devcontainer extension

## Isaac-sim container

### Build Isaac-sim container with non-root user

Default Isaac-sim container run as root wich can lead to mounted folder access issues

To build a custom container with a non root user, use the Dockerfile.issac file:

```bash
cd .devcontainer
docker build --no-cache -f Dockerfile.isaac -t isaac-sim-user:2022.2.1 .
```

### First launch

The launch_isaac_sim_user.sh script will setup folder persistance in the ~/docker/isaac-sim folder on your host workstation

```bash
sh .devcontainer/launch_isaac_sim_user.sh
```

The first launch may take a while since RTX shaders needs to be compiled

You'll see a bunch of errors about missing files, those files will be created for the next launch.

Once Isaac-Sim is started and its RTX shader compiled, you can close it and proceed with the devcontainer stack.

Hit Shit + Ctrl + P to open VSCode palet and type:

Dev containers: Rebuild and Reopen in container.

## ROS2 devcontainer

The ROS2 workspace should contain a src folder with your ROS2 project sources

Once the sources are added to the project, download its depencies by running in a terminal from the project root folder in the ROS2 container:

```bash
sudo apt-get update && rosdep update && sudo rosdep install --from-paths src --ignore-src -y
```

Then source the default humble setup script and build yout project with colcon
```bash
source /opt/ros/humble/setup.sh
colcon build
```
