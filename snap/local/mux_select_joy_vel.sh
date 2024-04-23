#!/usr/bin/bash -e

ROS2_TELEOP_JOY_VEL_TOPIC="$(snapctl get joy-vel)"

${SNAP}/usr/bin/mux_select.sh $ROS2_TELEOP_JOY_VEL_TOPIC
exec $@
