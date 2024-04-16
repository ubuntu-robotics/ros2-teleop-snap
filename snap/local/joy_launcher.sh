#!/usr/bin/bash -e

# Make sure the necessary interfaces are plugged.
for PLUG in hardware-observe joystick; do
  if ! snapctl is-connected ${PLUG}; then
    logger -t ${SNAP_NAME} "Plug '${PLUG}' isn't connected, please run: snap connect $SNAP_NAME:${PLUG} before running the 'joy' app."
    echo "Plug '${PLUG}' isn't connected, please run: snap connect $SNAP_NAME:${PLUG} before running the 'joy' app."
    exit 1
  fi
done

ROS2_TELEOP_JOY_VEL_TOPIC="$(snapctl get joy-vel)"
ROS2_TELEOP_JOY_DEV="$(snapctl get joy-dev)"
ROS2_TELEOP_JOY_CONFIG="$(snapctl get joy-config)"
ROS2_TELEOP_JOY_PARAM_FILE="$(snapctl get config-filepath)"

if [[ -z "${ROS2_TELEOP_JOY_PARAM_FILE}" ]]; then
  ROS2_TELEOP_JOY_CONFIG_ARG="joy_config:=${ROS2_TELEOP_JOY_CONFIG}"
else
  ROS2_TELEOP_JOY_CONFIG_ARG="config_filepath:=${ROS2_TELEOP_JOY_PARAM_FILE}"
fi

ros2 launch teleop_twist_joy teleop-launch.py \
  joy_vel:=${ROS2_TELEOP_JOY_VEL_TOPIC} \
  joy_dev:=${ROS2_TELEOP_JOY_DEV} \
  $ROS2_TELEOP_JOY_CONFIG_ARG
