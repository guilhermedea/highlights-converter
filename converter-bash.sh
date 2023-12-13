#!/bin/bash

#Sets the IFS value to handle the files with blank spaces on their names
OIFS="$IFS" #Saves the default value for backup
IFS=$'\n'

#Presets
codec=libx264
preset=fast
scale=1280:720

#Fetches the files on the BaseVideo folder and puts them on a list
LIST=$(find ./BaseVideo -type f -name "*.mp4" -printf "%f\n")

for i in $LIST; do
    INPUT=$i
    echo $INPUT

    #Extract audio files from the video
    ffmpeg -hide_banner -i ./BaseVideo/"${INPUT}" -map 0:a:0 -acodec copy ./Temp/Audio/audio1-"${INPUT}"
    ffmpeg -hide_banner -i ./BaseVideo/"${INPUT}" -map 0:a:1 -acodec copy ./Temp/Audio/audio2-"${INPUT}"

    #Merge the audio files into one
    ffmpeg -hide_banner -i ./Temp/Audio/audio1-"${INPUT}" -i ./Temp/Audio/audio2-"${INPUT}" -filter_complex amix=inputs=2:duration=first:dropout_transition=0 ./Temp/Audio/audiodownmix-"${INPUT}"

    #Merge video with new audio
    ffmpeg -hide_banner -i ./BaseVideo/"${INPUT}" -i ./Temp/Audio/audiodownmix-"${INPUT}" -map 0:v -map 1:a -c:v copy -shortest ./Temp/Video/videodownmix-"${INPUT}"

    #Export final video to shareable size
    ffmpeg -hide_banner -i ./Temp/Video/videodownmix-"${INPUT}" -c:v $codec -crf 28 -preset $preset -vf scale=$scale ./Final/VideoFinal-"${INPUT}"

    #Cleans the temp folder
    rm ./Temp/Audio/audio1-"${INPUT}"
    rm ./Temp/Audio/audio2-"${INPUT}"
    rm ./Temp/Audio/audiodownmix-"${INPUT}"
    rm ./Temp/Video/videodownmix-"${INPUT}"

    #Script Ending Message
    echo "Done!"

done
