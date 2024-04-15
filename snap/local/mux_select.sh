#!/usr/bin/bash -e

if [[ $# < 1 ]]; then
  echo "usage: ./mux_select <topic>"
fi

# Add leading slash if missing
TOPIC=$(echo $1 | sed '/^\//! s/^/\//')

ros2 service call /mux/select topic_tools_interfaces/srv/MuxSelect "{topic: ${TOPIC}}"
