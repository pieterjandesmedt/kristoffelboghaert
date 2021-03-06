#!/bin/bash

maxSize=1400
imgDir=static/images
files=$(ls -p $imgDir/*.*)

mkdir -p $imgDir/lqip

printf "checking $(ls -1 $imgDir/*.* | wc -l) files. "

OIFS="$IFS"
IFS=$'\n'
OS=$(uname -s)
echo "Operating system is $OS"

for file in `find $imgDir/*.* -type f`
do

	original=$(basename -- "$file")
	echo -n .
	filename=${original%.*}

	lqip="$imgDir/lqip/$filename.svg"

	# exiftool -q "$file" -if '$ImageWidth > 1400 || $ImageHeight > 1400 and !print "$Directory/$Filename\0"' | xargs -0 -R 2 -I "%" echo "%"
	# xargs -0 -R 2 -I "%" convert -resize "$maxSizex$maxSize>" "%" "%"

	width=$(magick identify -format "%w" "$imgDir/$original")
	height=$(magick identify -format "%h" "$imgDir/$original")

	if (( $width > $maxSize )) || (( $height > $maxSize )); then
		printf "\n$original was $width x $height"
		magick convert "$imgDir/$original" -resize ${maxSize}x${maxSize}\> "$imgDir/$original"
		width2=$(magick identify -format "%w" "$imgDir/$original")
		height2=$(magick identify -format "%h" "$imgDir/$original")
		printf "... resized to $width2 x $height2"
	fi


	if test -f $lqip; then

		if [ $OS == "Darwin" ]; then
			a=$(stat -f "%Um" "$imgDir/$original")
			b=$(stat -f "%Um" "$lqip")
		else
			a=$(stat "$imgDir/$original" --printf %Y)
			b=$(stat "$lqip" --printf %Y)
		fi

		if [ $a \> $b ]; then
			printf "\n$original is younger than lqip/$filename.svg"
			sqip -i $file -n 100 -b 12 --silent -o "$lqip"
		fi
	else
		printf "\n$lqip doesn't exist"
		sqip -i $file -n 100 -b 12 --silent -o "$lqip"
		echo -n "... created"
	fi


done

IFS="$OIFS"
