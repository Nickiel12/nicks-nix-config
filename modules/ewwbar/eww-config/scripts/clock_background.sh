#!/usr/bin/env bash 


moonstate=$(gcal --resource-file=$HOME/.config/eww/scripts/moontime | awk '{print $4}')

sunstate=$(gcal --resource-file=$HOME/.config/eww/scripts/suntime | awk '{print $4}')

moonrise=$(echo $moonstate | awk '{print $1}')
moonset=$(echo $moonstate | awk '{print $2}')
moonphase=$(echo $moonstate | awk '{print $3}')

sunrise=$(echo $sunstate | awk '{print $1}')
sunset=$(echo $sunstate | awk '{print $2}')



echo "{ \"has_color\": false, \"is_sun\": true, \"gradient_angle\": 45 }"
