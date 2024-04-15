#!/usr/bin/bash -e

${SNAP}/usr/bin/mux_select.sh "key_vel"
exec $@
