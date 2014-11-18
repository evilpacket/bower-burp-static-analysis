# Overview
This was the result of being nerd snipped by @tomsteele into scanning bower with the [burp suite](http://portswigger.net/burp/) static analyzer.


## bower.json
List of packages (git urls) that were pulled from bower

## scan.sh
Used to clone each package and run the files using [burpstaticscan](https://github.com/tomsteele/burpstaticscan) into burp suite.

## log-scan-issue.js
Listens to burp and logs when an issue is found to a file

## raw_data/
Raw results from the scan

## output.nljson
raw results pushed into a newline json file that's easily imported into [dat](http://dat-data.com/)

## convert-to-dat.js
Used to convert raw_data into the new line json file.

Enjoy
