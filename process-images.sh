#!/bin/bash

maxSize=1200
imgDir=static/images
files=$(ls -p $imgDir/*.*)

echo checking $(ls -1 $imgDir/*.* | wc -l) files

for f in $files
do

	original=$(basename -- "$f")
	filename=${original%.*}

	lqip=$imgDir/lqip/$filename.svg

	exiftool -q $imgDir/$original -if '$ImageWidth > 1200 || $ImageHeight > 1200 and !print "$Directory/$Filename\0"' |  xargs -0 -R 2 -I "%" convert -resize "$maxSizex$maxSize>" "%" "%"

	if test -f $lqip; then

		a=$(stat -f "%Um" $imgDir/$original)
		b=$(stat -f "%Um" $lqip)

		if [ $a \> $b ]; then
			echo "$original is younger than lqip/$filename.svg"
			sqip -i $f -n 100 -b 12 --silent -o  $lqip
		fi
	else
		echo "$lqip doesn't exist"
		sqip -i $f -n 100 -b 12 --silent -o $lqip
	fi


done
