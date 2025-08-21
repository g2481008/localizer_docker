# localizer_docker
NDT Localizer using Velodyne VLP-16 for wheelchair group

# 使い方
### Dockerfileがある階層で実行:
```
docker build -t velodyne_localizer:latest .
```

### Docker Containerの作成
```
docker run -itd --ipc=host --gpus=all --env="NVIDIA_DRIVER_CAPABILITIES=all" --net host --privileged -e DISPLAY=unix${DISPLAY} -e NVIDIA_VISIBLE_DEVICES=0 -v /tmp/.X11-unix:/tmp/.X11-unix --name velodyneLocalizer velodyne_localizer:latest
```

## Host側PC　.bashrc に以下を追記:
```
xhost +local:
```

# 実行可能コマンド一覧
|コマンド|実行内容|備考|
|:------|:-----|:---|
|`lidarslam`|NDT-SLAMを実行||
|`savemap`|MAP(.pcd)を保存|SLAM実行中に別terminalで実行する|
|`localization`|MAPを用いてNDT-Matchingを実行||
|`reload`|terminalの再読込||

# Paramter変更時の参照箇所
### SLAM
`~/ros2_ws/src/lidarslam_ros2/lidarslam/param/lidarslam.yaml`

https://github.com/rsasaki0109/lidarslam_ros2#params

### Matching
`~/ros2_ws/src/lidar_localization/param/localization.yaml`

https://github.com/g2481008/lidar_localization_ros2#params


# 使用時の注意
* 初めてコンテナをAttachする場合、ネット環境に接続する

