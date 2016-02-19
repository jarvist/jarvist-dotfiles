#!/bin/sh

# I used to do this with gthumb... 
# rename files to something like
# "2016-01-02_13h43m-JarvistMooreFrost-S95-IMG_0462.JPG" with EXIF data from camera
for f
do
 prefix=`exif -t "Date and Time" -m "${f}"  | sed 's#:# #g' | awk '{printf "%s-%s-%s_%sh%sm",$1,$2,$3,$4,$5}' `
 
 echo "${f}" "  ---->  " "${prefix}-JarvistMooreFrost-S95-${f}"
 mv "${f}" "${prefix}-JarvistMooreFrost-S95-${f}"
done
