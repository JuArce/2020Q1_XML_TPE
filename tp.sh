#!/bin/bash
echo $1
echo $2
echo $3
echo $4

if (( $(echo "$3 < $1"| bc) || $(echo "$4 < $2"| bc) ))
then
    echo "Invalid parameters"
    exit
fi

curl "https://www.openstreetmap.org/api/0.6/map?bbox=${1},${2},${3},${4}" > "data.xml"

echo "fin"
