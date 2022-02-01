#!/bin/bash
# RTSPURL=${1:-rtsp://testuser:testpwd@10.160.41.21/live}

# omxh265enc available on jetson. not desktop

RTSPURL1=rtsp://172.22.0.4:8554/ds-test
RTSPURL2=rtsp://172.22.0.2:8555/ds-test2

# gst-launch-1.0 -e \
#   rtspsrc location=$RTSPURL1 ! decodebin ! omxh265enc ! h265parse ! matroskamux ! filesink location=cam1.mkv \
#   rtspsrc location=$RTSPURL2 ! decodebin ! omxh265enc ! h265parse ! matroskamux ! filesink location=cam2.mkv 

gst-launch-1.0 -e \
  rtspsrc location=$RTSPURL1 ! rtph264depay ! h264parse ! matroskamux ! filesink location=cam1_test.mkv \
  rtspsrc location=$RTSPURL2 ! rtph264depay ! h264parse ! matroskamux ! filesink location=cam2_test.mkv 
  
  

  
