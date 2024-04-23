#!/bin/sh -e

# Make sure the folder exists
mkdir -p $SNAP_COMMON/config

cp $SNAP/usr/share/ros2-teleop/config/*.yaml $SNAP_COMMON/config/.
