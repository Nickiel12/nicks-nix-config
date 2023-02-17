for i in *.jpg; do ffmpeg -i "$i"  "${i%.*}.png"; done  
for i in *.png; do ffmpeg -i "$i" -map_metadata -1  "${i%.*}.jpg"; done  