#!/bin/bash

west=${1#*=}
south=${2#*=}
east=${3#*=}
north=${4#*=}
echo "West: " $west
echo "South: " $south
echo "East: " $east
echo "North: " $north

if (( $(echo "$east < $west"| bc) || $(echo "$north < $south"| bc) ))
then
    echo "Invalid parameters."
    exit
fi

#curl "https://www.openstreetmap.org/api/0.6/map?bbox=${west},${south},${east},${north}" > "data.xml"
#curl "https://www.openstreetmap.org/api/0.6/map?bbox=-74.00,40.711,-73.99,40.73" > "data.xml"
echo "data.xml generated."

java net.sf.saxon.Query query_map.xq west=$west south=$south east=$east north=$north > intermediate.xml
echo "intermediate.xml generated."

java net.sf.saxon.Transform -s:./intermediate.xml -xsl:./convert_csv.xsl -o:output.csv

#rm ./data.xml
#rm ./intermediate.xml
#echo "Archivos intermedios eliminados"
echo "output.csv generated, check your directory."
