#!/bin/bash

west=${1#*=}
south=${2#*=}
east=${3#*=}
north=${4#*=}

curl "https://www.openstreetmap.org/api/0.6/map?bbox=${west},${south},${east},${north}" > "data.xml"
echo "data.xml generated."

java net.sf.saxon.Query query_map.xq west=$west south=$south east=$east north=$north > "intermediate.xml"
echo "intermediate.xml generated."

java net.sf.saxon.Transform -s:./intermediate.xml -xsl:./convert_csv.xsl -o:output.csv
echo "output.csv generated, check your directory."
echo "If 'output.csv' is empty, check the error output in 'intermediate.xml'."
