cd presunday
ffmpeg -i vid.mp4 -c:v libvpx -qmin 0 -qmax 50 -crf 5 -b:v 1M -c:a libvorbis vid.webm
ffprobe -v error -count_frames -select_streams v:0 -show_entries stream=nb_read_frames -of default=nokey=1:noprint_wrappers=1 vid.mp4
@pause
ffmpeg -i vid.mp4 vid.ogg
