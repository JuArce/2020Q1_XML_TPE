#!/bin/bash
$1 -lt $3 | bc 
if [ $1 -lt $3 | -bc ]
then
    curl "https://www.openstreetmap.org/api/0.6/map?bbox=${1},${2},${3},${4}" > "data.xml"
fi
echo hola
