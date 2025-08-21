FROM ubuntu:22.04

ENV TZ=Asia/Tokyo
ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y \
    curl \
    git \
    gnupg \
    nano \
    vim \
    openssh-server \
    sudo \
    tzdata \
    udev \
    zenity \
    software-properties-common && \
    ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    add-apt-repository universe && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" > /etc/apt/sources.list.d/ros2.list && \
    apt-get update && \
    apt install -y ros-humble-desktop ros-dev-tools && \
    echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc && \
    mkdir -p /root/ros2_ws/src && \
    cd /root/ros2_ws/src && \
    git clone --recursive -b humble https://github.com/rsasaki0109/lidarslam_ros2.git && \
    git clone -b humble https://github.com/g2481008/lidar_localization.git && \
    cd .. && \
    rosdep init || echo "rosdep already initialized" && \
    rosdep update && \
    source /opt/ros/humble/setup.bash && \
    rosdep install --from-paths src --ignore-src -r -y && \
    colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release && \
    echo "source /root/ros2_ws/install/setup.bash" >> ~/.bashrc && \
    echo "export FASTDDS_BUILTIN_TRANSPORTS=UDPv4" >> ~/.bashrc && \
    echo "export ROS_DOMAIN_ID=11" >> ~/.bashrc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY src/aliases.txt /root/.bash_aliases
