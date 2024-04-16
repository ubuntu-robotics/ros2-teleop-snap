#!/usr/bin/bash

ROS2_TELEOP_KEY_VEL_TOPIC="$(snapctl get key-vel)"

ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args --remap cmd_vel:=$ROS2_TELEOP_KEY_VEL_TOPIC
