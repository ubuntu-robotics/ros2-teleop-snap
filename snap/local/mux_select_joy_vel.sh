#!/usr/bin/bash -e

${SNAP}/usr/bin/mux_select.sh "joy_vel"
exec $@
