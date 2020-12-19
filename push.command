#! /bin/bash

# Set AWS environment variables
export $(grep -v '^#' .env | xargs)

# Create commit message
NOW=$(date +"%Y-%m-%d (%A) %H:%M:%S")
MESSAGE="Update '$NOW'"

# Set pretty colors
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NOCOLOR="\033[0m"

# Process images (resize and creat LQIP)
echo -e "${YELLOW}\nProcessing images...${NOCOLOR}"
./process-images.sh

# Push git repository
cd "`dirname "$0"`"
echo -e "${YELLOW}\nPushing site...${NOCOLOR}"
git add .
git commit -a -m "$MESSAGE"
git push

# Sync images with AWS
echo -e "${YELLOW}\nPushing images...${NOCOLOR}"
aws s3 sync static/images/ s3://kristoffelboghaert --exclude "lqip/*.*" --exclude ".*"

# Done
echo -e "${GREEN}\nDone. The site will be online in a minute or so.${NOCOLOR}"
echo -e "You can close this window.\n"
