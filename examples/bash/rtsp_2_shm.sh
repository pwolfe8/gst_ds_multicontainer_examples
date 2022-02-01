#!/bin/bash

# input args
# RTSPURL=${1:-rtsp://testuser:testpwd@10.160.41.21/live}
RTSPURL=${1:-rtsp://admin:reolink@192.168.0.5//h264Preview_01_main}

SHM_SOCK_NAME=${2:-/tmp/shm/sock_69}
# SHM_FPS=${3:-20} 
SHM_FPS=${3:-25} 

# SHM_CAPS="video/x-raw,format=RGB,width=1920,height=1080,framerate=$SHM_FPS/1"
SHM_CAPS="video/x-raw,format=RGB,width=2560,height=1920,framerate=$SHM_FPS/1"

# setup debug directory for pipeline graphs
ENABLE_DEBUG_GRAPH=true
DEBUG_TEMP_DIR=./debug_graphs
rm -r $DEBUG_TEMP_DIR
mkdir -p $DEBUG_TEMP_DIR

# main gstreamer launch command
GST_DEBUG=1 GST_DEBUG_DUMP_DOT_DIR=$DEBUG_TEMP_DIR gst-launch-1.0 -e \
  rtspsrc location=$RTSPURL ! rtph264depay ! avdec_h264 \
  ! videoconvert ! $SHM_CAPS \
  ! shmsink socket-path=$SHM_SOCK_NAME max-lateness=1000000 sync=0 wait-for-connection=0
  # shm-size=100000000 \
  #  qos=true

# post pipeline dot file generation if enabled
if [ $ENABLE_DEBUG_GRAPH == true ]; then 
  dot2graph $DEBUG_TEMP_DIR pdf
else 
  rm -r $DEBUG_TEMP_DIR
fi