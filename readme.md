# Simple GeForce Experience Converter

Nvidia's Geforce Experience is a practical way of capturing your gaming highlights on PC. It also lets you generate files with two audio tracks, so you 
can maintain the game audio and your comms/voiceover separate. The downside is that if you want to quickly share it with your friends, it gets complicated.
Most of the time this means firing up a video editor, downmixing the audio and exporting it to a shareable size. Sometimes this can take long minutes and it
quickly becomes a chore. 

This simple shell script uses FFmpeg to execute all steps previously mentioned with just an execution, providing you with a simple and quick way of converting
your highlights and make it available to share with your group chats.

## Requeriments
- FFmpeg installed in your system
- The ability to run bash scripts (ie. git bash) or PowerShell scripts.

## Instructions
- Copy your original video files to the **BaseVideo** folder. 
- Launch Git Bash in the root folder and execute the converter script with the *sh converter-bash.sh* command.
- After the process is finishes, your converted videos will be available on the **Final** folder.

## How the script works
1. It saves the default IFS value and overrides it with a new value, so it can handle filenames with blank spaces.
2. The script fetches the files inside the BaseVideo folder, puts them on a list and initiates a for loop. 
3. The first FFmpeg step extracts both audios from the video file, storing them on the Temp folder.
4. Next, FFmpeg merges the two audio files to create a downmix.
5. Now, FFmpeg gets the original video file and substitues the audios for the downmix file created on the previous step, storing it on the Temp folder.
6. FFmpeg gets the downmixed video file and scales it down to 720p.
7. Lastly, the script cleans the Temp folders, leaving only the base video and the final exported version.

## Customization
The **codec**, **preset** and **scale** values are stored on variables at the beginning of the script, and can be customized. *Also, if you use .mkv files instead of*
*.mp4, change line 13 on the script with the acording file extension.*



