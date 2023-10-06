# ROS2 Humble devcontainer stack with isaac-sim container

Run a ROS2 Humble devcontainer alongside an Isaac Sim container for simulation purpose on Linux

## Prerequisites
- Linux
- A beefy nvidia RTX GPU
- NVidia proprietary driver
- docker-ce
- compose v2
- docker-nvidia
- vscode devcontainer extension
- An access token to nvcr.io repository

## ROS2 devcontainer

The ROS2 workspace should contain an src folder with your ROS2 project sources

Once the source added to the project, download its depencies by running in a terminal from the project root folder :

```bash
sudo apt-get update && rosdep update && sudo rosdep install --from-paths src --ignore-src -y
```

Then source the default humble setup script and build yout project with colcon
```bash
source /opt/ros/humble/setup.sh
colcon build
```



## Isaac-sim container

### First launch

The first launch may take a while since RTX shaders needs to be compiled

### Enable ROS2 humble extension

By default ROS extension is enable you have to disable ROS extension then enable ROS2 Humble extension