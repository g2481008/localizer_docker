# localizer_docker
NDT Localizer using Velodyne VLP-16 for wheelchair group
# 使い方
##### Dockerfileのある階層で実行:
docker build -t velodyne_localizer:latest .

##### Docker Containerの作成
docker run -itd --ipc=host --gpus=all --env="NVIDIA_DRIVER_CAPABILITIES=all" --net host --privileged -e DISPLAY=unix${DISPLAY} -e NVIDIA_VISIBLE_DEVICES=0 -v /tmp/.X11-unix:/tmp/.X11-unix --name velodyneLocalizer velodyne_localizer:latest

## Host側PC　.bashrc に以下を追記:
xhost +local:

# 注意
初めてコンテナをAttachする場合、ネット環境に接続する
