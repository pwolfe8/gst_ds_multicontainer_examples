#!/bin/bash
# RTSPURL=${1:-rtsp://testuser:testpwd@10.160.41.21/live}

# omxh265enc available on jetson. not desktop

RTSPURL1=rtsp://172.22.0.4:8554/ds-test
RTSPURL2=rtsp://172.22.0.2:8555/ds-test2
RTSPURL3=rtsp://admin:reolink@192.168.0.11//h264Preview_01_main


# gst-launch-1.0 -e \
#   rtspsrc location=$RTSPURL1 ! decodebin ! omxh265enc ! h265parse ! matroskamux ! filesink location=cam1.mkv \
#   rtspsrc location=$RTSPURL2 ! decodebin ! omxh265enc ! h265parse ! matroskamux ! filesink location=cam2.mkv 

# gst-launch-1.0 -e \
#   rtspsrc location=$RTSPURL1 ! rtph264depay ! h264parse ! matroskamux ! filesink location=cam1_test.mkv \
#   rtspsrc location=$RTSPURL2 ! rtph264depay ! h264parse ! matroskamux ! filesink location=cam2_test.mkv 
  
# setup debug directory for pipeline graphs
ENABLE_DEBUG_GRAPH=true
DEBUG_TEMP_DIR=./debug_graphs_record
rm -r $DEBUG_TEMP_DIR
mkdir -p $DEBUG_TEMP_DIR

DISPLAY_LOCAL="nvegltransform ! nveglglessink"


# GST_DEBUG=1 GST_DEBUG_DUMP_DOT_DIR=$DEBUG_TEMP_DIR gst-launch-1.0 -e \
#   rtspsrc location=$RTSPURL3 ! rtph264depay ! h264parse ! matroskamux ! filesink location=cam3_test.mkv 
GST_DEBUG=1 GST_DEBUG_DUMP_DOT_DIR=$DEBUG_TEMP_DIR gst-launch-1.0 -e \
    rtspsrc location=$RTSPURL3 ! rtph264depay ! h264parse ! videoconvert ! nveglglessink
#   rtspsrc location=$RTSPURL3 ! rtph264depay ! h264parse ! matroskamux ! filesink location=cam3_test.mkv 
  
  
# post pipeline dot file generation if enabled
if [ $ENABLE_DEBUG_GRAPH == true ]; then 
  dot2graph $DEBUG_TEMP_DIR pdf
else 
  rm -r $DEBUG_TEMP_DIR
fi


# echo ""
# echo "________________________________________"
# # echo "displaying with input caps: "
# # echo "    $INPUT_CAPS"
# echo ""
# echo hit ctrl+c to stop
# echo "________________________________________"
# echo ""

# # gstreamer launch command
# gst-launch-1.0 -e \
# 	nvarguscamerasrc 
# 	! $INPUT_CAPS_2464p \
#   ! $DISPLAY_LOCAL
