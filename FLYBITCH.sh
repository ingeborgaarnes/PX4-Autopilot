#!/bin/bash
# Script to set initial height, speed, and world for PX4 Gazebo simulation

# Default values for height (z in meters), speed (airspeed in m/s), and world
INITIAL_HEIGHT=${1:-1000}  # Default to 1000 meters
INITIAL_SPEED=${2:-20}     # Default to 20 m/s

# Set PX4 environment variables for model pose and world
export PX4_GZ_MODEL_POSE="0,0,${INITIAL_HEIGHT},0,0,0"

# Launch PX4 SITL with Gazebo and VTOL airframe
PX4_SYS_AUTOSTART=4004 make px4_sitl gz_skywalker_x8 &

# Wait for PX4 SITL to start
sleep 5

# Set the initial airspeed parameter dynamically
pxh_cmd="param set FW_AIRSPD_TRIM ${INITIAL_SPEED}"
echo $pxh_cmd | ncat -U /tmp/sitl_0_cmd.sock

echo "Simulation started with:"
echo "  Height=${INITIAL_HEIGHT} meters"
echo "  Airspeed=${INITIAL_SPEED} m/s"
