#! /bin/zsh
FILE_NAME=$1
FPS=$2
WIDTH=$3
DATE=$(date "+%Y-%m-%d")
#OUTPUT_FILE_NAME=$DATE-$FILE_NAME.$WIDTH.FPS-$FPS.gif
OUTPUT_FILE_NAME=$DATE-$FILE_NAME.gif

ffmpeg -i $FILE_NAME -vf "fps=$FPS,scale=$WIDTH:-1:flags=lanczos" -c:v gif -f gif $OUTPUT_FILE_NAME
