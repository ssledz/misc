#!/bin/bash

VLC_PATH="/usr/bin/vlc"
INPUT="$1"
OUTPUT="$2"
VIDEO_CODEC="mp2v"
VIDEO_BITRATE="4096"
VIDEO_FRAMERATE="25"
AUDIO_CODEC="mpga"
AUDIO_BITRATE="192"
AUDIO_SAMPLERATE="44100"
AUDIO_CHANNELS="2"
FORMAT="ps"
SUBTITLE_LANGUAGE="pl"

exec "${VLC_PATH}" "${INPUT}" -I dummy --sout "#transcode{venc=ffmpeg,vcodec=${VIDEO_CODEC},\
vb=${VIDEO_BITRATE},fps=${VIDEO_FRAMERATE},aenc=ffmpeg,acodec=${AUDIO_CODEC},ab=${AUDIO_BITRATE},\
samplerate=${AUDIO_SAMPLERATE},channels=${AUDIO_CHANNELS},soverlay,audio-sync,threads=2}:\
standard{mux=${FORMAT},access=file,dst=${OUTPUT}}" \
-vvv \
--sub-type=auto \
--freetype-fontsize=25 \
--freetype-color=16776960 \
--no-subsdec-formatted \
--subsdec-align=0 vlc:quit 2>&1 
