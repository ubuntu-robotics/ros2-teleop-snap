#!/usr/bin/bash -e

ROS2_TELEOP_KEY_VEL_TOPIC="$(snapctl get key-vel)"
ROS2_TELEOP_JOY_VEL_TOPIC="$(snapctl get joy-vel)"
ROS2_TELEOP_CMD_VEL_TOPIC="$(snapctl set cmd-vel)"
ROS2_TELEOP_NAV_VEL_TOPIC="$(snapctl get nav-vel)"
ROS2_TELEOP_WEB_VEL_TOPIC="$(snapctl get web-vel)"

ros2 run topic_tools mux "${ROS2_TELEOP_CMD_VEL_TOPIC}" "${ROS2_TELEOP_KEY_VEL_TOPIC}" "${ROS2_TELEOP_NAV_VEL_TOPIC}" "{$ROS2_TELEOP_JOY_VEL_TOPIC}" "{$ROS2_TELEOP_WEB_VEL_TOPIC}"
