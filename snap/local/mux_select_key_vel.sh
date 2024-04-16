#!/usr/bin/bash -e

ROS2_TELEOP_KEY_VEL_TOPIC="$(snapctl get key-vel)"

${SNAP}/usr/bin/mux_select.sh $ROS2_TELEOP_KEY_VEL_TOPIC
exec $@
