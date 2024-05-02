# ros2-teleop

The ROS 2 teleop snap allows for teleoperating a robot
from either the keyboard, gamepad or leave it to the navigation stack.

## Build

This package is distributed as a snap and as such is meant to be built using snapcraft:

`SNAPCRAFT_ENABLE_EXPERIMENTAL_EXTENSIONS=1 snapcraft`

## Install

Using the locally built snap, first install it

`snap install --dangerous ros2-teleop-*.snap`

It can also be installed directly from the store:

`snap install ros2-teleop`

## Use

### Joystick

The snap offers the possibility to teleoperate the robot from a joystick.

Run the application with:

`snap start ros2-teleop.joy`

This app launches both the gamepad driver as well as the joy teleop node.

The snap offers parameters for the joystick application. Those are:

- joy-vel (string, default: 'joy_vel')
- joy-dev (string, default: 'dev/input/js0')
- joy-config (string, default: '')
- config-filepath (string, default: '')

At least one between `joy-config` and `config-filepath` parameters must be set for the application to run.
In case both `joy-config` and `config-filepath` are set, the configuration file will take precedence.

The upstream package offers some [default joystick configurations](https://github.com/ros2/teleop_twist_joy/tree/humble/config).
Those can be set up with the joy-config parameter as follows:

`snap set joy-config='ps3'`

In alternative, a custom configuration file can be used. The file can be provided
by means of a URL. In such case, the snap will download the file and
place it in `$SNAP_COMMON/config/joy_teleop.config.yaml`.
To configure the config-filepath to a URL:

`snap set ros2-teleop config-filepath="https://raw.githubusercontent.com/robot-repo/joy_teleop.config.yaml"`

Note: the URL must be reachable by the snap. When using a URL,
the configuration file will be downloaded everytime the joy app is launched.
Therefore a configuration update upstream will be applied with the application relaunch.

Otherwise to configure the config-filepath to a local configuration file:

`snap set ros2-teleop config-filepath="/var/snap/ros2-teleop/common/config/joy_teleop.config.yaml"`

The local configuration should be at a path accessible to the snap such as $SNAP_COMMON.

### Keyboard

The robot can also be teleoperated from a keyboard (e.g. SSH) by launching the application with,

`ros2-teleop.key`

### Mux

The snap makes use of a topic multiplexer to switch from one source to another.
Its input topic can be selected as,

`ros2-teleop.mux-select <topic>`

This is equivalent to:

`ros2 service call /mux/select topic_tools_interfaces/srv/MuxSelect "{topic: <topic>}"`

The topics names can also be configured with snap parameters:

 - cmd-vel (string, default: "cmd_vel")
 - nav-vel (string, default: "nav_vel")
 - web-vel (string, defautl: "web_vel")

Note that when launching the joy or key app, the appropriate topic is automatically selected.
