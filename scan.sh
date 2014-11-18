#!/bin/bash

# Used to parse bower.json and pass each url to burp via burpstaticscan
# Protip make sure you start your scan issue logger first

BURPSCAN="burpstaticscan"
if [ -e "./watermark" ]; then
    WATERMARK=`cat watermark`
else
    WATERMARK='git://github.com/10digit/geo.git'
fi
FOUNDWATERMARK=false
COUNT=0
MAX=0

for URL in `jq .[].url bower.json|sed s/\"//g`; do

    ROOT=`echo ${URL}|awk -F '/' '{print "/"$(NF-1)"/"$NF}'|sed s/\\.git$//`
    #echo $ROOT
    if [ "$URL" == "$WATERMARK" ]; then
        FOUNDWATERMARK=true
        echo "FOUND WATERMARK"
    fi
  
    if [ "$FOUNDWATERMARK" == true ]; then 
        echo "SCANNING: ${URL}"
        git clone $URL data/repo 

        # Try and make this more efficient
        rm -rf data/repo/.* 2> /dev/null

        $BURPSCAN --dir data/repo --root "${ROOT}"
        rm -rf data/repo
        echo "DONE SCANNING: ${URL}"
        echo ${URL} > watermark

        if [ $MAX -eq 4000 ]; then
            exit
        fi
        let MAX=MAX+1

        if [ $COUNT -eq 20 ]; then
            echo "SLEEPING TO LET BURP CATCH UP MAYBE?"
            sleep  120
            COUNT=0
        fi
        sleep 1
        let COUNT=COUNT+1
    fi 
done
