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
ROS2_TELEOP_JOY_PARAM_PATH="$(snapctl get config-filepath)"

is_url() {
    local url="$1"
    if [[ "$url" =~ ^(https?|http):// ]]; then
        return 0
    fi
    return 1
}

if [ -z "${ROS2_TELEOP_JOY_CONFIG}" ] && [ -z "${ROS2_TELEOP_JOY_PARAM_PATH}" ]; then
    echo "No joystick configuration specified. Specify a joystick configuration to start the node."
    exit 1
fi

CONFIG_JOY_BASE_PATH=$SNAP_COMMON/config/joy_teleop.config.yaml

if is_url "${ROS2_TELEOP_JOY_PARAM_PATH}"; then
    SYSTEM_WGETRC=$SNAP/etc/wgetrc wget "${ROS2_TELEOP_JOY_PARAM_PATH}" -O "${CONFIG_JOY_BASE_PATH}"
    if [ $? -eq 0 ]; then
        echo "Config file downloaded successfully."
        ROS2_TELEOP_JOY_PARAM_PATH="${CONFIG_JOY_BASE_PATH}"
    else
        echo "Failed to download config file. Checking if a file already exists:"
        if [[ -n "${CONFIG_JOY_BASE_PATH}" ]]; then
          echo "Found previously downloaded config file"
          ROS2_TELEOP_JOY_PARAM_PATH="${CONFIG_JOY_BASE_PATH}"
        else
          echo "Previous configuration file not found, could not launch joystick"
          exit 1
        fi
    fi
fi

if [[ -z "${ROS2_TELEOP_JOY_PARAM_PATH}" ]]; then
  ROS2_TELEOP_JOY_CONFIG_ARG="joy_config:=${ROS2_TELEOP_JOY_CONFIG}"
else
  ROS2_TELEOP_JOY_CONFIG_ARG="config_filepath:=${ROS2_TELEOP_JOY_PARAM_PATH}"
fi

ros2 launch teleop_twist_joy teleop-launch.py \
  joy_vel:=${ROS2_TELEOP_JOY_VEL_TOPIC} \
  joy_dev:=${ROS2_TELEOP_JOY_DEV} \
  $ROS2_TELEOP_JOY_CONFIG_ARG
